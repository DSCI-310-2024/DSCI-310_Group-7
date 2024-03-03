# Predicting Wine Quality Using Multiple Linear Regression
Authors: Rui Xiang Yu, Rico Chan & Kevin Yu
Course: DSCI 310, 2024 Winter Term 2

## About
This project attempts to build a multiple linear regression model to analyze different physiochemical properties of red wine and understand which properties affect the quality of wine positively. Splitting the dataset into a 75/25 training/testing split, and applying a specified recipe for a multivariate regression, we obtained decent RMSE and MAE values of 0.67 and 0.52 respectively, but a mediocre R-squared value of 0.32. We discover that the fixed acidity, residual sugar, free sulphur dioxide, sulphates, and alcohol properties tend to increase the wine quality, while the volatile acidity, citric acid, chlorides, total sulphur dioxide, density, and pH properties tend to reduce the wine quality.

The data used for this project is [from the UCI Machine Learning Repository, created by Cortez et al. (2009).](https://doi.org/10.24432/C56S3T). The dataset comprises of 12 variables (11 physicochemical indicators and 1 quality indicator) and contains 1599 instances of red vinho verde, a popular wine from Portugal. Each instance of wine was assessed by at least three [sensory assessors](https://www.sensorysociety.org/knowledge/sspwiki/Pages/assessor.aspx) and scored on a ten-point scale that ranges from "very bad" to "excellent"; the wine quality for each instance is determined by the median of these scores. 

## Report
The final report can be found [here](https://github.com/DSCI-310-2024/dsci-310_group-7_wine-quality-prediction/blob/main/prediction-red_wine_quality.ipynb).

## Usage
To set up the repository and reproduce the analysis, please follow these steps:
1. Install R from the [CRAN project](https://cran.r-project.org/). The version used for this repository was version 4.3.2.
2. Install Jupyter Lab. You can do this through [Miniconda](https://docs.anaconda.com/free/miniconda/) and this code:
   ```
   conda install jupyterlab==4.0.10
   ```
3. Install renv. The version used in this repository is 1.0.5. You can install renv by pasting this code on an R console:
   ```
   install.packages("renv")
   ```
4. Clone the repository. Paste this code onto your terminal:
   ```
   git clone https://github.com/DSCI-310-2024/dsci-310_group-7_wine-quality-prediction.git
   ```
5. Navigate to the root of the repository through the ```cd``` command on your terminal.
6. On an R console, paste the following code:
   ```
   renv::restore()
   ```
   Followed by:
   ```
   renv::activate()
   ```
7. Launch the Jupyter Notebook. You can do this by pasting this code onto your terminal:
   ```
   jupyter lab
   ```
8. Open prediction-red_wine_quality.ipynb on Jupyter Lab.

## Troubleshooting
If the setup does not work, please try one of the following solutions:

1. Open the notebook on Jupyter Lab. Open an R console on JupyterLab. Do step 6.

2. Install IRkernel through ```install.packages('IRkernel')``` on an R console. The version used in this repository is 1.3.2. Then, open the notebook on Jupyter Lab. Open an R console and do step 6.

## Dependencies
- R v4.3.2
- jupyterlab v4.0.10
- conda v23.11.0
- renv v1.0.5
- IRkernel v1.3.2
- tidyverse v2.0.0
- tidymodels v1.1.1
- cowplot v1.1.3
- car v3.1-2
- corrplot v0.92

## License
See [License file](https://github.com/DSCI-310-2024/dsci-310_group-7_wine-quality-prediction?tab=License-1-ov-file).

## References
Cortez, P., Cerdeira, A., Almeida, F., Matos, T., & Reis, J. (2009). Modeling wine preferences by data mining from physicochemical properties. *Decision Support Systems, 47*(4), 547–553. https://doi.org/10.1016/j.dss.2009.05.016

*Culture of wine.* (n.d.). Retrieved 29 February 2024, from https://www.wineinmoderation.eu/culture

Elfman, Z. (2017, January 6). *Libation frontiers – a deep dive into the world wine industry | toptal®*. Toptal Finance Blog. https://www.toptal.com/finance/market-sizing/wine-industry

Luque, A., Mazzoleni, M., Zamora-Polo, F., Ferramosca, A., Lama, J. R., & Previdi, F. (2023). Determining the importance of physicochemical properties in the perceived quality of wines. *IEEE Access, 11*, 115430–115449. https://doi.org/10.1109/ACCESS.2023.3325676
