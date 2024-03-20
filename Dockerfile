FROM rocker/tidyverse:4.3.2

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    && install2.r --error --skipmissing --deps TRUE --skipinstalled \
    tidyverse \
    car \
    corrplot \
    cowplot \
    tidymodels \
    knitr \
    kableExtra \
    rmarkdown \
    testthat \
    docopt

RUN Rscript -e 'tinytex::install_tinytex()'