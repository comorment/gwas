FROM 'ubuntu:18.04'

RUN apt-get update && apt-get install -y  --no-install-recommends apt-utils\
    python3 \
    python3-pip \
    tar \
    wget \
    unzip \
    && \
    rm -rf /var/lib/apt/lists/*

RUN  (  wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20200616.zip && \
     unzip plink_linux_x86_64_20200616.zip && \
     rm -rf plink_linux_x86_64_20200616.zip)
     
 RUN cp /plink  /bin


