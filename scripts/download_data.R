# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2023 March 10

"This script downloads the red wine quality dataset and the basic EDA required 
from the UCI Machine Learning Repository

 Usage: scripts/download_data.R --input=<input> --out_dir=<out_dir>
 
 Options:
 --input=<input>       URL to raw data (https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv)
--out_dir=<out_dir>    Path to directory where the raw data should be stored as a .csv file
 " -> doc

library(tidyverse)
library(docopt)

opt <- docopt(doc)

main <- function(input, out_dir) {
  wine_raw <- read_delim(toString(input), delim = ";")
  new_names <- c("fixed_acidity", "volatile_acidity", "citric_acid",
                 "residual_sugar", "chlorides", "free_sulfur_dioxide",
                 "total_sulfur_dioxide", "density", "pH", "sulphates",
                 "alcohol", "quality")
  colnames(wine_raw) <- new_names
  write_csv(wine_raw, paste0(out_dir, "/wine_raw.csv"))
}

main(opt$input, opt$out_dir)