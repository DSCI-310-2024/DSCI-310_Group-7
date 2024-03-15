# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script conducts the multivariate regression for this analysis, and stores the results in in RDA files.

Usage: R/wine_modelling.R --input=<input> --out_dir_lm=<out_dir_lm> --out_dir_coef=<out_dir_coef>

Options:
--input=<input>                 Path (including filename) to training data (csv file)
--out_dir_lm=<out_dir_lm    >   Path/filename to directory where the model should be written to as an RDS object
--out_dir_coef=<out_dir_coef>   Path/filename to directory where the model's coefficients should be written to
" -> doc

library(tidyverse)
library(tidymodels)
library(cowplot)
library(car)
library(corrplot)
library(docopt)

opt <- docopt(doc)

create_model <- function(input, out_dir_lm, out_dir_coef) {
  
  # Read in input
  training <- read_csv(input)
  
  # Specify model
  lm_spec <- linear_reg() %>%
    set_engine("lm") %>%
    set_mode("regression")
  
  # Setting up the recipe.
  wine_lm_recipe <- recipe(quality ~ ., data = training)
  
  # Training the model.
  wine_lm_fit <- workflow() %>%
    add_recipe(wine_lm_recipe) %>%
    add_model(lm_spec) %>%
    fit(data = training)
  
  # Pulling information of the coefficients in a tibble.
  wine_coeffs <- wine_lm_fit %>%
    extract_fit_parsnip() %>%
    tidy()
  
  # Save objects
  write_csv(wine_coeffs, file.path(out_dir_coef))
  saveRDS(wine_lm_fit, file.path(out_dir_lm))
}
  
create_model(opt$input, opt$out_dir_lm, opt$out_dir_coef)