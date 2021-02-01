all: hello.sif gwas.sif python3.sif py3ml.sif ldsc.sif r.sif saige.sif

%.sif: containers/%/Dockerfile
	docker build -t $* -f containers/$*/Dockerfile . && singularity/from_docker_image.sh $*
