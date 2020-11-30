# gwas container
FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

# Essential Tools
WORKDIR /tools/essential
COPY /scripts/essential_tools.sh /tools/essential
RUN chmod +x essential_tools.sh
RUN bash essential_tools.sh

# Plink
WORKDIR /tools/plink
COPY /scripts/install_plink.sh /tools/plink
RUN chmod +x install_plink.sh
RUN bash install_plink.sh

# prsice
WORKDIR /tools/prsice
COPY /scripts/install_prsice.sh /tools/prsice
RUN chmod +x install_prsice.sh
RUN bash install_prsice.sh

# Bolt LMM
WORKDIR /tools/bolt
COPY /scripts/install_bolt.sh /tools/bolt
RUN chmod +x install_bolt.sh
RUN bash install_bolt.sh

# gcta
WORKDIR /tools/gcta
COPY /scripts/install_gcta.sh /tools/gcta
RUN chmod +x install_gcta.sh
RUN bash install_gcta.sh

# python_convert
WORKDIR /tools/python_convert
COPY /scripts/python_convert.sh /tools/python_convert
RUN chmod +x python_convert.sh
RUN bash python_convert.sh

# qctools
WORKDIR /tools/qctools
COPY /scripts/install_qctools.sh /tools/qctools
RUN chmod +x install_qctools.sh
RUN bash install_qctools.sh

# vcftools
WORKDIR /tools/vcftools
COPY /scripts/install_vcftools.sh /tools/vcftools
RUN chmod +x install_vcftools.sh
RUN bash install_vcftools.sh

# Bcftools
WORKDIR /tools/bcftools
COPY /scripts/install_bcftools.sh /tools/bcftools
RUN chmod +x install_bcftools.sh
RUN bash install_bcftools.sh

# gctb
WORKDIR /tools/gctb
COPY /scripts/install_gctb.sh /tools/gctb
RUN chmod +x install_gctb.sh
RUN bash install_gctb.sh

# hdl
WORKDIR /tools/hdl
COPY /scripts/install_hdl.sh /tools/hdl
RUN chmod +x install_hdl.sh
RUN bash install_hdl.sh

# metal
WORKDIR /tools/metal
COPY /scripts/install_metal.sh /tools/metal
RUN chmod +x install_metal.sh
RUN bash install_metal.sh

# king
WORKDIR /tools/king
COPY /scripts/install_king.sh /tools/king
RUN chmod +x install_king.sh
RUN bash install_king.sh

# Rstudio
WORKDIR /tools/rstudio
COPY /scripts/install_rstudio.sh /tools/rstudio
RUN chmod +x install_rstudio.sh
RUN bash install_rstudio.sh

# flashPCA
#WORKDIR /tools/flashpca
#COPY /scripts/install_flashpca.sh /tools/flashpca
#RUN chmod +x install_flashpca.sh
#RUN bash install_flashpca.sh

WORKDIR /tools/miniconda
COPY /scripts/miniconda.sh /tools/miniconda
RUN chmod +x miniconda.sh
RUN bash miniconda.sh

WORKDIR /tools/miniconda3
COPY /scripts/miniconda3.sh /tools/miniconda3
RUN chmod +x miniconda3.sh
RUN bash miniconda3.sh

# saige
#WORKDIR /tools/saige
#COPY /scripts/install_saige.sh /tools/saige
#RUN chmod +x install_saige.sh
#RUN bash install_saige.sh

# genomicsam
WORKDIR /tools/genomicsam
COPY /scripts/install_genomicsam.sh /tools/genomicsam
RUN chmod +x install_genomicsam.sh
RUN bash install_genomicsam.sh

# flashPCA (from developers' guide)
RUN mkdir flashpca-build
RUN apt-get update && \
   apt-get -y install python2.7 python-pip libboost1.62-all-dev \
   libeigen3-dev git gnupg2 sudo wget ca-certificates
RUN echo 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' \
   > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com \
   --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
RUN ln -fs /usr/share/zoneinfo/Australia/Melbourne /etc/localtime && \
   dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install -y r-base r-base-dev
RUN apt-get install -y vim
RUN useradd -m flashpca-user
RUN chpasswd flashpca-user:password
WORKDIR /home/flashpca-user
USER flashpca-user
RUN wget https://github.com/yixuan/spectra/archive/v0.8.1.tar.gz && \
   tar xvf v0.8.1.tar.gz
ADD https://api.github.com/repos/gabraham/flashpca/git/refs/heads/master \
   version.json
RUN git clone https://github.com/gabraham/flashpca.git
RUN cd flashpca && \
   make all \
   EIGEN_INC=/usr/include/eigen3 \
   BOOST_INC=/usr/include/boost \
   SPECTRA_INC=$HOME/spectra-0.8.1/include &&\
   make flashpca_x86-64 \
   EIGEN_INC=/usr/include/eigen3 \
   BOOST_INC=/usr/include/boost \
   SPECTRA_INC=$HOME/spectra-0.8.1/include
USER root
RUN cp flashpca/flashpca /bin && cp flashpca/flashpca /tools
RUN userdel -r flashpca-user

# Additional tools
WORKDIR /tools/additional
COPY /scripts/additional_tools.sh /tools/additional
RUN chmod +x additional_tools.sh
RUN bash additional_tools.sh

WORKDIR /
RUN mkdir toydata
RUN cp tools/prsice/TOY_BASE_GWAS.assoc  tools/prsice/TOY_TARGET_DATA.bim tools/prsice/TOY_TARGET_DATA.bed tools/prsice/TOY_TARGET_DATA.fam tools/prsice/TOY_TARGET_DATA.pheno /toydata
