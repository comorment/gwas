FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

#required tools
RUN apt-get update && apt-get install -y  --no-install-recommends apt-utils\
    python3 \
    python3-pip \
    tar \
    wget \
    unzip \
    git  \
  libgsl0-dev \
   perl \
    && \
    rm -rf /var/lib/apt/lists/*

# plink

RUN  wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20200616.zip && \
     unzip -j plink_linux_x86_64_20200616.zip && \
     rm -rf plink_linux_x86_64_20200616.zip




# PRSice

 RUN wget https://github.com/choishingwan/PRSice/releases/download/2.3.3/PRSice_linux.zip  && \
         unzip PRSice_linux.zip  && \
          rm -rf PRSice_linux.zip

  # dataset for prsice

RUN wget https://5c2d08d4-17d1-4dd8-bb49-f9593683e642.filesusr.com/archives/e7bc47_f74626b357ed453584e9e775713fe9ac.zip?dn=data_chapter10.zip && \
unzip -j  e7bc47_f74626b357ed453584e9e775713fe9ac.zip?dn=data_chapter10.zip  && \
rm -rf   e7bc47_f74626b357ed453584e9e775713fe9ac.zip?dn=data_chapter10.zip



# LMM

RUN wget https://storage.googleapis.com/broad-alkesgroup-public/BOLT-LMM/downloads/BOLT-LMM_v2.3.4.tar.gz && \
tar -xvzf BOLT-LMM_v2.3.4.tar.gz && \
rm -rf BOLT-LMM_v2.3.4.tar.gz && \
 cp -a /BOLT-LMM_v2.3.4/lib/. /lib/ && \
 cp -a /BOLT-LMM_v2.3.4/example/. /


# GCTA

RUN wget https://cnsgenomics.com/software/gcta/bin/gcta_1.93.2beta.zip && \
    unzip -j  gcta_1.93.2beta.zip && \
    rm -rf gcta_1.93.2beta.zip


# R
RUN apt-get update && apt-get install -y r-base &&  apt-get install -y r-cran-ggplot2  &&  apt-get install -y  r-cran-data.table &&  apt-get install -y r-cran-optparse



# Rmarkdown
RUN apt-get install -y pandoc &&  apt-get install -y pandoc-citeproc

 RUN R -e "install.packages('rmarkdown')"

# python_convert
 RUN git clone https://github.com/precimed/python_convert.git

RUN apt-get update && apt-get install -y  --no-install-recommends apt-utils\
 python3-pandas\
 python3-numpy\
 python3-scipy\
 python3-matplotlib

# Data formatting
# qctool
RUN wget https://www.well.ox.ac.uk/~gav/resources/qctool_v2.0.6-Ubuntu16.04-x86_64.tgz && \
    tar -xvzf qctool_v2.0.6-Ubuntu16.04-x86_64.tgz && \
    rm -rf  qctool_v2.0.6-Ubuntu16.04-x86_64.tgz

 #vcftools
     RUN git clone https://github.com/vcftools/vcftools.git && \
     cd vcftools && \
      ./autogen.sh && \
      ./configure && \
       make && \
       make install

#Bcftools

 RUN  git clone git://github.com/samtools/htslib.git && \
git clone git://github.com/samtools/bcftools.git && \
cd bcftools && \
apt-get install -y curl && \
apt-get install -y libcurl4-gnutls-dev &&  \
#autoheader && autoconf && ./configure --enable-libgsl --enable-perl-filters && \
make


#end of data formatting

# GCTB
RUN wget https://cnsgenomics.com/software/gctb/download/gctb_2.02_Linux.zip  && \
    unzip   gctb_2.02_Linux.zip && \
    rm -rf gctb_2.02_Linux.zip

# LD

RUN git clone https://github.com/zhenin/HDL.git

# meta analysis

RUN wget  http://csg.sph.umich.edu/abecasis/metal/download/Linux-metal.tar.gz && \
    tar -xvzf Linux-metal.tar.gz && \
    rm -rf  Linux-metal.tar.gz

# Relatedness/PCA

#KING
RUN wget http://people.virginia.edu/~wc9c/KING/Linux-king.tar.gz && \
  tar -xvzf Linux-king.tar.gz && \
  rm -rf Linux-king.tar.gz

  #flashPCA
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
   RUN cp flashpca/flashpca /bin

   RUN userdel -r flashpca-user


WORKDIR /

    # copy all binaries to /bin
RUN cp /plink  /PRSice_linux /gcta64 /qctool_v2.0.6-Ubuntu16.04-x86_64/qctool /gctb_2.02_Linux/gctb /bcftools/bcftools generic-metal/metal king BOLT-LMM_v2.3.4/bolt  /bin

RUN plink --bfile 1kg_EU_qc  --recode vcf-iid --out 1kg_EU_qc_vcf
