# 4. Calculating probabilities

...

## 4.1 Method #1: Neural networks (using a multilayer perceptron in Weka)

...

```bash
bundle exec rake weka:parse_results INPUT_FILE=weka-results/mlp.txt > results/mlp.csv
```

## 4.2 Method #2: K-nearest neighbours (again using Weka)

...

```bash
bundle exec rake weka:parse_results INPUT_FILE=weka-results/knn.txt > results/knn.csv
```

## 4.3 Method #3: Multiple linear regression (using R)

```bash
Rscript scripts/multiple_linear_regression.r > results/mlr.csv
```
