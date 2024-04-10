library(testthat)
library(tidyverse)
library(vdiffr)
source("../../R/create_histogram.R")

test_that("Function should produce an error if incorrect types are passed into each of the arguments", {

  expect_error(create_histogram(df="yo", x=speed, group=group))

  plot2 <- create_histogram(df=simple_dataset, x="wassup", group=group)
  expect_error(print(plot2))
  
  plot3 <- create_histogram(df=simple_dataset, x=speed, group=gamers)
  expect_error(print(plot3))

  plot4 <- create_histogram(df=simple_dataset, x=speed, group=group, x_lab = df)
  expect_error(print(plot4))
  
  plot5 <- create_histogram(df=simple_dataset, x=speed, group=group, font_size = "no")
  expect_error(print(plot5))
}) 

test_that("Function should return a ggplot", {
  expect_s3_class(simple_histogram, "ggplot")
})

test_that("Plot should use geom_bar and map x to x-axis, and the grouping are of the same colours", {
  expect_true("GeomBar" %in% c(class(simple_histogram$layers[[1]]$geom)))
  expect_true("speed" == rlang::get_expr(simple_histogram$mapping$x))
})

test_that("Plot should be using the same data as the data inputted", {
  expect_equal(simple_histogram$data, simple_dataset)
})

test_that("Plot should not be affected by refactoring", {
  expect_doppelganger("create histogram", simple_histogram)
})

test_that("Plot should have all customized values", {
  expect_equal(simple_histogram$theme$text$size, 12.5)
  expect_equal(simple_histogram$labels$x, "Speed")
  expect_equal(simple_histogram$labels$y, "Count")
})

test_that("Default settings plot should have all default values", {
  expect_equal(simple_histogram_default_settings$theme$text$size, 10.5)
  expect_equal(simple_histogram_default_settings$labels$x, "")
  expect_equal(simple_histogram_default_settings$labels$y, "")
})

test_that("Colours chosen for the different groups should still remain the same", {
  expect_equal("#F8766D", unique(ggplot_build(simple_histogram)$data[[1]][,1])[1])
  expect_equal("#B79F00", unique(ggplot_build(simple_histogram)$data[[1]][,1])[2])
  expect_equal("#00BA38", unique(ggplot_build(simple_histogram)$data[[1]][,1])[3])
  expect_equal("#00BFC4", unique(ggplot_build(simple_histogram)$data[[1]][,1])[4])
  expect_equal("#619CFF", unique(ggplot_build(simple_histogram)$data[[1]][,1])[5])
  expect_equal("#F564E3", unique(ggplot_build(simple_histogram)$data[[1]][,1])[6])
})

