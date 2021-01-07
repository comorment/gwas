# Maintaining reference dataset

Reference dataset is maintained as a github repository here:  https://github.com/norment/comorment_data
Note that this repository has ``git lfs`` support enabled.

# Installing Docker and Singularity

* TBD: provide insturctions for Docker installation.

* To install it on Ubuntu follow steps described here: https://sylabs.io/guides/3.7/user-guide/quick_start.html
  Note that ``sudo apt-get`` can give only a very old version of singularity, which isn't sufficient.
  Therefore it's best to build singularity locally.  Note that singularity depends on GO, so it must be installed first.

# Building everything

There is a ``Makefile`` script in the root of the repo. To build all containers, run ``sudo make``
(or just ``make`` - it might be that you Docker & singularity are installed in a way that don't require sudo).
Makefile builds conatiner ``xxx`` only if it's ``xxx.sif`` file is missing, or is older that ``containers/xxx/Dockerfile``.
You may ``touch containers/xxx/Dockerfile`` if you want to force the build 
(e.g. in case if one of the ``install_xxx.sh`` files has changed in the ``scripts`` folder - such dependency won't be handled by the Makefile).

# Building docker images

Clone from http://github.com/comorment/gwas.
The following commands assume that current directory is at the root the ``gwas`` repository.
```
docker build -t hello -f containers/hello/Dockerfile .
docker build -t gwas  -f containers/gwas/Dockerfile .
docker build -t python3 -f containers/python3/Dockerfile .
docker build -t ldsc  -f containers/ldsc/Dockerfile .
docker build -t r     -f containers/R/Dockerfile .
```

# Building singularity containers

The script works by creating a local Docker repostiory:
```
singularity/from_docker_image.sh hello
singularity/from_docker_image.sh gwas
singularity/from_docker_image.sh python3
singularity/from_docker_image.sh ldsc
singularity/from_docker_image.sh r
```

# Running docker containers (misc commands)

```
docker run -it r
docker run -it -v $COMORMENT_REF:/ref demo 
```
# Running singularity containers (misc commands)

```
singularity shell --no-home -B $(pwd):/data demo.sif
singularity shell --no-home -B $(pwd):/data python3.sif
```

# misc
Docker quickly consumes a lot of disc space. Use ``sudo docker system df`` to check current usage, and ``sudo docker system prune -a`` to clean up.


# Issues with internet inside Docker containers

This was useful:
https://stackoverflow.com/questions/20430371/my-docker-container-has-no-internet
