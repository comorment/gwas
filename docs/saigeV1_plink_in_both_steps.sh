singularity shell -B $PWD:/OUT saige.sif

cd //

Rscript /usr/local/bin/step1_fitNULLGLMM.R     \
        --plinkFile=./REF/examples/regenie/example_3chr \
        --phenoFile=./REF/examples/regenie/example_3chr.pheno \
        --phenoCol=PHENO \
        --covarColList=PC1,PC2 \
        --sampleIDColinphenoFile=IID \
        --traitType=quantitative       \
        --outputPrefix=/OUT/example_binary \
        --nThreads=2    \
        --IsOverwriteVarianceRatioFile=TRUE




    Rscript /usr/local/bin/step2_SPAtests.R        \
        --bedFile=./REF/examples/regenie/example_3chr.bed      \
        --bimFile=./REF/examples/regenie/example_3chr.bim      \
        --famFile=./REF/examples/regenie/example_3chr.fam       \
        --SAIGEOutputFile=/OUT/example_3chr.txt \
        --chrom=1       \
        --minMAF=0 \
        --minMAC=20 \
        --GMMATmodelFile=/OUT/example_binary.rda \
        --varianceRatioFile=/OUT/example_binary.varianceRatio.txt

