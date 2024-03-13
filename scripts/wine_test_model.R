# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script takes the created model and tests it on the testing data.
Produces accuracy metrics and a visualization

Usage: Rscript scripts/wine_test_model.R --input=<input> --out_dir=<out_dir>

Options:
--input=<input>       Path (including filename) to testing data (csv file)
--out_dir=<out_dir>   Path to directory where the model should be written to
" -> doc

oct <- docopt(doc)

test_model <- function(input, out_dir) {
  
  # Read the model
  wine_lm_fit <- readRDS("results/wine_lm_fit.rds")
  
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
  wine_qqplot <- qqPlot(wine_lm_test_preds$resid,
                       main = "QQ Plot of Residuals",
                       xlab = "Theoretical Quantiles",
                       ylab = "Sample Quantiles")
  
  # Save objects into RDS files
  try({
    dir.create(out_dir)
  })
  saveRDS(wine_lm_test_results, file = paste0(out_dir, "/wine_lm_test_results.rds"))
  saveRDS(wine_qqplot, file = paste0(out_dir, "/wine_qqplot.rds"))
  
}

test_model(opt[["--input"]], opt[["--out_dir"]])