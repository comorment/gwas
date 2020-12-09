User instructions
-----------------

``conda`` container has Python and R software distributed via miniconda.
There are the following environments within this container:

* ldsc - python 2.7 environment, setup according to LD score regression dependencies
* py3 - python=3.8 with standard modules (numpy, scipy, pandas, matplotlib, seaborn, jupyterlab)
* Renv - r-essentials, r-base, jupyterlab, r-irkernel

Renv is not usable at this point.
``library(data.table)`` command crashes with the following error:
```
unable to load shared object '/usr/local/envs/Renv/lib/R/library/grDevices/libs//cairo.so':
```

Dev instructions
----------------

# Building docker container & converting it to singularity
sudo docker build -t conda -f containers/conda/Dockerfile .
sudo ./singularity/from_docker_image.sh conda

# ld score regression
singularity shell --no-home -B $COMORMENT_REF:/ref -B data:/data conda.sif
source activate ldsc


# other alternatives instead of --home are --containall and --no-home, but they seem incompatible with jupyter notebook as it writes to $HOME
# it's important to chown conda.sif to your user
singularity shell --home $PWD/data:/home conda.sif
source activate Renv && jupyter notebook --ip=0.0.0.0 --allow-root --port=8080 --no-browser --notebook-dir=/home

# to run from Docker
sudo docker run -it -p 8080:8080 -v $PWD/data:/home conda
source activate Renv && jupyter notebook --ip=0.0.0.0 --allow-root --port=8080 --no-browser --notebook-dir=/home

