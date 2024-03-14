# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script conducts the multivariate regression for this analysis, and stores
the results in in RDA files.

Usage: Rscript scripts/wine_modelling.R --input=<input> --out_dir=<out_dir>

Options:
--input=<input>       Path (including filename) to training data (csv file)
--out_dir=<out_dir>   Path to directory where the model should be written to
" -> doc

library(tidyverse)
library(tidymodels)
library(cowplot)
library(car)
library(corrplot)
library(docopt)

oct <- docopt(doc)

create_model <- function(input, out_dir) {
  
  lm_spec <- linear_reg() %>%
    set_engine("lm") %>%
    set_mode("regression")
  
  # Setting up the recipe.
  wine_lm_recipe <- recipe(quality ~ ., data = input)
  
  # Training the model.
  wine_lm_fit <- workflow() %>%
    add_recipe(wine_lm_recipe) %>%
    add_model(lm_spec) %>%
    fit(data = input)
  
  # Pulling information of the coefficients in a tibble.
  wine_coeffs <- wine_lm_fit %>%
    extract_fit_parsnip() %>%
    tidy()
  
  # Save objects into RDS files
   try({
    dir.create(out_dir)
  })
  saveRDS(wine_lm_fit, file = paste0(out_dir, "/wine_lm_fit.rds"))
  saveRDS(wine_coeffs, file = paste0(out_dir, "/wine_coeffs.rds"))
  
}

create_model(opt[["--input"]], opt[["--out_dir"]])