# Randomly divides the dataframe into two equally large groups
splitData <- function(dataframe, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)

  index <- 1:nrow(dataframe)
  trainingSetIndex <- sample(index, trunc(length(index) / 2))

  trainingSet <- dataframe[trainingSetIndex, ]
  testSet <- dataframe[-trainingSetIndex, ]

  list(trainingSet=trainingSet, testSet=testSet)
}

# .............................................................................

# Import scrabble turns from CSV file
turns <- read.csv("../3-exporting-features/data/all-turns.csv", header = T)

# Split the data set
splittedTurns <- splitData(turns)

# Extract both splits into variables
trainingSet <- splittedTurns$trainingSet
testSet <- splittedTurns$testSet

# Setup a linear model that can predict the final score difference
turns.lm <- lm(final_score_difference ~ first_player_current_score + second_player_current_score +
               first_player_average_score + second_player_average_score + first_player_rating +
               second_player_rating + first_player_number_of_bingos + second_player_number_of_bingos +
               first_player_average_number_of_bingos + second_player_average_number_of_bingos +
               number_of_tiles_left + first_player_number_of_turns + second_player_number_of_turns +
               progress + first_player_rack_blanks + second_player_rack_blanks +
               first_player_rack_value + second_player_rack_value, data=trainingSet)

summaryOutput <- summary(turns.lm)

estimateProbability <- function(model, turn) {
  turn.prediction <- predict.lm(model, turn, interval="predict", se.fit=TRUE)

  standardErrorFitted <- turn.prediction$se.fit
  standardError <- turn.prediction$residual.scale
  degreesOfFreedom <- turn.prediction$df

  predictedValue <- turn.prediction$fit[[1]]
  tValue <- abs(predictedValue) / (sqrt(standardErrorFitted ^ 2 + standardError ^ 2))

  lwr <- predictedValue - (tValue * sqrt(standardErrorFitted ^ 2 + standardError ^ 2))
  upr <- predictedValue + (tValue * sqrt(standardErrorFitted ^ 2 + standardError ^ 2))

  pValue <- 1 - (1 - pt(tValue, degreesOfFreedom)) * 2

  estimatedProbability <- pValue + (1 - pValue) / 2

  # Invert the probability if it is predicted that the first player
  # ends with less points than the second player
  if (predictedValue >= 0) {
    estimatedProbability
  } else {
    1 - estimatedProbability
  }
}

# Create a duplicate of the test set that includes predicted outcomes
resultSet <- testSet

resultSet['predicted_outcome'] <- NA
resultSet['first_player_probability'] <- NA
resultSet['second_player_probability'] <- NA
names(resultSet)[names(resultSet) == 'outcome'] <- 'actual_outcome'

for (i in 1:nrow(testSet)) {
  estimatedProbability <- estimateProbability(turns.lm, testSet[i, ])
  predictedOutcome <- if (estimatedProbability >= 0.5) 'true' else 'false'

  resultSet[i, ]$predicted_outcome <- predictedOutcome
  resultSet[i, ]$first_player_probability <- estimatedProbability
  resultSet[i, ]$second_player_probability <- 1 - estimatedProbability
}

write.csv(resultSet, row.names=FALSE)

