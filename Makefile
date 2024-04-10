# Wine quality Analysis Data Pipe
# Author: Rico Chan, Rui Xiang Yu, Kevin Yu
# Date: 2024 March 15
all: data/wine_processed.csv \
	results/wine_training.csv \
	results/wine_testing.csv \
	results/wine_response_means.csv \
	results/wine_histogram.png \
	results/wine_correlation.png \
	results/wine_lm_fit.rds \
	results/wine_lm_coefs.csv \
	results/wine_lm_accuracy.csv \
	results/wine_lm_qq_plot.png \
	reports/wine_quality_prediction_report.html \
	reports/wine_quality_prediction_report.pdf

# Download Data
data/wine_processed.csv: R/01_download-data.R
	Rscript R/01_download-data.R --input=https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv --out_dir=data/wine_processed.csv

# Preprocess Data
results/wine_training.csv results/wine_testing.csv: R/02_wine-preprocess.R data/wine_processed.csv
	Rscript R/02_wine-preprocess.R --input=data/wine_processed.csv --out_dir_train=results/wine_training.csv --out_dir_test=results/wine_testing.csv

# Generate Summary Statistics
results/wine_response_means.csv: R/03_wine-summary-statistics.R results/wine_training.csv
	Rscript R/03_wine-summary-statistics.R --train=results/wine_training.csv --out_dir=results/wine_response_means.csv

# Generate Summary Visualizations
results/wine_histogram.png results/wine_correlation.png: R/04_wine-eda-visualizations.R results/wine_training.csv
	Rscript R/04_wine-eda-visualizations.R --input=results/wine_training.csv --out_dir_hist=results/wine_histogram.png --out_dir_corr=results/wine_correlation.png

# Create Model
results/wine_lm_fit.rds results/wine_lm_coefs.csv: R/05_wine-modelling.R results/wine_training.csv
	Rscript R/05_wine-modelling.R --input=results/wine_training.csv --out_dir_lm=results/wine_lm_fit.rds --out_dir_coef=results/wine_lm_coefs.csv

# Test Model
results/wine_lm_accuracy.csv results/wine_lm_qq_plot.png: R/06_wine-test-model.R results/wine_testing.csv results/wine_lm_fit.rds results/wine_lm_accuracy.csv
	Rscript R/06_wine-test-model.R --input=results/wine_testing.csv --model=results/wine_lm_fit.rds --out_dir_acc=results/wine_lm_accuracy.csv --out_dir_qq=results/wine_lm_qq_plot.png

# render quarto report in HTML and PDF
reports/wine_quality_prediction_report.html: results reports/wine_quality_prediction_report.qmd
	quarto render reports/wine_quality_prediction_report.qmd --to html

reports/wine_quality_prediction_report.pdf: results reports/wine_quality_prediction_report.qmd
	quarto render reports/wine_quality_prediction_report.qmd --to pdf

# clean
clean:
	rm -rf data/wine_processed.csv
	rm -rf results/wine_training.csv \
	results/wine_testing.csv \
	results/wine_response_means.csv \
	results/wine_histogram.png \
	results/wine_correlation.png \
	results/wine_lm_fit.rds \
	results/wine_lm_coefs.csv \
	results/wine_lm_accuracy.csv \
	results/wine_lm_qq_plot.png
	rm -rf reports/wine_quality_prediction_report.html \
		reports/wine_quality_prediction_report.pdf \
		reports/wine_quality_prediction_report_files