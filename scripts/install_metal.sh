#!/bin/sh


# metal

wget  http://csg.sph.umich.edu/abecasis/metal/download/Linux-metal.tar.gz && \
   tar -xvzf Linux-metal.tar.gz && \
   rm -rf  Linux-metal.tar.gz



   cp generic-metal/metal  /bin
