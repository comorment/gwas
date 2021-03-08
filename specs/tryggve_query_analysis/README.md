

# Running R markdown script for query analysis in singularity containers



# =================================
# TESTING with singularity

Step by Step guide how to run query analysis with singularity container


## Step 0. Downloading required containers and preparing required masterfile and phenotype-files (phenofiles)

a-In order to run query analysis you need to have phenofiles for the corresponding sub-cohorts. These phenofiles should have specific format which has been defined [here](https://github.com/comorment/gwas/blob/main/specs/gwas.md)

b-Copy these corresponding phenofiles to the directories where the plink files of the sub-cohorts exist. Lets call `GENO/` as the directory where includes all cohorts-subcohorts

NOTE: If you have one phenofile which includes samples of all sub-cohorts, we will show how to split them into sub-phenofiles in Step 1. For now, copy this phenofile to all sub-cohort directories where the plink files exist.



c- Download the required singularity containers (python3.sif and rmd-tidyverse.sif) from [Google Drive](https://drive.google.com/drive/folders/1mfxZJ-7A-4lDlCkarUCxEf2hBIxQGO69?usp=sharing).

d- Prepare the masterfile which defines the path of the phenofiles and plink files as defined [here](https://github.com/comorment/Tryggve_psych/blob/master/tryggve.query1.v2/NOR.tryggve.master.file.tsv) . Please obey the column names. For the demonstration purpose, let's dub this file as  "NOR.tryggve.master.file.tsv " 

e- The place of the containers and masterfile should be in same directory. Lets call this directory as `working directory`. This directory should be any parent directory of `GENO/` 


## Step 1 (optional). Splitting phenofile into sub-cohorts and/or filtering interested columns in phenofile

NOTE: This step may only be run if you do not have phenofile specific to each subcohort and/or if you want filter some variables in existing phenofile.  For running this step, .fam  file of each sub-cohort should exist. You may skip this step if you already have sub-cohort specific phenofiles

a- Go to the directory where your masterfile is. Download "phenoFile_split.py" to this directory

b- Run python container and CD to current directory as

`singularity shell --no-home -B $PWD:/INPUT python3.sif`

`cd INPUT`

c- Run the function to split phenofile and filter  variates such as

 `python phenoFile_split.py  --masterfile='NOR.tryggve.master.file.tsv' --seperator='tab'  --columns='Sex','AnyF32','PC1','height','Age','AnyF33'  `

d- Then in each sub-cohort directory,  new phenofiles have been created with the same name you typed in masterfile. A backup phenofile which includes all samples has also been created. You do not need to modify masterfile.

## Step 2. Running the query analysis

a-Go to the working directory where the containers and masterfile is

b- Run the container by attaching current working directory

`singularity shell --no-home -B $PWD:/INPUT tryggve_query.sif `

c- copy all required files into /INPUT 

```
cp example.tryggve.master.file.tsv /INPUT
cp example.tryggve.pheno.file.tsv  /INPUT
cp -r /fakedata /INPUT
cp README.md /INPUT
cp tryggve.query1.v2_help.Rmd /INPUT
cp tryggve.query1.v2.Rmd /INPUT
cp tryggve_query.R /INPUT
```

c- within container `cd INPUT`

d- For help (a html file is created to help how to organize masterfile)
`Rscript tryggve_query.R --help`

e-  For running query analysis (output is created as an html file)

`Rscript tryggve_query.R --queryAnalysis='AnyF32' --pheno='/INPUT/NOR.tryggve.master.file.tsv' --cont_var='PC1,height,Age' --bin_var='AnyF33,AnyF32' --output=myout9 `

or if you exactly have a phenofile defined [here](https://github.com/comorment/gwas/blob/main/specs/gwas.md). You may run

`Rscript tryggve_query.R --queryAnalysis='MDD' --pheno='/INPUT/NOR.tryggve.master.file.tsv' --cont_var='PC1,PC2,Age' --bin_var='MDD,Sex' --output=myout9 `


As defined in --help, note that the correct format for choosing binary and continious traits are:  "--bin_var='MDD,Sex' " without space between traits (hence DO NOT type it as "--bin_var='MDD, Sex' " )

