# gwas container
FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

# Essential tools
WORKDIR /tmp
COPY /scripts/apt_get_essential.sh .
RUN chmod +x apt_get_essential.sh
RUN bash apt_get_essential.sh

# Rstudio
WORKDIR /tools/rstudio
COPY /scripts/install_rstudio.sh /tools/rstudio
RUN chmod +x install_rstudio.sh
RUN bash install_rstudio.sh

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

WORKDIR /tools
