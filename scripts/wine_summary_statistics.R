# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script creates summary statistics and some figures that will
be used in the document. Histograms are in a separate document.

Usage: Rscript scripts/wine_summary_statistics.R --train=<train> --test=<test> --out_dir=<out_dir>

Options:
--train=<train>       Path (including filename) raw training data (csv file)
--test=<test>         Path (including filename) raw testing data (csv file)
--out_dir=<out_dir>   Path to directory where the processed data should be written
" -> doc

library(tidyverse)
library(tidymodels)
library(cowplot)
library(car)
library(corrplot)
library(docopt)

oct <- docopt(doc)

create_summaries <- function(train, test, out_dir) {
  
  # Create a few EDA summary statistics, save into an RDS file
  summary_counts <- data.frame(train_nrow = nrow(train),
                              test_nrow = nrow(test),
                              num_nas = sum(is.na(train)) + sum(is.na(test)))
  
  # Means for each level of response variable "quality"
  response_means <- train %>%
    mutate(quality = as.factor(quality)) %>%
    group_by(quality) %>%
    summarise_all(mean)
  
  try({
    dir.create(out_dir)
  })
  saveRDS(summary_counts, file = paste0(out_dir, "/summary_counts.rds"))
  saveRDS(summary(train), file = paste0(out_dir, "/summary_statistics.rds"))
  saveRDS(response_means, file = paste0(out_dir, "/response_means.rds"))
  
}

create_summaries(opt[["--train"]], opt[["--test"]], opt[["--out_dir"]])