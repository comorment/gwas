# Installing GO and Singularity
https://sylabs.io/guides/3.7/user-guide/quick_start.html

# Building containers
docker build -t demo -f containers/demo/Dockerfile .
docker build -t gwas -f containers/gwas/Dockerfile .
docker build -t ldsc -f containers/ldsc/Dockerfile .
docker build -t conda -f containers/conda/Dockerfile .

# Running containers
docker run -it -v /home/oleksanf/github/comorment/comorment_data/:/data demo 

# Building singularity
./singularity/from_docker_image.sh demo
./singularity/from_docker_image.sh conda

# Running singularity containers
singularity shell --no-home -B $(pwd):/data demo.sif
singularity shell --no-home -B $(pwd):/data conda.sif
