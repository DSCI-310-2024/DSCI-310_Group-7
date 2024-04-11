FROM rocker/tidyverse:4.3.2

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    && install2.r --error --skipmissing --deps TRUE --skipinstalled \
        car \
        corrplot \
        cowplot \
        tidymodels \
        knitr \
        kableExtra \
        testthat \
        vdiffr 
        
RUN installGithub.r DSCI-310-2024/pRedictwine

USER rstudio

RUN Rscript -e 'tinytex::install_tinytex()'

ENV PATH="${PATH}:/home/rstudio/bin"

RUN tlmgr update --self
RUN tlmgr update --all
RUN tlmgr install \
        koma-script \
        caption \
        pgf \
        environ \
        tikzfill \
        tcolorbox \
        pdfcol

USER root