library(tidyverse)

# creating a simple dataset

simple_dataset <- tibble(speed = cars$speed,
                         group = c(rep("A", 5), rep("B", 10), rep("C", 10), rep("D", 10), rep("E", 10), rep("F", 5)))
simple_dataset

# creating a simple histogram
simple_histogram <- create_histogram(df = simple_dataset,
                                     x = speed,
                                     group = group,
                                     x_lab = "Speed",
                                     y_lab = "Count",
                                     font_size = 12.5)

simple_histogram_default_settings <- create_histogram(df = simple_dataset,
                                                      x = speed,
                                                      group = group)
