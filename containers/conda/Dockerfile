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

RUN conda create -n ldsc python=2.7 --yes
RUN conda install -n ldsc numpy=1.16 pandas=0.20 scipy --yes
RUN conda install -n ldsc -c bioconda bitarray=0.8 nose=1.3 pybedtools=0.7 --yes

RUN conda create -n py3 python=3.8 --yes
RUN conda install -n py3 -c conda-forge jupyterlab --yes
RUN conda install -n py3 numpy scipy pandas statsmodels matplotlib matplotlib_venn seaborn numdifftools --yes

RUN conda create -n Renv r-essentials r-base --yes
RUN conda install -n Renv -c conda-forge jupyterlab --yes
RUN conda install -n Renv -c r r-irkernel --yes

WORKDIR /tools/ldsc
RUN git clone https://github.com/bulik/ldsc.git .

WORKDIR /tools/python_convert
RUN git clone https://github.com/precimed/python_convert.git .

WORKDIR /tools
 
