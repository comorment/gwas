all: hello.sif gwas.sif python3.sif ldsc.sif r.sif saige.sif enigma-cnv.sif matlabruntime.sif

%.sif: containers/%/Dockerfile
	docker build -t $* -f containers/$*/Dockerfile . && singularity/from_docker_image.sh $*
