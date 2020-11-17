#!/bin/sh


# genomicsam

R -e "install.packages('devtools')"

R -e  "library('devtools')"

R -e "install_github('MichelNivard/GenomicSEM')"

R -e  "require('GenomicSEM')"


# cp vcftools  /bin
