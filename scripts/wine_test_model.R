# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script takes the created model and tests it on the testing data. Produces accuracy metrics and a visualization

Usage: scripts/wine_test_model.R --input=<input> --model=<model> --out_dir=<out_dir>

Options:
--input=<input>       Path (including filename) to testing data (csv file)
--model=<model>       Path (including filename) to linear model (rds file)
--out_dir=<out_dir>   Path to directory where the model should be written to
" -> doc

library(tidyverse)
library(tidymodels)
library(car)
library(docopt)


opt <- docopt(doc)

test_model <- function(input, model, out_dir) {
  
  # Read in testing data
  wine_test <- read_csv(input)
  
  # Read the model
  wine_lm_fit <- readRDS(model)
  
  # Finding the RMSPE, R^2, and MAE.
  wine_lm_test_results <- wine_lm_fit %>%
    predict(wine_test) %>%
    bind_cols(wine_test) %>%
    metrics(truth = quality, estimate = .pred)
  
  # Obtaining residuals
  wine_lm_test_preds <- wine_lm_fit %>%
    predict(wine_test) %>%
    bind_cols(wine_test) %>%
    mutate(resid = quality - .pred)
  
  # Plotting the QQ plot
  png(height=800, width = 800, file = "results/qqplot.png", type = "cairo")
  wine_qqplot <- qqPlot(wine_lm_test_preds$resid,
                       xlab = "Theoretical Quantiles",
                       ylab = "Sample Quantiles")
  dev.off()
  # Save objects into RDS files
  try({
    dir.create(out_dir)
  })
  saveRDS(wine_lm_test_results, file = paste0(out_dir, "/wine_lm_test_results.rds"))
  saveRDS(wine_qqplot, file = paste0(out_dir, "/wine_qqplot.rds"))
  
}

test_model(opt$input, opt$model, opt$out_dir)