## Tutorial for running a GWAS on synthetic dataset

Start ``gwas.sif`` container, generate synthetic phenotype with 100 causal genetic variants, and run ``plink2`` to compute Relatedness via GCTA tool

This is a demo using synthetic genotypes (10K subjects, 150K SNPs), produced by HapGen2 tool.

First we need to generate synthetic phenotype for corresponding subjects.

```
singularity shell --no-home -B $COMORMENT_REF:/ref -B data:/data gwas.sif
simu_linux --bfile /ref/hapgen/chr21 --qt  --out /data/simu

```

Then  SNP-based heritability is  calculated  to obtain Genomic Relationship Matrix (GRM)

```
gcta64 --bfile /ref/hapgen/chr21   --maf 0.01  --make-grm --out /data/out1

```

Once we get GRM, the next step is removing individuals from GRM whose relationship is greater than cutoff value.

```
gcta64 --grm /data/out1 --grm-cutoff 0.06 --make-grm --out /data/out2

```

Then we can calculate the SNP heritability as

```
gcta64 --grm /data/out2 --pheno /data/simu.pheno --reml --out /data/out3

```

The Result:


```
Calculating prior values of variance components by EM-REML ...
Updated prior values: 0.411283 0.401555
logL: -82.9901
Running AI-REML algorithm ...
Iter.	logL	V(G)	V(e)	
1	-82.95	0.52216	0.30136	
2	-82.39	0.75303	0.10077	
3	-82.00	0.72804	0.12782	
4	-81.99	0.73161	0.12498	
5	-81.99	0.73117	0.12535	
6	-81.99	0.73122	0.12530	
Log-likelihood ratio converged.

Calculating the logLikelihood for the reduced model ...
(variance component 1 is dropped from the model)
Calculating prior values of variance components by EM-REML ...
Updated prior values: 0.80763
logL: -87.22069
Running AI-REML algorithm ...
Iter.	logL	V(e)	
1	-87.22	0.80763	
Log-likelihood ratio converged.

Summary result of REML analysis:
Source	Variance	SE
V(G)	0.731224	0.255773
V(e)	0.125304	0.207487
Vp	0.856528	0.091236
V(G)/Vp	0.853707	0.248444

Sampling variance/covariance of the estimates of variance components:
6.541974e-02	-5.007332e-02	
-5.007332e-02	4.305091e-02	

Summary result of REML analysis has been saved in the file [/data/out3.hsq].
```
