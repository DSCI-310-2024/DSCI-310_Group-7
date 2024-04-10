# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script takes the created model and tests it on the testing data. Produces accuracy metrics and a visualization

Usage: R/wine_test_model.R --input=<input> --model=<model> --out_dir_acc=<out_dir_acc> --out_dir_qq=<out_dir_qq>

Options:
--input=<input>               Path (including filename) to testing data (csv file)
--model=<model>               Path (including filename) to linear model (rds file)
--out_dir_acc=<out_dir_acc>   Path to directory where the accuracy metrics should be stored
--out_dir_qq=<out_dir_qq>     Path to directory where the QQ plot should be stored
" -> doc

library(tidyverse)
library(tidymodels)
library(car)
library(docopt)


opt <- docopt(doc)

main <- function(input, model, out_dir_acc, out_dir_qq) {
  
  # Read in testing data
  wine_test <- read_csv(input)
  
  # Read the model
  wine_lm_fit <- readRDS(model)
  
  # Finding the RMSPE, R^2, and MAE.
  wine_lm_test_results <- wine_lm_fit %>%
    predict(wine_test) %>%
    bind_cols(wine_test) %>%
    metrics(truth = quality, estimate = .pred)
  write_csv(wine_lm_test_results, file.path(out_dir_acc))
  
  # Obtaining residuals
  wine_lm_test_preds <- wine_lm_fit %>%
    predict(wine_test) %>%
    bind_cols(wine_test) %>%
    mutate(resid = quality - .pred)
  
  # Plotting the QQ plot
  png(height=800, width = 800, file = file.path(out_dir_qq), type = "cairo")
  wine_qqplot <- qqPlot(wine_lm_test_preds$resid,
                       xlab = "Theoretical Quantiles",
                       ylab = "Sample Quantiles")
  dev.off()
}

main(opt$input, opt$model, opt$out_dir_acc, opt$out_dir_qq)