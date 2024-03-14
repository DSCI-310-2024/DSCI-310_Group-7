# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script creates the histogram and the correlation matrix used in the EDA section of the analysis.

Usage: scripts/wine_eda_visualizations.R --input=<input> --out_dir=<out_dir>

Options:
--input=<input>       Path (including filename) to training data (csv file)
--out_dir=<out_dir>   Path to directory where the visualizations should be written
" -> doc

library(tidyverse)
library(tidymodels)
library(cowplot)
library(car)
library(corrplot)
library(docopt)

opt <- docopt(doc)

create_visualizations <- function(input, out_dir) {
  
  # Read in input file
  wine_train <- read_csv(input)
  
  # Converting quality as a categorical factor.
  wine_train_categorical <- wine_train %>%
    mutate(quality = as.factor(quality))
  
  # Setting font size.
  font_size = 10.5
  
  options(repr.plot.width = 60, repr.plot.height = 40)
  
  # Plotting a histogram of every input variable.
  fixed_acidity_hist <- wine_train_categorical %>%
    ggplot(aes(x = fixed_acidity)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Fixed acidity")+
    theme(text = element_text(size=font_size),
          legend.position="none")
  
  volatile_acidity_hist <- wine_train_categorical %>%
    ggplot(aes(x = volatile_acidity)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Volatile acidity")+
    theme(text = element_text(size=font_size),
          legend.position="none",
          axis.title.y = element_blank())
  
  citric_acid_hist <- wine_train_categorical %>%
    ggplot(aes(x = citric_acid)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Citric acid")+
    theme(text = element_text(size=font_size),
          legend.position="none",
          axis.title.y = element_blank())
  
  residual_sugar_hist <- wine_train_categorical %>%
    ggplot(aes(x = residual_sugar)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Residual sugar")+
    theme(text = element_text(size=font_size),
          legend.position="none",
          axis.title.y = element_blank())
  
  chlorides_hist <- wine_train_categorical %>%
    ggplot(aes(x = chlorides)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Chlorides")+
    theme(text = element_text(size=font_size),
          legend.position="none")
  
  free_sulfur_dioxide_hist <- wine_train_categorical %>%
    ggplot(aes(x = free_sulfur_dioxide)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Free sulfur dioxide")+
    theme(text = element_text(size=font_size),
          legend.position="none",
          axis.title.y = element_blank())
  
  total_sulfur_dioxide_hist <- wine_train_categorical %>%
    ggplot(aes(x = total_sulfur_dioxide)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Total sulfur dioxide")+
    theme(text = element_text(size=font_size),
          legend.position="none",
          axis.title.y = element_blank())
  
  density_hist <- wine_train_categorical %>%
    ggplot(aes(x = density)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Density")+
    theme(text = element_text(size=font_size),
          legend.position="none",
          axis.title.y = element_blank())
  
  pH_hist <- wine_train_categorical %>%
    ggplot(aes(x = pH)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("pH")+
    theme(text = element_text(size=font_size),
          legend.position="none")
  
  sulphates_hist <- wine_train_categorical %>%
    ggplot(aes(x = sulphates)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Sulphates")+
    theme(text = element_text(size=font_size),
          legend.position="none",
          axis.title.y = element_blank())
  
  alcohol_hist <- wine_train_categorical %>%
    ggplot(aes(x = alcohol)) +
    geom_histogram(aes(color = quality, fill = quality)) + 
    xlab("Alcohol")+
    theme(text = element_text(size=font_size),
          legend.position="none",
          axis.title.y = element_blank())
  
  # Plotting a histogram plot of the response variable, quality.
  quality_hist <- wine_train %>%
    ggplot(aes(x = quality)) +
    geom_histogram(aes(fill = as.factor(quality))) + 
    xlab("Quality")+
    theme(text = element_text(size=font_size),
          axis.title.y = element_blank())+
    labs(fill = "Quality")
  
  # Adding it all together.
  hists <- plot_grid(fixed_acidity_hist, volatile_acidity_hist, citric_acid_hist, residual_sugar_hist, 
                     chlorides_hist, free_sulfur_dioxide_hist, total_sulfur_dioxide_hist, density_hist, 
                     pH_hist, sulphates_hist, alcohol_hist, quality_hist + theme(legend.position="none"),
                     ncol=4, nrow =3)
  
  # Adding a title.
  # title_hist <- ggdraw() +
  #   draw_label(
  #     "Figure 2. Histogram of the input variables, color-coded by their respective quality. In the last plot, histogram of each wine quality.",
  #     fontface = 'bold', x = 0, hjust = 0, size = font_size + 8) +
  #   theme(plot.margin = margin(0, 0, 0, 7)) # alignment
  
  # Adding a common legend.
  legend_hist <- get_legend(quality_hist + theme(legend.box.margin = margin(0, 0, 0, 3),
                                                 legend.key.size = unit(1, 'cm'),
                                                 legend.title = element_text(size = font_size)))
  
  # Putting the whole model together
  histogram <- plot_grid(
                  hists,
                  legend_hist,
                  rel_widths = c(4, .4)
  )
  
  # Save the histograms as png
  ggsave("results/histogram.png", histogram)
  
  # Creating the correlation matrix
  wine_cors <- cor(wine_train)
  
  # Change variable labels
  colnames(wine_cors) <- c("Fixed acidity", "Volatile acidity", "Citric acid", "Residual sugar", "Chlorides",
                           "Free sulfur dioxide", "Total sulfur dioxide", "Density", "pH", "Sulphates",
                           "Alcohol", "Quality")
  row.names(wine_cors) <- c("Fixed acidity", "Volatile acidity", "Citric acid", "Residual sugar", "Chlorides",
                            "Free sulfur dioxide", "Total sulfur dioxide", "Density", "pH", "Sulphates",
                            "Alcohol", "Quality")
  
  # Plot correlation matrix, save as png
  png(height=800, width = 800, file = "results/corrplot.png", type = "cairo")
  corr_plot <- corrplot(wine_cors, method = 'number',
                        mar=c(0,0,3,0), number.cex=1.5)
  dev.off()
  
  # Save visualizations into RDS files
  try({
    dir.create(out_dir)
  })
  saveRDS(histogram, file = paste0(out_dir, "/eda_hists.rds"))
  saveRDS(corr_plot, file = paste0(out_dir, "/corrplot.rds"))
  
}

create_visualizations(opt$input, opt$out_dir)