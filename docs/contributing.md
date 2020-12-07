# Maintaining reference dataset

Reference dataset is maintained as a github repository here:  https://github.com/norment/comorment_data
Note that this repository has ``git lfs`` support enabled.

# Installing Docker and Singularity

* TBD: provide insturctions for Docker installation.

* To install it on Ubuntu follow steps described here: https://sylabs.io/guides/3.7/user-guide/quick_start.html
  Note that ``sudo apt-get`` can give only a very old version of singularity, which isn't sufficient.
  Therefore it's best to build singularity locally.  Note that singularity depends on GO, so it must be installed first.

# Building docker images

Clone from http://github.com/comorment/gwas.
The following commands assume that current directory is at the root the ``gwas`` repository.
```
docker build -t hello -f containers/hello/Dockerfile .
docker build -t gwas  -f containers/gwas/Dockerfile .
docker build -t conda -f containers/conda/Dockerfile .
docker build -t r     -f containers/R/Dockerfile .
```

# Building singularity containers

The script works by creating a local Docker repostiory:
```
singularity/from_docker_image.sh hello
singularity/from_docker_image.sh gwas
singularity/from_docker_image.sh conda
singularity/from_docker_image.sh R
```

# Running docker containers (misc commands)

```
docker run -it r
docker run -it -v $COMORMENT_REF:/ref demo 
```

# Running singularity containers (misc commands)

```
singularity shell --no-home -B $(pwd):/data demo.sif
singularity shell --no-home -B $(pwd):/data conda.sif
```
