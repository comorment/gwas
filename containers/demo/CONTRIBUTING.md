# Docker and Singularity containers for GWAS analysis 

A Hello World Docker and Singularity containers to perform Genome-wide association study (GWAS) via Plink 1.9 (http://zzz.bwh.harvard.edu/plink/) .

In order to run the developed Docker and Singularity containers, you need to install Docker (https://docs.docker.com/get-docker/) and Singularity (https://sylabs.io/guides/3.6/user-guide/quick_start.html?highlight=install),  respectively. You can run each container separately.
 

## For Docker Container

1. Pull the docker container from Docker Hub

```
docker pull bayramalex/hello

```

Alternatively you can build the image via Dockerfile and assign it  to an arbitrary name such as hello. Firstly you need to get the corresponding Dockerfile via

```
git clone https://github.com/comorment/gwas.git

```

and cd to this directory where the Dockerfile is placed. Then you can build this Dockerfile as:


```
docker build -t  hello .

```


2. You can run the pulled container with plink command as


```
docker run  bayramalex/hello plink --help

```

or if you build from Dockerfile


```
docker run hello plink --help

```

For the both alternatives, you should observe the welcome page of plink starting with:


PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3

In the command line flag definitions that follow............




## For Singularity Container

It is possible to build singularity container using the docker images in the Docker Hub or via existing  Dockerfile

1- Build Singularity image from Docker Hub

 ```
singularity build hello.sif docker://bayramalex/imagehello

```

Then on your working directory, you can observe hello.sif container


Alternatively you can build it with the Dockerfile on your local. Once you cd to the directory where your Dockerfile is, then type

```
bash singularity/build_from_dockerfile.sh

```

Then the  Singularity container  is placed in /singularity


2- Go to the directory where hello.sif is located



Run the container by mounting this directory

```
singularity exec hello  plink --help

```

Then you will expect exactly the same welcome page of plink as written in Docker part.



