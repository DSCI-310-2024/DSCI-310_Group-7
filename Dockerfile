FROM rocker/tidyverse:4.3.2

RUN Rscript -e "install.packages('car')" \ 
    "install.packages('corrplot')" \ 
    "install.packages('cowplot')" \
    "install.packages('tidymodels')"