## Author: Jules Larke
## Version JulesLarke-USDA/wweia_crp:1.0
## Date: July 18, 2024

## R-base image
FROM rocker/rstudio:4.1.0

## renv version
ENV RENV_VERSION=1.0.7

## install R package compliers (for intel machines)
## comment below if running intel machine
## or if building on top of linux/amd64
RUN apt-get update && apt-get install -y libz-dev build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev libxml2-dev libglpk-dev libnode-dev libv8-dev

## install RENV, which will then install all R project packages
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_version('renv', version = '1.0.7', repos = 'http://cran.us.r-project.org')"

## should be in the same directory as this file
COPY renv.lock ./
RUN R -e 'renv::consent(provided = TRUE)'
RUN R -e 'renv::restore()'
