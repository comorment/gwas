# gwas container
FROM 'ubuntu:18.04'

ENV TZ=Europe
ENV DEBIAN_FRONTEND noninteractive

# Essential tools
WORKDIR /tmp
COPY /scripts/apt_get_essential.sh .
RUN chmod +x apt_get_essential.sh
RUN bash apt_get_essential.sh

# python_convert
WORKDIR /tools/python_convert
COPY /scripts/python_convert.sh /tools/python_convert
RUN chmod +x python_convert.sh
RUN bash python_convert.sh

WORKDIR /tools/miniconda
COPY /scripts/miniconda.sh /tools/miniconda
RUN chmod +x miniconda.sh
RUN bash miniconda.sh

WORKDIR /tools/miniconda3
COPY /scripts/miniconda3.sh /tools/miniconda3
RUN chmod +x miniconda3.sh
RUN bash miniconda3.sh

WORKDIR /tools
