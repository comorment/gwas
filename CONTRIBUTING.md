# Building containers
docker build -t demo -f containers/demo/Dockerfile .
docker build -t gwas -f containers/gwas/Dockerfile .
docker build -t ldsc -f containers/ldsc/Dockerfile .

# Running containers
docker run -it -v /home/oleksanf/github/comorment/comorment_data/:/data demo 
