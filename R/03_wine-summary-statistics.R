# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 14

"This script creates summary statistics that will be used in the document.

Usage: R/wine_summary_statistics.R --train=<train> --out_dir=<out_dir>

Options:
--train_dataset=<train_daataset>       Path (including filename) raw training data (csv file)
--out_dir=<out_dir>                    Path/filename prefix where to write the figure to and what to call it
" -> doc

library(tidyverse)
library(tidymodels)
library(cowplot)
library(car)
library(corrplot)
library(docopt)

opt <- docopt(doc)

main <- function(train_dataset, out_dir) {
  
  # Load in training and testing data
  wine_training <- read_csv(train_dataset)

  # Means for each level of response variable "quality"
  wine_response_means <- wine_training %>%
    mutate(quality = as.factor(quality)) %>%
    group_by(quality) %>%
    summarise_all(mean)
  write_csv(wine_response_means, file.path(out_dir))
}

main(opt$train, opt$out_dir)