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
RUN conda install -c conda-forge scikit-learn --yes
RUN conda install -c conda-forge matplotlib-venn numdifftools --yes
RUN conda install -c conda-forge lifelines --yes
RUN yes | pip install --upgrade pip && pip install tensorflow
RUN conda install -c pytorch pytorch torchvision torchaudio cudatoolkit=10.2 --yes
RUN conda install -c conda-forge theano --yes
#RUN conda install -c conda-forge caffe --yes

WORKDIR /tools
 
