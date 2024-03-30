library(testthat)
source("../../R/fit_linear_reg.R")
library(tidyverse)
library(tidymodels)

test_that("`fit_linear_reg` should return a fitted linear regression model 
          object containing fitted model objects", {
  expect_s3_class(fit_linear_reg(quality ~ ., correct_df), "workflow")
  expect_equal(fit_linear_reg(quality ~ ., correct_df), test_lm_fit)
  expect_equal(fit_linear_reg(quality ~ ., correct_df), test_lm_fit)
  expect_equal(workflowsets::extract_fit_parsnip(
    fit_linear_reg(quality ~ ., correct_df)), test_coeffs)
})

test_that("`fit_linear_reg` should throw an error when incorrect types 
are passed to `formula` and `data_frame` arguments", {
  expect_error(fit_linear_reg("hi", correct_df))
  expect_error(fit_linear_reg(quality ~ ., "hi"))
  expect_error(fit_linear_reg(0, correct_df))
  expect_error(fit_linear_reg(quality ~ ., 0))
  expect_error(fit_linear_reg(c(1, 2, 3, 4), correct_df))
  expect_error(fit_linear_reg(quality ~ ., c(1, 2, 3, 4)))
})

test_that("`fit_linear_reg` should throw an error when empty data is passed 
to `data_frame` arguments", {
  expect_error(fit_linear_reg(quality ~ ., empty_df))
})