#!/bin/sh


# bcfools
git clone git://github.com/samtools/htslib.git && \
git clone git://github.com/samtools/bcftools.git && \
cd bcftools && \
apt-get install -y curl && \
apt-get install -y libcurl4-gnutls-dev &&  \
#autoheader && autoconf && ./configure --enable-libgsl --enable-perl-filters && \
make


#cp /bcftools/bcftools  /bin
