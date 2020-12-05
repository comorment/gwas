# Installing Docker and Singularity

* TBD: provide insturctions for Docker installation.

* To install it on Ubuntu follow steps described here: https://sylabs.io/guides/3.7/user-guide/quick_start.html
  Note that ``sudo apt-get`` can give only a very old version of singularity, which isn't sufficient.
  Therefore it's best to build singularity locally.  Note that singularity depends on GO, so it must be installed first.

# Building containers

Clone from http://github.com/comorment/gwas.
The following commands assume that current directory is at the root the ``gwas`` repository.

```
docker build -t hello -f containers/hello/Dockerfile .
docker build -t gwas  -f containers/gwas/Dockerfile .
docker build -t conda -f containers/conda/Dockerfile .
```

# Building singularity 

The script works by creating a local Docker repostiory:
```
singularity/from_docker_image.sh hello
singularity/from_docker_image.sh gwas
singularity/from_docker_image.sh conda
```

# Running containers

```
docker run -it -v /home/oleksanf/github/comorment/comorment_data/:/data demo 
```

# Running singularity containers

```
singularity shell --no-home -B $(pwd):/data demo.sif
singularity shell --no-home -B $(pwd):/data conda.sif
```
