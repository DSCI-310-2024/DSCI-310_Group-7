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
        testthat \
        docopt

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