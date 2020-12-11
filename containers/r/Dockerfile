# R container
FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

# Essential tools
WORKDIR /tmp
COPY /scripts/apt_get_essential.sh .
RUN chmod +x apt_get_essential.sh
RUN bash apt_get_essential.sh

# R
WORKDIR /tmp
COPY /scripts/install_r.sh /tmp
RUN chmod +x install_r.sh
RUN bash install_r.sh

# Rstudio
WORKDIR /tmp
COPY /scripts/install_rstudio.sh /tmp
RUN chmod +x install_rstudio.sh
RUN bash install_rstudio.sh

# R packages
RUN R -e "install.packages('rmarkdown')"
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('data.table')"
RUN R -e "install.packages('optparse')"
RUN R -e "install.packages('foreign')"

# saige
#WORKDIR /tools/saige
#COPY /scripts/install_saige.sh /tools/saige
#RUN chmod +x install_saige.sh
#RUN bash install_saige.sh

# genomicsam
#WORKDIR /tools/genomicsam
#COPY /scripts/install_genomicsam.sh /tools/genomicsam
#RUN chmod +x install_genomicsam.sh
#RUN bash install_genomicsam.sh

WORKDIR /tools
