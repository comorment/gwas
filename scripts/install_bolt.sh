#!/bin/sh


# Prsice

wget https://storage.googleapis.com/broad-alkesgroup-public/BOLT-LMM/downloads/BOLT-LMM_v2.3.4.tar.gz && \
tar -xvzf BOLT-LMM_v2.3.4.tar.gz && \
rm -rf BOLT-LMM_v2.3.4.tar.gz



cp BOLT-LMM_v2.3.4/bolt  /bin
