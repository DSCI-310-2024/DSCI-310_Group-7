# Wine quality Analysis Data Pipe
# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 15


# Download Data
data/wine_raw.csv: R/download_data.R
	Rscript R/download_data.R --input=https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv --out_dir=data/wine_raw.csv

# Preprocess Data
results/wine_training.csv results/wine_testing.csv: R/wine_preprocses.R data/wine_raw.csv
	Rscript R/wine_preprocess.R --input=data/wine_raw.csv --out_dir_train=results/wine_training.csv --out_dir_test=results/wine_testing.csv

# Generate Summary Statistics
results/response_means.csv: R/wine_summary_statistics.r results/wine_training.csv
	Rscript R/wine_summary_statistics.R --train=results/wine_training.csv --out_dir=results/response_means.csv

# Generate Summary Visualizations
results/wine_histogram.png results/wine-correlation.png: R/wine_eda_visualizations.R results/wine_training.csv
	Rscript R/wine_eda_visualizations.R --input=results/wine_training.csv --out_dir_hist=results/wine-histogram.png --out_dir_corr=results/wine-correlation.png

# Create Model
results/wine_lm_fit.rds results/wine_lm_coefs.csv: R/wine_modelling.R results/wine_training.csv
	Rscript R/wine_modelling.R --input=results/wine_training.csv --out_dir_lm=results/wine_lm_fit.rds --out_dir_coef=results/wine_lm_coefs.csv

# Test Model
results/results/lm_accuracy.csv results/wine_lm_qq_plot.png: R/wine_test_model.R results/wine_testing.csv results/wine_lm_fit.rds results/lm_accuracy.csv
	Rscript R/wine_test_model.R --input=results/wine_testing.csv --model=results/wine_lm_fit.rds --out_dir_acc=results/lm_accuracy.csv --out_dir_qq=results/wine_lm_qq_plot.png

# Render Quarto
reports/wine-quality-prediction-report.qmd: