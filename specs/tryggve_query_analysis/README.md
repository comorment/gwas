

# Running R markdown script for query analysis in singularity containers



# =================================
# TESTING with singularity

Step by Step guide how to run query analysis with singularity container


## Step 0. Downloading required containers and preparing required masterfile and phenotype-files (phenofiles)

a-In order to run query analysis you need to have phenofiles for the corresponding sub-cohorts. These phenofiles should have specific format which has been defined [here](https://github.com/comorment/gwas/blob/main/specs/gwas.md)

b-Copy these corresponding phenofiles to the directories where the plink files of the sub-cohorts exist. Lets call `GENO/` as the directory which includes all cohorts-subcohorts

NOTE: If you have one phenofile which includes samples of all sub-cohorts, we will show how to split them into sub-phenofiles in Step 1. For now, copy this phenofile to all sub-cohort directories where the plink files exist. If you do not require to run Step1, phenofiles are sufficient to run query analysis hence plinkfile is not required in this case.



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

Note: correct format for columns is --columns='col1','col2'  (column as a speperator without space hence not as --columns='col1', 'col2')

d- Then in each sub-cohort directory,  new phenofiles have been created with the same name you typed in masterfile. A backup phenofile for the original phenofile has also been created in each sub-cohort. (if your phenofile is phenofile.txt then the backup is phenofile.txt.txt). You do not need to modify masterfile and you may directly go to Step 2.

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

e-  For running query analysis, basic usage is: (output is created as an html file)

`Rscript tryggve_query.R --queryAnalysis='MainTrait' --pheno='/INPUT/NameOfThemasterfile' --cont_var='continious variables seperated with comma and without space' --bin_var='binary variables seperated with comma and without space' --output=outputname `

Examples:


`Rscript tryggve_query.R --queryAnalysis='AnyF32' --pheno='/INPUT/NOR.tryggve.master.file.tsv' --cont_var='PC1,height,Age' --bin_var='AnyF33,AnyF32' --output=myout9 `

or if you exactly have a phenofile defined [here](https://github.com/comorment/gwas/blob/main/specs/gwas.md). You may run

`Rscript tryggve_query.R --queryAnalysis='MDD' --pheno='/INPUT/NOR.tryggve.master.file.tsv' --cont_var='PC1,PC2,Age' --bin_var='MDD,Sex' --output=myout9 `


NOTE:As defined in --help, note that the correct format for choosing binary and continious traits are:  "--bin_var='MDD,Sex' " without space between traits (hence DO NOT type it as "--bin_var='MDD, Sex' " )


## A Toy Example

Here, we have shown how to run query analysis with a fake data placed container inside. In order to run this you do not need to do the steps above except downloading 'tryggve_query.sif' container

a-  Run the container in any directory you want (lets call this as working directory)

`singularity shell --no-home -B $PWD:/INPUT tryggve_query.sif `

b- copy all required files into your working directory (hence /INPUT) 

```
cp example.tryggve.master.file.tsv /INPUT
cp example.tryggve.pheno.file.tsv  /INPUT
cp -r /fakedata /INPUT
cp README.md /INPUT
cp tryggve.query1.v2_help.Rmd /INPUT
cp tryggve.query1.v2.Rmd /INPUT
cp tryggve_query.R /INPUT
```

This time we also need to copy masterfile which has been already designed for corresponding fakedata

`cp NOR.tryggve.master.file.tsv /INPUT`

c- Now you have copied all required files in your working directory. And almost ready to run the alaysis. First `cd INPUT` and then run the following command command

`Rscript tryggve_query.R --queryAnalysis='AnyF33' --pheno='NOR.tryggve.master.file.tsv' --cont_var='PC1,PC2,Age' --bin_var='AnyF33,AnyF22' --output=myout9 `

when you run the command above, you will be failed and this is expected. The reason is ,the phenofiles placed in /fakedata does not completely obey our pre-defined phenofile [structure](https://github.com/comorment/gwas/blob/main/specs/gwas.md). If you open phenofiles such as /fakadata/cohort/subcohor1/cohort11.pheno,
you will observe that there are some different column names than our pre-defined structure such as 'iid' and 'tcb_age'. Hence if you change these as our agreed format which are 'IID' and 'Age' respectively for each phenofile (note that we have 3 different sub-cohorts in /fakedata) and re-run the command above you can finish query analysis for the toy example and obtain corresponding .html file.
