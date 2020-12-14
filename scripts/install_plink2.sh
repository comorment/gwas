#!/bin/sh
wget --no-check-certificate http://s3.amazonaws.com/plink2-assets/plink2_linux_x86_64_20201212.zip && \
    unzip -j plink2_linux_x86_64_20201212.zip && \
    rm -rf plink2_linux_x86_64_20201212.zip

cp plink2 /bin
