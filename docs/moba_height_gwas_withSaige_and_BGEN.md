export GENO=/cluster/projects/p697/projects/moba_qc_imputation/OF/HCE; export BATCH=hce; LASTBATCH=2;    # for hce batch
#export GENO=/cluster/projects/p697/projects/moba_qc_imputation/OF/OMNI; export BATCH=omni; LASTBATCH=3;  # for omni batch
export PHENO=/cluster/projects/p697/projects/moba_qc_imputation/OF/gwas/data
export OUT=$PWD/outsaige_imputed   # OUT directory should be your own custom output directory ( hence do not copy paste it)
export REF=/cluster/projects/p697/projects/moba_qc_imputation/OF/gwas/ref

export BGEN=/cluster/projects/p697/users/bayramc/bgendata # Assuming that BGEN data is not available. Then it will be converted from plink file in GENO. 
#If you already have .bgen data you may change this directory as the directory where the .bgen files are. Note that, bgen files should be 8-bit formatted and must also have .bgi (index) file to run with SAIGE

# combine pheno and covariates

singularity shell --no-home -B $PHENO:/pheno  python3.sif

cd pheno
python3
import pandas as pd


df1=pd.read_csv('hce_height.pheno', delimiter="\t")
df2=pd.read_csv('hce.asfactor.cov', delimiter="\t")
dff=pd.merge(df1,df2, on='IID', how='inner')
dff.to_csv('hce_pheno_covAa.txt', header=True, index=False, sep='\t', mode='a')


singularity shell --no-home -B $GENO:/geno -B $PHENO:/pheno -B $OUT:/out saige.sif


# saige step1

for CHRI in {1..22}; do echo "

        step1_fitNULLGLMM.R     \
        --plinkFile=./geno/chr$CHRI.step10.imputed \
        --phenoFile=./pheno/hce_pheno_covAa.txt \
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



# convert plink files to bgen if you do not have already existing bgen files (must have 8 bits formats)

singularity shell --no-home -B $GENO:/geno -B $PHENO:/pheno -B $OUT:/out -B $BGEN:/bgendata gwas.sif



for CHRI in {1..22}; do echo "

plink2 --bfile geno/chr$CHRI.step10.imputed  --export bgen-1.2 'bits=8'  --out bgendata/chr$CHRI.step10.imputedAa "; done | bash


# get samplefiles suitable for step2 from bgen sample.file

singularity shell --no-home -B $GENO:/geno -B $PHENO:/pheno -B $OUT:/out -B $BGEN:/bgendata python3.sif


python3
import pandas as pd
for x in range(1, 23, 1):
  s1='/bgendata/chr'
  s2=str(x)
  s3='.step10.imputedAa.sample'
  s=s1+s2+s3
  df1=pd.read_csv(s, delimiter=' ')
  df2=df1.ID_2
  df3=df2[1:]
  s11='/pheno/chr'
  s22=str(x)
  s33='_sample2.txt'
  ss=s11+s22+s33
  df3.to_csv(ss, header=False, index=False, sep='\t', mode='a')


# get corresponding index files of each bgen file (.bgi)


singularity shell --no-home -B $GENO:/geno -B $PHENO:/pheno -B $OUT:/out -B $BGEN:/bgendata python3.sif
cd bgendata

for CHRI in {1..22}; do  bgenix -g chr$CHRI.step10.imputedAa.bgen -index ;   done 


# saige step2

singularity shell --no-home -B $GENO:/geno -B $PHENO:/pheno -B $OUT:/out -B $BGEN:/bgendata saige.sif

for CHRI in {1..22}; do echo "

                step2_SPAtests.R        \
                --bgenFile=./bgendata/chr$CHRI.step10.imputedAa.bgen \
                --bgenFileIndex=./bgendata/chr$CHRI.step10.imputed.bgenAa.bgi \
                --minMAF=0.001 \
                --minMAC=1 \
                --sampleFile=./pheno/chr${CHRI}_sample2.txt \
                --GMMATmodelFile=./out/hce.chr$CHRI.rda \
                --varianceRatioFile=./out/${BATCH}.chr$CHRI.varianceRatio.txt \
                --SAIGEOutputFile=./out/${BATCH}.chr$CHRI.linear \
                --numLinesOutput=2 \
                --LOCO=FALSE \
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
