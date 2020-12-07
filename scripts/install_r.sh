#!/bin/sh
apt-get update
apt-get install -y git make cmake build-essential gfortran
apt-get install -y libxt-dev libpcre2-dev zlib1g-dev libcurl4 libcurl4-openssl-dev 
apt-get install -y r-base libnss3 pandoc pandoc-citeproc

# build R from source
wget https://cran.r-project.org/src/base/R-4/R-4.0.3.tar.gz && tar -xvzf R-4.0.3.tar.gz && cd R-4.0.3
./configure
make -j6
make install
