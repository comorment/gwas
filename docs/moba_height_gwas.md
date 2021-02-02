This document describes a preliminary analysis of Height GWAS in two genotype batches of the MoBa study (HCE batch, and OMNI batch). 
Each GWAS include 13500 subjects (after QC and constraining on individual having phenotypic values and all covariates).

The following procedure is repeated twice - first time for the HCE batch, second time for the OMNI batch.

```
export GENO=/cluster/projects/p697/projects/moba_qc_imputation/OF/HCE; export BATCH=hce; LASTBATCH=2;    # for hce batch
export GENO=/cluster/projects/p697/projects/moba_qc_imputation/OF/OMNI; export BATCH=omni; LASTBATCH=3;  # for omni batch
export PHENO=/cluster/projects/p697/projects/moba_qc_imputation/OF/gwas/data
export OUT=/cluster/projects/p697/projects/moba_qc_imputation/OF/gwas/out   # OUT directory should be your own custom output directory ( hence do not copy paste it)
export REF=/cluster/projects/p697/projects/moba_qc_imputation/OF/gwas/ref

# perform GWAS
singularity shell --no-home -B $GENO:/geno -B $PHENO:/pheno -B $OUT:/out gwas.sif
for CHRI in {1..22}; do echo "plink2 --bed /geno/chr$CHRI.step10.imputed.bed --bim /geno/chr$CHRI.step10.imputed.bim --fam /geno/chr$CHRI.step10.fam --glm hide-covar --pheno /pheno/${BATCH}_height.pheno --pheno-name Height --covar /pheno/$BATCH.asfactor.cov  --covar-name SEX BATCH-BATCH1$LASTBATCH Age PC1-PC20 --covar-variance-standardize  --out /out/${BATCH}.chr$CHRI --maf 0.05"; done | bash

# combine results across chromosomes
singularity shell --no-home -B $OUT:/out -B $REF:/ref python3.sif

python
import os, glob, pandas as pd
df=pd.concat([pd.read_csv(x, delim_whitespace=True) for x in glob.glob('/out/{}.chr*.Height.glm.linear'.format(os.getenv('BATCH')))])      # update BATCH here
df.to_csv('/out/{}.Height.glm.linear'.format(os.getenv('BATCH')), index=False, sep='\t')

# make QQ plots, find loci, make Manhattan plots.
singularity shell --no-home -B $OUT:/out -B $REF:/ref python3.sif

python /tools/python_convert/qq.py /out/$BATCH.Height.glm.linear --p P --snp ID  --out /out/$BATCH.Height.glm.linear.png

python /tools/python_convert/sumstats.py clump \
  --sumstats  /out/$BATCH.Height.glm.linear --clump-field P --clump-snp-field ID --chr '#CHROM' \
  --out /out/$BATCH.Height.clump \
  --bfile-chr /ref/1000genomes/EUR.chr@.filt

python /tools/python_convert/manhattan.py /out/$BATCH.Height.glm.linear --p P --snp ID --bp POS --chr "#CHROM" --out /out/$BATCH.Height.glm.linear.manh \
  --lead /out/$BATCH.Height.clump.lead.csv \
  --indep /out/$BATCH.Height.clump.indep.csv \

# TBD - run LD score regression
singularity shell --no-home -B $OUT:/out -B $REF:/ref ldsc.sif
python /tools/ldsc/munge_sumstats.py --merge-alleles /ref/ldsc/w_hm3.snplist --sumstats /out/hce.Height.glm.linear --out /out/hce.Height.sumstats.gz --signed-sumstats T_STAT,0 --N-col OBS_CT --ignore A1 --a1 REF --a2 ALT  --snp ID
```
