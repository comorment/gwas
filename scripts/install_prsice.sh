#!/bin/sh


# Prsice

 wget https://github.com/choishingwan/PRSice/releases/download/2.3.3/PRSice_linux.zip  && \
    unzip PRSice_linux.zip  && \
    rm -rf PRSice_linux.zip


# data

wget https://5c2d08d4-17d1-4dd8-bb49-f9593683e642.filesusr.com/archives/e7bc47_f74626b357ed453584e9e775713fe9ac.zip?dn=data_chapter10.zip && \
unzip -j  e7bc47_f74626b357ed453584e9e775713fe9ac.zip?dn=data_chapter10.zip  && \
rm -rf   e7bc47_f74626b357ed453584e9e775713fe9ac.zip?dn=data_chapter10.zip



cp PRSice_linux  /bin
cp PRSice.R  /
