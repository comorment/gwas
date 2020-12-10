# gwas container
FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

# Essential tools
WORKDIR /tmp
COPY /scripts/apt_get_essential.sh .
RUN chmod +x apt_get_essential.sh
RUN bash apt_get_essential.sh

WORKDIR /tmp
COPY /scripts/miniconda.sh .
RUN chmod +x miniconda.sh
RUN bash miniconda.sh

# This container is not usable at this point.
# ``library(data.table)`` command crashes with the following error:
# unable to load shared object '/usr/local/envs/Renv/lib/R/library/grDevices/libs//cairo.so'

RUN conda install r-essentials r-base --yes
RUN conda install -c conda-forge jupyterlab --yes
RUN conda install -c r r-irkernel --yes

WORKDIR /tools
 
