#!/bin/sh


# vcfools

 git clone https://github.com/vcftools/vcftools.git && \
cd vcftools && \
 ./autogen.sh && \
 ./configure && \
  make && \
  make install


#cp vcftools  /bin
