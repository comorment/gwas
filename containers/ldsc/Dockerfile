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
COPY /scripts/install_miniconda.sh .
RUN chmod +x install_miniconda.sh
RUN bash install_miniconda.sh

RUN conda install python=2.7.13
RUN yes | pip install argparse==1.3.0
RUN yes | pip install bitarray==0.8.1
RUN yes | pip install nose==1.3.4
RUN yes | pip install numpy==1.8.0
RUN yes | pip install pandas==0.17.0
RUN yes | pip install scipy==0.11.0
RUN yes | pip install pybedtools==0.7

WORKDIR /tools/ldsc
RUN git clone https://github.com/bulik/ldsc.git .

WORKDIR /tools
 
