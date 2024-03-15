# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 14

"This script creates summary statistics that will be used in the document.

Usage: R/wine_summary_statistics.R --train=<train> --out_dir=<out_dir>

Options:
--train=<train>       Path (including filename) raw training data (csv file)
--out_dir=<out_dir>   Path/filename prefix where to write the figure to and what to call it
" -> doc

library(tidyverse)
library(tidymodels)
library(cowplot)
library(car)
library(corrplot)
library(docopt)

opt <- docopt(doc)

create_summaries <- function(train, out_dir) {
  
  # Load in training and testing data
  training <- read_csv(train)

  # Means for each level of response variable "quality"
  response_means <- training %>%
    mutate(quality = as.factor(quality)) %>%
    group_by(quality) %>%
    summarise_all(mean)
  write_csv(response_means, file.path(out_dir))
}

create_summaries(opt$train, opt$out_dir)