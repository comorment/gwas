# Tutorial for Data Format Conversion

This is a tutorial on how to convert one genetic format to another(such as .bed, .vcf, .bgen, .bcf). For this aim plink2, vcftools and qctool are used.

```
singularity shell --no-home -B $COMORMENT_REF:/ref -B data:/data gwas.sif
plink --bfile /ref/hapgen/chr21  --recode vcf-iid --out /data/chr1_vcf
qctool -g  /data/chr1_vcf.vcf -og  /data/chr21.bgen 
vcftools --vcf  /data/chr1_vcf.vcf  --recode-bcf --recode-INFO-all --out data/chr21.bcf  
```

