FROM rocker/tidyverse:4.3.2

RUN apt-get update -qq && apt-get -y --no-install-recommends install r-base\
    && install2.r --error --skipmissing --deps TRUE --skipinstalled \
    tidyverse \
    car \
    corrplot \
    cowplot \
    tidymodels \
    knitr \
    kableExtra \
    testthat \
    docopt

RUN Rscript -e "remotes::install_version('tinytex', version = '0.49', repos = 'https://cloud.r-project.org')"