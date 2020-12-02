#!/bin/sh
apt-get update && apt-get install -y  --no-install-recommends apt-utils\
   tar \
   wget \
   unzip \
   git \
   libgsl0-dev \
   perl \
   less \
   parallel \
   bzip2 \
   dos2unix \
   tofrodos \
   vim \
   && \
   rm -rf /var/lib/apt/lists/*
