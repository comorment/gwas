# gwas container
FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

# Essential tools
WORKDIR /tmp
COPY /scripts/apt_get_essential.sh .
RUN chmod +x apt_get_essential.sh
RUN bash apt_get_essential.sh

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
RUN git clone https://github.com/bulik/ldsc.git .

WORKDIR /tools 
