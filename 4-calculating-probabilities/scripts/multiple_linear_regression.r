# Import Scrabble turns from CSV file
turns <- read.csv("../3-exporting-features/data/turns.csv", header = T)

# Split the data set
splitIndex <- floor((2 / 3) * nrow(turns))
trainingSet <- turns[1:splitIndex, ]
testSet <- turns[(splitIndex + 1):nrow(turns), ]

# Setup a linear model that can predict the final score difference
turns.lm <- lm(final_score_difference ~ first_player_current_score + second_player_current_score +
               first_player_average_score + second_player_average_score +
               first_player_rating + second_player_rating +
               first_player_number_of_bingos + second_player_number_of_bingos +
               first_player_average_number_of_bingos + second_player_average_number_of_bingos +
               number_of_tiles_left + first_player_number_of_turns + second_player_number_of_turns +
               progress + first_player_rack_blanks + second_player_rack_blanks +
               first_player_rack_value + second_player_rack_value, data=trainingSet)


summaryOutput <- summary(turns.lm)

# Function that estimates the probability that the first player wins
# a scrabble game based on a linear model and a specific scrabble turn
estimateProbability <- function(model, turn) {
  turn.prediction <- predict.lm(model, turn, interval="predict", se.fit=TRUE)

  standardErrorFitted <- turn.prediction$se.fit
  standardError <- turn.prediction$residual.scale
  degreesOfFreedom <- turn.prediction$df

  # Extract the predicted difference in final scores of both players
  predictedValue <- turn.prediction$fit[[1]]
  
  # This value refers to the t-value used in a Student's t-distribution
  # See http://en.wikipedia.org/wiki/Student%27s_t-distribution
  # The t-value is chosen such that the interval around the predicted value touches zero
  # at either the beginning or the end
  tValue <- abs(predictedValue) / (sqrt(standardErrorFitted ^ 2 + standardError ^ 2))

  # Calculate the interval (lower and upper)
  # Either the lower bound or the upper bound is zero
  lwr <- predictedValue - (tValue * sqrt(standardErrorFitted ^ 2 + standardError ^ 2))
  upr <- predictedValue + (tValue * sqrt(standardErrorFitted ^ 2 + standardError ^ 2))

  # This basically looks up the two-sided probability that the final score
  # will be within the calculated interval
  pValue <- 1 - (1 - pt(tValue, degreesOfFreedom)) * 2

  # ...
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

