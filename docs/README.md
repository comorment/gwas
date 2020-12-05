# Singularity container for GWAS and post-GWAS analysis

Singularity container to perform miscellaneous distributed analysis . Here are the all available tools:

General software
- R + basic modules (ggplot, table  etc)
- Python  + basic modules  (numpy, pandas, scipy, ...)

GWAS
- plink & plink2 
- fastGWA (GCTA) - https://cnsgenomics.com/software/gcta/#Overview
- Bolt-LMM - https://alkesgroup.broadinstitute.org/BOLT-LMM/downloads/BOLT-LMM_v2.3.4_manual.pdf


META-analysis
- METAL - https://genome.sph.umich.edu/wiki/METAL_Documentation

Polygenic risk:
- PRSice2 - https://www.prsice.info/

Relatedness / PCA analysis
- KING http://people.virginia.edu/~wc9c/KING/
- flashPCA https://github.com/gabraham/flashpca

Genetic Epidemiology
- HDL  https://github.com/zhenin/HDL 
-GenomicSEM https://github.com/MichelNivard/GenomicSEM/wiki/1.-Installing-GenomicSEM

-GCTA https://cnsgenomics.com/software/gcta/#Overview
-GCTB. https://cnsgenomics.com/software/gctb/

Data formatting tools
- https://www.well.ox.ac.uk/~gav/qctool_v2/
- http://vcftools.sourceforge.net/
- http://samtools.github.io/bcftools/bcftools.html


Post-gwas analysis   # need to rename python_convert -> sumstats
- Harmonize GWAS summary statistics  - https://github.com/precimed/python_convert/ sumstats.py  (this needs to be cleaned first )
- Manhattan plot & QQ plots - https://github.com/precimed/python_convert/ manhattan.py and qq.py




## Getting Started

In order to run the developed Docker and Singularity containers you need to install Docker (https://docs.docker.com/get-docker/) and Singularity (https://sylabs.io/guides/3.6/user-guide/quick_start.html?highlight=install),  respectively. You can run each container separately. 

You can find the details related to containers [here](docs/intro.md#section)
 
For plink see [here](docs/plink.md#section)

For others see [here](docs/others.md#section)

