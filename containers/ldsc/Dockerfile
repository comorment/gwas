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

RUN conda install python=2.7 --yes
RUN conda install numpy=1.16 pandas=0.20 scipy --yes
RUN conda install -c bioconda bitarray=0.8 nose=1.3 pybedtools=0.7 --yes

WORKDIR /tools/ldsc
RUN git clone https://github.com/bulik/ldsc.git .

WORKDIR /tools
 
