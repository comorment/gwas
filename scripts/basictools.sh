#!/bin/sh
#required tools
apt-get update && apt-get install -y  --no-install-recommends apt-utils\
    python3 \
    python3-pip \
    tar \
    wget \
    unzip \
    git  \
  libgsl0-dev \
   perl \
    less \
    parallel \
    && \
    rm -rf /var/lib/apt/lists/*


    # R
apt-get update && apt-get install -y r-base &&  apt-get install -y r-cran-ggplot2  &&  apt-get install -y  r-cran-data.table &&  apt-get install -y r-cran-optparse



    # Rmarkdown
 apt-get install -y pandoc &&  apt-get install -y pandoc-citeproc

  R -e "install.packages('rmarkdown')"
