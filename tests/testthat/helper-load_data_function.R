library(tidyverse)

# creating a simple dataset
col_1 <- c(0, 1, 2, 3, 4)
col_2 <- c(5, 6, 7, 8, 9)
col_3 <- c(10, 11, 12, 13, 14)
col_4 <- c(15, 16, 17, 18, 19)

simple_dataset <- tibble(col_1, col_2, col_3, col_4)
write_csv(simple_dataset, "tests/testthat/simple_dataset.csv")

# creating an empty dataset with only column names
col_0 <- c()
col_01 <- c()
empty_dataset <- tibble(col_0 = col_0, col_01 = col_01)
write_csv(empty_dataset, "tests/testthat/empty_dataset.csv")

# creating a dataset with only one column
one_dataset <- tibble(col_1)
write_csv(one_dataset, "tests/testthat/one_dataset.csv")
