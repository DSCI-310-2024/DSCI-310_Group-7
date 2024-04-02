library(tidyverse)

# creating a simple dataset

simple_dataset <- tibble(speed = cars$speed,
                         group = c(rep("A", 5), rep("B", 10), rep("C", 10), rep("D", 10), rep("E", 10), rep("F", 5)))

# creating a simple histogram, values all filled in
simple_histogram <- ggplot(aes(x = speed), data = simple_dataset) +
  geom_histogram(aes(color = group, fill = group)) + 
  xlab("Speed") +
  ylab("Count") +
  theme(text = element_text(size=12.5),
        legend.position="none")

# creating a simple histogram with default values in function
simple_histogram_default_settings <- ggplot(aes(x = speed), data = simple_dataset) +
  geom_histogram(aes(color = group, fill = group)) +
  xlab("") +
  ylab("") +
  theme(text = element_text(size=10.5),
        legend.position="none")
