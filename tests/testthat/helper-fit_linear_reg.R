library(tidyverse)
library(tidymodels)

# Sample dataframe
set.seed(310)
quality <- sample(0:10, 10, replace = TRUE)
x1 <- rnorm(10, mean = 20, sd = 2)
x2 <- rnorm(10, mean = 20, sd = 2)
x3 <- rnorm(10, mean = 20, sd = 2)
correct_df <- data.frame(quality, x1, x2, x3)

# Sample linear regression output
lm_spec <- linear_reg() %>%
  set_engine("lm") %>%
  set_mode("regression")
test_lm_recipe <- recipe(quality ~ ., data = correct_df)
test_lm_fit <- workflow() %>%
  add_recipe(test_lm_recipe) %>%
  add_model(lm_spec) %>%
  fit(data = correct_df)

# Sample object inside output 
test_coeffs <- test_lm_fit %>%
  extract_fit_parsnip()

# Sample empty input
empty_df <- data.frame(quality = character(0))