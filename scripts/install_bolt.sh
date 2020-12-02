#!/bin/sh
wget --no-check-certificate https://storage.googleapis.com/broad-alkesgroup-public/BOLT-LMM/downloads/BOLT-LMM_v2.3.4.tar.gz && \
tar -xvzf BOLT-LMM_v2.3.4.tar.gz && \
rm -rf BOLT-LMM_v2.3.4.tar.gz && \
mv BOLT-LMM_v2.3.4/* . && \
rmdir BOLT-LMM_v2.3.4

cp bolt  /bin
