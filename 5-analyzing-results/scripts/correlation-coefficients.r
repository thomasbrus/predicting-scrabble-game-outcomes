# Import Scrabble turns from CSV file
turns <- read.csv("../3-exporting-features/data/turns.csv", header = T)

# Calculate how much the features are correlated to the final score difference
for (columnName in names(turns)) {
  if (columnName != 'final_turn' && columnName != 'outcome') {
    correlation <- cor(turns[[columnName]], turns$final_score_difference)
    # $first\_player\_current\_score$ & 0.2061 \\ \hline
    print(paste('$', columnName, '$', ' & ', correlation, ' \\\\ ', ' \\hline',sep=''))
  }
}
