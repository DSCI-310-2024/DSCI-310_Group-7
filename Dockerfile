FROM rocker/tidyverse:4.3.2

RUN Rscript -e "install.packages('car')" 
RUN Rscript -e "install.packages('corrplot')" 
RUN Rscript -e "install.packages('cowplot')" 
RUN Rscript -e "install.packages('tidymodels')"