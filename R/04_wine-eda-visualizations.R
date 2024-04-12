# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 13

"This script creates the histogram and the correlation matrix used in the EDA section of the analysis.

Usage: R/wine_eda_visualizations.R --input=<input> --out_dir_hist=<out_dir_hist> --out_dir_corr=<out_dir_corr>

Options:
--input=<input>                 Path/filename to training data (csv file)
--out_dir_hist=<out_dir_hist>   Path/filename to directory where histogram plot should be written
--out_dir_corr=<out_dir_corr>   Path/filename to directory where correlation plot should be written
" -> doc

library(tidyverse)
library(tidymodels)
library(cowplot)
library(car)
library(corrplot)
library(docopt)
library(pRedictwine)

opt <- docopt(doc)

main <- function(input, out_dir_hist, out_dir_corr) {
  
  # Read in input file
  wine_training <- read_csv(input)
  
  # Converting quality as a categorical factor.
  wine_train_categorical <- wine_training %>%
    mutate(quality = as.factor(quality))
  
  # Setting font size.
  font_size = 10.5
  
  options(repr.plot.width = 60, repr.plot.height = 40)
  
  # Plotting a histogram of every input variable.
  fixed_acidity_hist <- create_histogram(df = wine_train_categorical,
                                         x = fixed_acidity,
                                         group = quality,
                                         x_lab = "Fixed acidity",
                                         y_lab = "Count",
                                         font_size = font_size)
  
  volatile_acidity_hist <- create_histogram(df = wine_train_categorical,
                                            x = volatile_acidity,
                                            group = quality,
                                            x_lab = "Volatile acidity",
                                            font_size = font_size)
  
  citric_acid_hist <- create_histogram(df = wine_train_categorical,
                                       x = citric_acid,
                                       group = quality,
                                       x_lab = "Citric acid",
                                       font_size = font_size)
  
  residual_sugar_hist <- create_histogram(df = wine_train_categorical,
                                          x = residual_sugar,
                                          group = quality,
                                          x_lab = "Residual Sugar",
                                          font_size = font_size)
  
  chlorides_hist <- create_histogram(df = wine_train_categorical,
                                     x = chlorides,
                                     group = quality,
                                     x_lab = "Chlorides",
                                     y_lab = "Count",
                                     font_size = font_size)
  
  free_sulfur_dioxide_hist <- create_histogram(df = wine_train_categorical,
                                               x = free_sulfur_dioxide,
                                               group = quality,
                                               x_lab = "Free sulfur dioxide",
                                               font_size = font_size)
  
  total_sulfur_dioxide_hist <- create_histogram(df = wine_train_categorical,
                                                x = total_sulfur_dioxide,
                                                group = quality,
                                                x_lab = "Total sulfur dioxide",
                                                font_size = font_size)
  
  
  density_hist <- create_histogram(df = wine_train_categorical,
                                   x = density,
                                   group = quality,
                                   x_lab = "Density",
                                   font_size = font_size)
  
  pH_hist <- create_histogram(df = wine_train_categorical,
                              x = pH,
                              group = quality,
                              x_lab = "pH",
                              y_lab = "Count",
                              font_size = font_size)
  
  sulphates_hist <- create_histogram(df = wine_train_categorical,
                                     x = sulphates,
                                     group = quality,
                                     x_lab = "Sulphates",
                                     font_size = font_size)
  
  alcohol_hist <- create_histogram(df = wine_train_categorical,
                                   x = alcohol,
                                   group = quality,
                                   x_lab = "Alcohol",
                                   font_size = font_size)
  
  # Plotting a histogram plot of the response variable, quality.
  quality_hist <- wine_training %>%
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
  ggsave(file.path(out_dir_hist), histogram)
  
  # Creating the correlation matrix
  wine_cors <- cor(wine_training)
  
  # Change variable labels
  colnames(wine_cors) <- c("Fixed acidity", "Volatile acidity", "Citric acid", "Residual sugar", "Chlorides",
                           "Free sulfur dioxide", "Total sulfur dioxide", "Density", "pH", "Sulphates",
                           "Alcohol", "Quality")
  row.names(wine_cors) <- c("Fixed acidity", "Volatile acidity", "Citric acid", "Residual sugar", "Chlorides",
                            "Free sulfur dioxide", "Total sulfur dioxide", "Density", "pH", "Sulphates",
                            "Alcohol", "Quality")
  
  # Plot correlation matrix, save as png
  png(height=800, width = 800, file = file.path(out_dir_corr), type = "cairo")
  corr_plot <- corrplot(wine_cors, method = 'number',
                        mar=c(0,0,3,0), number.cex=1.5)
  dev.off()
}

main(opt$input, opt$out_dir_hist, opt$out_dir_corr)
