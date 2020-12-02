#!/bin/sh
apt-get update && apt-get install -y r-base &&  apt-get install -y r-cran-ggplot2  &&  apt-get install -y  r-cran-data.table &&  apt-get install -y r-cran-optparse && apt-get install -y  libnss3

# Rmarkdown
apt-get install -y pandoc &&  apt-get install -y pandoc-citeproc
R -e "install.packages('rmarkdown')"

