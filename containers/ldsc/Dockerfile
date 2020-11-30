# gwas container
FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

# Essential Tools
WORKDIR /tools/essential
COPY /scripts/essential_tools.sh /tools/essential
RUN chmod +x essential_tools.sh
RUN bash essential_tools.sh

WORKDIR /tools/miniconda
COPY /scripts/miniconda.sh /tools/miniconda
RUN chmod +x miniconda.sh
RUN bash miniconda.sh

RUN conda install numpy
RUN conda install bitarray
RUN conda install pandas
RUN conda install matplotlib
RUN conda install scipy

WORKDIR /tools/ldsc
COPY /scripts/install_ldsc.sh /tools/ldsc
RUN chmod +x install_ldsc.sh
RUN bash install_ldsc.sh

WORKDIR /home
