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
COPY /scripts/install_miniconda3.sh .
RUN chmod +x install_miniconda3.sh
RUN bash install_miniconda3.sh

RUN conda install python=3.8 --yes
RUN conda install -c conda-forge jupyterlab --yes
RUN conda install numpy scipy pandas statsmodels matplotlib seaborn --yes
RUN conda install -c conda-forge matplotlib-venn numdifftools lifelines --yes
RUN conda install -c conda-forge bgenix
RUN conda install -c bioconda htslib

# Plink (as python_convert depends on plink)
WORKDIR /tools/plink
COPY /scripts/install_plink.sh /tmp
RUN chmod +x /tmp/install_plink.sh
RUN bash /tmp/install_plink.sh

WORKDIR /tools/python_convert
RUN git clone https://github.com/precimed/python_convert.git .

WORKDIR /tools
COPY /scripts/install_mixer.sh /tmp
RUN chmod +x /tmp/install_mixer.sh
RUN bash /tmp/install_mixer.sh

WORKDIR /tools
 
