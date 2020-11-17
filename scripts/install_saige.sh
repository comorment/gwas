#!/bin/sh


# saige

wget https://raw.githubusercontent.com/weizhouUMICH/SAIGE/master/conda_env/environment-RSAIGE.yml
conda env create -f environment-RSAIGE.yml

conda activate RSAIGE
FLAGPATH=`which python | sed 's|/bin/python$||'`
export LDFLAGS="-L${FLAGPATH}/lib"
export CPPFLAGS="-I${FLAGPATH}/include"


#R -e "chooseCRANmirror(graphics=FALSE)"

R -e "install.packages('MetaSKAT')"



src_branch=0.39.2
repo_src_url=https://github.com/weizhouUMICH/SAIGE
git clone --depth 1 -b $src_branch $repo_src_url

R CMD INSTALL --library=path_to_final_SAIGE_library SAIGE

#cp vcftools  /bin
