# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script creates summary statistics and some figures that will
be used in the document. Histograms are in a separate document.

Usage: Rscript scripts/wine_summary_statistics.R --input=<input> --output=<output> --out_dir=<out_dir>
" -> doc

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

create_summaries(opt[["--input"]], opt[["--output"]], opt[["--out_dir"]])