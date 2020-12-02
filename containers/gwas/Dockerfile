# gwas container
FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

# Essential tools
WORKDIR /tmp
COPY /scripts/apt_get_essential.sh .
RUN chmod +x apt_get_essential.sh
RUN bash apt_get_essential.sh

# Plink
WORKDIR /tools/plink
COPY /scripts/install_plink.sh /tmp
RUN chmod +x /tmp/install_plink.sh
RUN bash /tmp/install_plink.sh

# prsice
WORKDIR /tools/prsice
COPY /scripts/install_prsice.sh /tmp
RUN chmod +x /tmp/install_prsice.sh
RUN bash /tmp/install_prsice.sh

# Bolt LMM
#WORKDIR /tools/bolt
#COPY /scripts/install_bolt.sh /tmp
#RUN chmod +x /tmp/install_bolt.sh
#RUN bash /tmp/install_bolt.sh

# gcta
#WORKDIR /tools/gcta
#COPY /scripts/install_gcta.sh /tools/gcta
#RUN chmod +x install_gcta.sh
#RUN bash install_gcta.sh

# qctools
#WORKDIR /tools/qctools
#COPY /scripts/install_qctools.sh /tools/qctools
#RUN chmod +x install_qctools.sh
#RUN bash install_qctools.sh

# vcftools
#WORKDIR /tools/vcftools
#COPY /scripts/install_vcftools.sh /tools/vcftools
#RUN chmod +x install_vcftools.sh
#RUN bash install_vcftools.sh

# Bcftools
#WORKDIR /tools/bcftools
#COPY /scripts/install_bcftools.sh /tools/bcftools
#RUN chmod +x install_bcftools.sh
#RUN bash install_bcftools.sh

# gctb
#WORKDIR /tools/gctb
#COPY /scripts/install_gctb.sh /tools/gctb
#RUN chmod +x install_gctb.sh
#RUN bash install_gctb.sh

# hdl
#WORKDIR /tools/hdl
#COPY /scripts/install_hdl.sh /tools/hdl
#RUN chmod +x install_hdl.sh
#RUN bash install_hdl.sh

# metal
#WORKDIR /tools/metal
#COPY /scripts/install_metal.sh /tools/metal
#RUN chmod +x install_metal.sh
#RUN bash install_metal.sh

# king
#WORKDIR /tools/king
#COPY /scripts/install_king.sh /tools/king
#RUN chmod +x install_king.sh
#RUN bash install_king.sh

WORKDIR /tools
