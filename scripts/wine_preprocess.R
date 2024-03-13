# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2023 March 13

"This script conducts the splitting of the data
into training and testing datasets.

Usage: Rscript src/wine_preprocess.R --input=<input> --out_dir=<out_dir>
" -> doc

library(tidyverse)
library(docopt)

# Setting the seed.
set.seed(7)

oct <- docopt(doc)

splitting <- function(input, out_dir) {
  # Read in the raw dataset
  wine <- read.csv(input)
  
  # Splitting the data into 75% training and 25% testing.
  wine_split <- initial_split(wine, prop = 0.75, strata = quality)
  wine_train <- training(wine_split)
  wine_test <- testing(wine_split)
  
  # write training and test data to csv files
  write_csv(wine_train, paste0(out_dir, "/training.csv"))
  write_csv(wine_test, paste0(out_dir, "/test.csv"))
  
  # Create a few EDA summary statistics, save into an RDS file
  summary_stats <- data.frame(train_nrow = nrow(wine_train),
                              test_nrow = nrow(wine_test),
                              num_nas = sum(is.na(wine)))
  try({
    dir.create(out_dir)
  })
  saveRDS(summary_stats, file = paste0(out_dir, "/summary_stats.rds"))

}

splitting(opt[["--input"]], opt[["--out_dir"]])
