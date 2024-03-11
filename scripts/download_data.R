# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2023 March 10

# This script downloads the red wine quality dataset
# from the UCI Machine Learning Repository

# Usage: Rscript download_data.R

library(tidyverse)

main <- function() {
  wine_raw <- read_delim("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", delim = ";")
  new_names <- c("fixed_acidity", "volatile_acidity", "citric_acid",
                 "residual_sugar", "chlorides", "free_sulfur_dioxide",
                 "total_sulfur_dioxide", "density", "pH", "sulphates",
                 "alcohol", "quality")
  colnames(wine_raw) <- new_names
  write_csv(wine_raw, "data/wine_raw.csv")
}

main()