# demo container
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
