# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script conducts the splitting of the data into training and testing datasets.

Usage: R/wine_preprocess.R --input=<input> --out_dir_train=<out_dir_train>  --out_dir_test=<out_dir_test>

Options:
--input=<input>                   Path/filename to raw data (csv file)
--out_dir_train=<out_dir_train>   Path/filename to directory where the training data should be written
--out_dir_test=<out_dir_test>     Path/filename to directory where the testing data should be written
" -> doc

library(tidyverse)
library(tidymodels)
library(docopt)

# Setting the seed.
set.seed(7)

opt <- docopt(doc)

main <- function(input, out_dir_train, out_dir_test) {
  # Read in the raw dataset
  wine_processed <- read_csv(input)
  
  # Splitting the data into 75% training and 25% testing.
  wine_split <- initial_split(wine_processed, prop = 0.75, strata = quality)
  wine_training <- training(wine_split)
  wine_testing <- testing(wine_split)
  
  # write training and test data to csv files
  write_csv(wine_training, file.path(out_dir_train))
  write_csv(wine_testing, file.path(out_dir_test))
}

main(opt$input, opt$out_dir_train, opt$out_dir_test)
