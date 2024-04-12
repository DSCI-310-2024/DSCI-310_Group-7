# Predicting Wine Quality Using Multiple Linear Regression

Authors: Rui Xiang Yu, Rico Chan & Kevin Yu  
Course: DSCI 310, 2024 Winter Term 2

## About

The wine industry remains strong worldwide, and numerous technological innovations have support its growth, especially in the realms of certification and quality assessment. One prominent innovation is the use of rigorous laboratory testing to produce data relating the physiochemical properties of wine to abstract human sensory perceptions.

This project attempts to leverage such data by building a multiple linear regression model to analyze different physiochemical properties of red wine and understand which properties affect the quality of wine positively. Splitting the dataset into a 75/25 training/testing split, and applying a specified recipe for a multivariate regression, we obtained decent RMSE and MAE values of 0.67 and 0.52 respectively, but a mediocre R-squared value of 0.32. We discover that the fixed acidity, residual sugar, free sulphur dioxide, sulphates, and alcohol properties tend to increase the wine quality, while the volatile acidity, citric acid, chlorides, total sulphur dioxide, density, and pH properties tend to reduce the wine quality.

The data used for this project is [from the UCI Machine Learning Repository, created by Cortez et al. (2009)](https://doi.org/10.24432/C56S3T). The dataset comprises of 12 variables (11 physicochemical indicators and 1 quality indicator) and contains 1599 instances of red vinho verde, a popular wine from Portugal. Each instance of wine was assessed by at least three [sensory assessors](https://www.sensorysociety.org/knowledge/sspwiki/Pages/assessor.aspx) and scored on a ten-point scale that ranges from "very bad" to "excellent"; the wine quality was then determined by the median of these scores.

## Report

The final reports can be found [here](https://github.com/DSCI-310-2024/dsci-310_group-7_wine-quality-prediction/tree/main/reports).

## Usage

To set up the repository and reproduce the analysis, please follow these steps:
1. Clone the repository. Paste this code onto your terminal:

```         
git clone https://github.com/DSCI-310-2024/dsci-310_group-7_wine-quality-prediction.git
```

2.  Navigate to the root of the repository through the `cd` command on your terminal.
3.  Download [Docker](https://docs.docker.com/desktop/install/mac-install/) and ensure it is running. Paste the following code into your terminal:

```         
docker-compose up
```

4.  Open your browser and go to <http://localhost:8787/>.
5.  Type in "rstudio" as the username and "group7wine" as the password.
6.  In the RStudio terminal, paste the following in order to remove the created files and reports:

```         
make -C /home/rstudio/workspace clean
```

7.  In the RStudio terminal, paste the following in order to re-create the files and reports:

```         
make -C /home/rstudio/workspace all
```

### Note

For future contributors (please read [CONTRIBUTING](https://github.com/DSCI-310-2024/dsci-310_group-7_wine-quality-prediction/blob/main/CONTRIBUTING.md)), it would be wise to make sure the RStudio's terminal and R console are both at the `/workspace` folder (NOT the `/bin` folder). \> In the terminal, paste:

```         
cd workspace
```

> In the console, paste:

```         
setwd("~/workspace")
```

## Dependencies

[Docker](https://www.docker.com/) is used to virtualise the software dependencies for this project. The Docker image for this project is built from the `rocker/tidyverse:4.3.2` image. Additional dependencies are detailed in the [`Dockerfile`](Dockerfile).

## License

See [License file](https://github.com/DSCI-310-2024/dsci-310_group-7_wine-quality-prediction?tab=License-1-ov-file).

## References

Cortez, P., Cerdeira, A., Almeida, F., Matos, T., & Reis, J. (2009). Modeling wine preferences by data mining from physicochemical properties. *Decision Support Systems, 47*(4), 547–553. <https://doi.org/10.1016/j.dss.2009.05.016>

*Culture of wine.* (n.d.). Retrieved 29 February 2024, from <https://www.wineinmoderation.eu/culture>

Elfman, Z. (2017, January 6). *Libation frontiers – a deep dive into the world wine industry \| toptal®*. Toptal Finance Blog. <https://www.toptal.com/finance/market-sizing/wine-industry>

Luque, A., Mazzoleni, M., Zamora-Polo, F., Ferramosca, A., Lama, J. R., & Previdi, F. (2023). Determining the importance of physicochemical properties in the perceived quality of wines. *IEEE Access, 11*, 115430–115449. <https://doi.org/10.1109/ACCESS.2023.3325676>
