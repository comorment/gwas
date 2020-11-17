#!/bin/sh


# gctb

wget https://cnsgenomics.com/software/gctb/download/gctb_2.02_Linux.zip  && \
   unzip   gctb_2.02_Linux.zip && \
   rm -rf gctb_2.02_Linux.zip



# cp /gctb_2.02_Linux/gctb  /bin
  cp gctb_2.02_Linux/gctb /bin 
