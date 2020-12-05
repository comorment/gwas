User instructions
-----------------

``gwas`` container has basic tools for GWAS analysis, including plink, prsice-2 and simu (allowing to generate synthetic phenotype).


Dev instructions
----------------

# Building docker container & converting it to singularity
sudo docker build -t gwas -f containers/gwas/Dockerfile .
sudo ./singularity/from_docker_image.sh gwas


