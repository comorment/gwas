## Tutorial for running a GWAS on synthetic dataset

singularity shell --no-home -B $COMORMENT_REF:/ref -B data:/data gwas.sif
simu_linux --bfile /ref/hapgen/chr21 --qt --causal-n 100 --out /data/simu
plink2 --bfile /ref/hapgen/chr21 --glm allow-no-covars --pheno /data/simu.pheno --pheno-name trait1 --out /data/plink

singularity shell --no-home -B $COMORMENT_REF:/ref -B data:/data conda.sif

## Tutorial for running LD score regression

python /tools/ldsc/munge_sumstats.py --merge-alleles /ref/ldsc/w_hm3.snplist --sumstats /data/plink.trait1.glm.linear --out /data/plink.trait1 --signed-sumstats T_STAT,0 --snp ID --N-col OBS_CT --a1 REF --a2 ALT --ignore A1

python /tools/ldsc/ldsc.py --h2 /data/plink.trait1.sumstats.gz \
--ref-ld-chr /ref/ldsc/eur_w_ld_chr/ \
--w-ld-chr /ref/ldsc/eur_w_ld_chr/ \
--out /data/plink.trait2
