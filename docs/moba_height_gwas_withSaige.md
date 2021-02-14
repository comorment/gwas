export GENO=/cluster/projects/p697/projects/moba_qc_imputation/OF/HCE; export BATCH=hce; LASTBATCH=2;    # for hce batch
#export GENO=/cluster/projects/p697/projects/moba_qc_imputation/OF/OMNI; export BATCH=omni; LASTBATCH=3;  # for omni batch
export PHENO=/cluster/projects/p697/projects/moba_qc_imputation/OF/gwas/data
export OUT=$PWD/outsaige   # OUT directory should be your own custom output directory ( hence do not copy paste it)
export REF=/cluster/projects/p697/projects/moba_qc_imputation/OF/gwas/ref


# combine pheno and covariates

singularity shell --no-home -B $PHENO:/pheno  python3.sif

cd pheno
python3
import pandas as pd


df1=pd.read_csv('hce_height.pheno', delimiter="\t")
df2=pd.read_csv('hce.asfactor.cov', delimiter="\t")
dff=pd.merge(df1,df2, on='IID', how='inner')
dff.to_csv('pheno_cov.txt', header=True, index=False, sep='\t', mode='a')


singularity shell --no-home -B $GENO:/geno -B $PHENO:/pheno -B $OUT:/out saig.sif


#saige step1

for CHRI in {21..21}; do echo "

Rscript /SAIGE/extdata/step1_fitNULLGLMM.R     \
        --plinkFile=./geno/chr$CHRI.step10.imputed \
        --phenoFile=./pheno/pheno_cov.txt \
        --phenoCol=Height \
        --covarColList=PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,PC11,PC12,PC13,PC14,PC15,PC16,PC17,PC18,PC19,PC20  \
        --sampleIDColinphenoFile=IID \
        --traitType=quantitative       \
	      --invNormalize=FALSE	\
        --outputPrefix=./out/${BATCH}.chr$CHRI \
        --nThreads=4 \
        --LOCO=FALSE	\
        --minMAF=0.01 \
        --tauInit=1,0"; done | bash


singularity shell --no-home -B $GENO:/geno -B $PHENO:/pheno -B $OUT:/out gwas.sif




# convert to vcf

for CHRI in {1..22}; do echo "

plink --bfile geno/chr$CHRI.step10.imputed  --recode vcf-iid --out geno/chr$CHRI.step10
bcftools query -l geno/chr$CHRI.step10.vcf > geno/samples$CHRI.txt "; done | bash


# compress vcf

module load htslib

for CHRI in {1..22}; do echo "
bgzip -c $GENO/chr$CHRI.step10.vcf > $GENO/chr$CHRI.step10.vcf.gz
tabix -p vcf $GENO/chr$CHRI.step10.vcf.gz  "; done | bash


#saige step2

singularity shell --no-home -B $GENO:/geno -B $PHENO:/pheno -B $OUT:/out saig.sif



for CHRI in {1..22}; do echo "
        Rscript /SAIGE/extdata/step2_SPAtests.R        \
                --vcfFile=./geno/chr$CHRI.step10.vcf.gz \
                --vcfFileIndex=./geno/chr$CHRI.step10.vcf.gz.tbi \
                --vcfField=GT \
                --chrom=$CHRI \
                --minMAF=0.001 \
                --minMAC=1 \
                --sampleFile=./geno/samples$CHRI.txt \
                --GMMATmodelFile=./out/${BATCH}.chr$CHRI.rda \
                --varianceRatioFile=./out/${BATCH}.chr$CHRI.varianceRatio.txt \
                --SAIGEOutputFile=./out/${BATCH}.chr$CHRI.linear \
                --numLinesOutput=2 \
                --IsOutputAFinCaseCtrl=TRUE    "; done | bash



singularity shell --no-home -B $OUT:/out -B $REF:/ref python3.sif

python
import os, glob, pandas as pd
df=pd.concat([pd.read_csv(x, delim_whitespace=True) for x in glob.glob('/out/{}.chr*.linear'.format(os.getenv('BATCH')))])      # update BATCH here
df.to_csv('/out/{}.chr.All.linear'.format(os.getenv('BATCH')), index=False, sep='\t')

singularity shell --no-home -B $OUT:/out -B $REF:/ref python3.sif

python /tools/python_convert/qq.py /out/$BATCH.chr.All.linear --p p.value --snp SNPID  --out /out/$BATCH.chr.All.png



python /tools/python_convert/sumstats.py clump \
--sumstats  /out/$BATCH.chr.All.linear --clump-field p.value --clump-snp-field SNPID --chr "CHR" \
--out /out/$BATCH.Height.clump \
--bfile-chr /ref/1000genomes/EUR.chr@.filt

python /tools/python_convert/manhattan.py /out/$BATCH.chr.All.linear --p p.value --snp SNPID --bp POS --chr "CHR" --out /out/$BATCH.Height.glm.linear.manh \
--lead /out/$BATCH.Height.clump.lead.csv \
--indep /out/$BATCH.Height.clump.indep.csv
