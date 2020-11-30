#!/bin/sh


# vcfools

 git clone https://github.com/vcftools/vcftools.git . && \
 ./autogen.sh && \
 ./configure && \
  make && \
  make install


#cp vcftools  /bin
