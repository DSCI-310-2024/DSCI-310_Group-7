# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script conducts the splitting of the data into training and testing datasets.

Usage: scripts/wine_preprocess.R --input=<input> --out_dir=<out_dir>

Options:
--input=<input>       Path (including filename) to raw data (csv file)
--out_dir=<out_dir>   Path to directory where the processed data should be written
" -> doc

library(tidyverse)
library(tidymodels)
library(docopt)

# Setting the seed.
set.seed(7)

opt <- docopt(doc)

main <- function(input, out_dir) {
  # Read in the raw dataset
  wine <- read_csv(input)
  
  # Splitting the data into 75% training and 25% testing.
  wine_split <- initial_split(wine, prop = 0.75, strata = quality)
  wine_train <- training(wine_split)
  wine_test <- testing(wine_split)
  
  # write training and test data to csv files
  write_csv(wine_train, paste0(out_dir, "/training.csv"))
  write_csv(wine_test, paste0(out_dir, "/testing.csv"))
}

splitting(opt$input, opt$out_dir)
