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
 apt-get update && apt-get install -y r-base &&  apt-get install -y r-cran-ggplot2  &&  apt-get install -y  r-cran-data.table &&  apt-get install -y r-cran-optparse && apt-get install -y  libnss3



    # Rmarkdown
 apt-get install -y pandoc &&  apt-get install -y pandoc-citeproc

 R -e "install.packages('rmarkdown')"

apt-get update && apt-get install -y  --no-install-recommends apt-utils\
  python3-pandas\
  python3-numpy\
  python3-scipy\
  python3-matplotlib

apt-get install -y jupyter
