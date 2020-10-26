# Docker and Singularity containers for Distributed Analysis

Docker and Singularity containers to perform miscellaneous distributed analysis . Here are the all available tools:

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

Data formatting tools
- https://www.well.ox.ac.uk/~gav/qctool_v2/
- http://vcftools.sourceforge.net/
- http://samtools.github.io/bcftools/bcftools.html

Post-gwas analysis   # need to rename python_convert -> sumstats
- Harmonize GWAS summary statistics  - https://github.com/precimed/python_convert/ sumstats.py  (this needs to be cleaned first )
- Manhattan plot & QQ plots - https://github.com/precimed/python_convert/ manhattan.py and qq.py




## Getting Started

In order to run the developed Docker and Singularity containers you need to install Docker (https://docs.docker.com/get-docker/) and Singularity (https://sylabs.io/guides/3.6/user-guide/quick_start.html?highlight=install),  respectively. You can run each container separately.

Note that, you can try different analysis other than the one  presented here as introductive example. For more detailed information you can examine the links provided above as well as  [1] (https://www.intro-statistical-genetics.com/data-code ) (ch. 10). 
 

## For Docker Container

1. Pull the docker container from Docker Hub

```
docker pull bayramalex/all_analysis

```

2. You can run the pulled containers in different ways based on the purpose

### Passive mode

```
docker run  bayramalex/all_analysis <your Plink analysis>

```

Example: 

```
docker run  bayramalex/all_analysis plink   	 --bfile 1kg_EU_qc\
         	 --pheno BMI_pheno.txt \
       	 --make-bed --out 1kg_EU_BMI 
    
 ```


### Interactive mode

```
docker run  -it bayramalex/all_analysis

```

Once you run the code, you have entered inside the container (indicated by '#' sign), then you can run any analysis without typing docker commands as:



Example: 

```
./plink   	 --bfile 1kg_EU_qc\
         	 --pheno BMI_pheno.txt \
       	 --make-bed --out 1kg_EU_BMI 
	 
	 
```
 
You can observe the created  1kg_EU_BMI.bed + 1kg_EU_BMI.bim + 1kg_EU_BMI.fam  inside the container. Now you can perform GWAS analysis as


```
./plink    	 --bfile 1kg_EU_BMI \
        	 --snps rs9674439 \
       	 --assoc \
      	 --linear \
      	 --out BMIrs9674439
```



### Mounting your data to container
It is desired to do analysis with your own data. At this point it is required to mount  a path to the container and do analysis on the data in this path. 

```
docker run  -it -v  /your/local/path:/INPUT bayramalex/all_analysis

```
For  example

```
docker run  -it -v  /Users/bayramakdeniz/mydataset:/INPUT bayramalex/all_analysis

```

Once you run this, you will observe an interactive container with an additional INPUT folder which is actually /your/local/path. Now you can do your analysis with your data by indicating the place of it by "INPUT/ "   such as: 


```
./plink    	 --bfile INPUT/1kg_EU_BMI \
        	 --snps rs9674439 \
       	 --assoc \
      	 --linear \
      	 --out INPUT/BMIrs9674439
```
 
 Keep in mind that, the generated outputs after analysis can be both found in INPUT/ and /your/local/path.
 
 It is also possible to run it with passive mode as:
 
 ```
docker run   -v  /your/local/path:/INPUT bayramalex/all_analysis ./plink    --bfile INPUT/1kg_EU_BMI \
        	 --snps rs9674439 \
       	 --assoc \
      	 --linear \
      	 --out INPUT/BMIrs9674439
    
```

 
 ### Other analysis

 #### PRSICE2 
 
 with data inside the container
 
 ```
docker run  -it bayramalex/all_analysis    Rscript PRSice.R --dir . \
    --prsice PRSice_linux \
    --base BMI.txt \
    --target 1kg_hm3_qc \
    --snp MarkerName \
    --A1 A1 \
    --A2 A2 \
    --stat Beta \
    --pvalue Pval \
    --pheno-file BMI_pheno.txt \
    --bar-levels 1 \
    --fastscore \
    --binary-target F \
    --out BMI_score_all

```

with your own data


 ```
docker run   -v  /your/local/path:/INPUT bayramalex/all_analysis  Rscript PRSice.R --dir . \
    --prsice ./PRSice_linux \
    --base INPUT/BMI.txt \
    --target INPUT/1kg_hm3_qc \
    --thread 1 \
    --snp MarkerName \
    --A1 A1 \
    --A2 A2 \
    --stat Beta \
    --pvalue Pval \
    --bar-levels 5e-08,5e-07,5e-06,5e-05,5e-04,5e-03,5e-02,5e-01 \
    --fastscore \
    --all-score \
    --no-regress \
    --binary-target F \
    --out INPUT/BMIscore_thresholds  
```
 

 
 
 #### fastGWA
 
 with test data inside the container:

  ```
docker run -it  bayramalex/all_analysis  gcta64 --bfile test --make-grm-part 100 1 --thread-num 5 --out test
 ```
 
 with your own data: 
  
  ```
  docker run  -it -v  /your/local/path:/INPUT  bayramalex/all_analysis   gcta64 --bfile INPUT/your_data --make-grm-part 100 1 --thread-num 5 --out INPUT/your_data_output
 ```
 

 
 
  #### BoltLMM
  
   with test data inside the container:
   
   ```   
    
   docker run -it  bayramalex/all_analysis  bolt \
    --bfile=EUR_subset \
    --phenoFile=EUR_subset.pheno2.covars \
    --exclude=EUR_subset.exclude2 \
    --phenoCol=PHENO \
    --phenoCol=QCOV1 \
    --modelSnps=EUR_subset.modelSnps2 \
    --reml \
    --numThreads=2 \
    2>&1 | tee example_reml2.log 
    
  ```
    
    
    
 with your own data : Lets work on with your own data placed on  /your/local/path. We need to assign this path to container with an arbitrary path,  lets say  /fld 
   
    ```
     docker run  -it -v   /your/local/path:/fld   bayramalex/all_analysis       bolt \
    --bfile=fld/EUR_subset \
    --phenoFile=fld/EUR_subset.pheno2.covars \
    --exclude=fld/EUR_subset.exclude2 \
    --phenoCol=PHENO \
    --phenoCol=QCOV1 \
    --modelSnps=fld/EUR_subset.modelSnps2 \
    --reml \
    --numThreads=2 \
    2>&1 | tee fld/example_reml2.log
      
      ```
      
   
 #### METAL
 
 
 
 #### KING
 with test data inside the container:

  ```
docker run -it  bayramalex/all_analysis  king -b TOY_TARGET_DATA.bed  --related  
  ```  
  
  
with your own data: 
  
  ``` 
  docker run  -it -v  /your/local/path:/INPUT  bayramalex/all_analysis    king -b INPUT/your_data  --related  
  ```
  
 #### flashPCA
 
  with test data inside the container:
  
  ```
docker run -it   bayramalex/all_analysis  flashpca --bfile  TOY_TARGET_DATA
  ```  
 
 with your own data 
 
   ``` 
  docker run  -it -v  /your/local/path:/INPUT  bayramalex/all_analysis   flashpca --bfile  INPUT/your_data
   ```  
  
  
  Data Formatting
  
   #### qctool
   Conversion between .vcf and .bgen
   
     with test data inside the container:
   
  ``` 
   docker run -it  bayramalex/all_analysis   /bin/bash -c   "plink --bfile test  --recode vcf-iid --out test_vcf  && qctool -g test_vcf.vcf  -og example.bgen"   
  ```  
  
  with your own data
  
 ``` 
   docker run  -it -v  /your/local/path:/INPUT  bayramalex/all_analysis  /bin/bash -c   "plink --bfile  INPUT/your_data  --recode vcf-iid --out INPUT/test_vcf  && qctool -g INPUT/test_vcf.vcf  -og  INPUT/example.bgen"   
``` 
    
    #### vcftool
    
  with test data inside the container:
   
  ``` 
   docker run -it  bayramalex/all_analysis  /bin/bash -c   "plink --bfile test  --recode vcf-iid --out test_vcf  &&  vcftools --vcf test_vcf.vcf --recode-bcf --recode-INFO-all --out converted_output"   
```  
     
 with your own data:
    
  ``` 
   docker run  -it -v  /your/local/path:/INPUT  bayramalex/all_analysis  /bin/bash -c   "plink --bfile  INPUT/your_data  --recode vcf-iid --out INPUT/test_vcf  && vcftools --vcf INPUT/test_vcf.vcf --recode-bcf --recode-INFO-all --out INPUT/converted_output"   
 ``` 


  

## For Singularity Container 

1- Build Singularity image from Docker Hub

 ```
singularity build imagename.sif docker://bayramalex/all_analysis:latest

```

Alternatively you can build it as  'sandbox' to use it in passive mode

```
singularity build --sandbox imagename2/  docker://bayramalex/all_analysis:latest

```

Here  a container folder called imagename2 is created in the working directory. You can cd to this folder and work as if you  are working in the passive mode in Docker.

In the following examples we will use these two created containers called  imagename.sif  and imagename2 for working with your own data and with the data inside the container respectively. Note that  imagename2 is the sandbox version of imagename.sif  that you can use container as a folder and   you can use any cantainer name instead of them. 


2- Go to the directory where your data is: cd ~/your/local/path



Run the container by mounting this directory

```
singularity exec -B  $(pwd):/INPUT /path/of/the/container/imagename.sif  <your plink analysis>

```

For Example

```
 
 singularity exec -B  $(pwd):/INPUT /home/bayram/Gwas/imagename.sif  plink   --bfile  /INPUT/1kg_EU_BMI --pheno /INPUT/BMI_pheno.txt   --make-bed --out /INPUT/1kg_EU_BMI 

```


```
singularity exec -B  $(pwd):/INPUT /home/bayram/Gwas/imagename.sif plink    	 --bfile /INPUT/1kg_EU_BMI \
        	 --snps rs9674439 \
       	 --assoc \
      	 --linear \
      	 --out /INPUT/BMIrs9674439
```

Note that the resulting files will be put in  /INPUT/ which is your working directory.


 ### Other analysis
 
 #### PRSICE2


 
 
 ```
singularity exec -B  $(pwd):/INPUT /home/bayram/GRSworkflow/imagename.sif Rscript PRSice.R --dir . \
    --prsice PRSice_linux \
    --base /INPUT/BMI.txt \
    --target /INPUT/1kg_hm3_qc \
    --snp MarkerName \
    --A1 A1 \
    --A2 A2 \
    --stat Beta \
    --pvalue Pval \
    --pheno-file /INPUT/BMI_pheno.txt \
    --bar-levels 1 \
    --fastscore \
    --binary-target F \
     --out /INPUT/BMI_score_all

```
  

 with test data inside the container: Go to the path where the sandbox imagename2 container is:


```
singularity exec imagename2  Rscript  imagename2/PRSice.R --dir . \
    --prsice /PRSice_linux \
    --base imagename2/BMI.txt \
    --target imagename2/1kg_hm3_qc \
    --snp MarkerName \
    --A1 A1 \
    --A2 A2 \
    --stat Beta \
    --pvalue Pval \
    --pheno-file imagename2/BMI_pheno.txt \
    --bar-levels 1 \
    --fastscore \
    --binary-target F \
    --out BMI_score_all

```


 
 
 #### fastGWA
 
 with test data inside the container:

 ```
  singularity exec   imagename2     gcta64 --bfile  imagename2/1kg_EU_qc  --make-grm-part 100 1 --thread-num 5 --out  your_data_output
 ```
 
  with with your own data 
  
```
singularity exec  --bind   your/local/path:/INPUT path/of/the/container/imagename.sif  gcta64 --bfile /INPUT/your_data  --make-grm-part 100 1 --thread-num 5 --out /INPUT/your_data_output
```



  #### BoltLMM
  
   with test data inside the container:
   
 ```
  singularity exec   imagename2     bolt \
    --bfile=imagename2/EUR_subset \
    --phenoFile=imagename2/EUR_subset.pheno2.covars \
    --exclude=imagename2/EUR_subset.exclude2 \
    --phenoCol=PHENO \
    --phenoCol=QCOV1 \
    --modelSnps=imagename2/EUR_subset.modelSnps2 \
    --reml \
    --numThreads=2 \
    2>&1 | tee imagename2/example_reml2.log
    
  ```
    
 with your own data : Lets work on with your own data placed on  /your/local/path. We need to assign this path to container with an arbitrary path,  lets say  /fld 
     
        ```
     singularity exec  --bind   your/local/path:/fld path/of/the/container/imagename.sif    bolt \
    --bfile=/fld/EUR_subset \
    --phenoFile=/fld/EUR_subset.pheno2.covars \
    --exclude=/fld/EUR_subset.exclude2 \
    --phenoCol=PHENO \
    --phenoCol=QCOV1 \
    --modelSnps=/fld/EUR_subset.modelSnps2 \
    --reml \
    --numThreads=2 \
    2>&1 | tee /fld/example_reml2.log
        ```       

 #### METAL
 
 



 #### KING
 
  with test data inside the container:

 ```
  singularity exec   imagename2    king -b  imagename2/TOY_TARGET_DATA.bed  --related  
```
  with with your own data 

 ```
singularity exec  --bind   your/local/path:/INPUT path/of/the/container/imagename.sif  king -b  /INPUT/your_data.bed  --related  
```

 #### flashPCA
 
  with test data inside the container:
  
 ```
  singularity exec   imagename2 flashpca --bfile   imagename2/TOY_TARGET_DATA
  ```  
 
 with your own data 
 
   ``` 
  singularity exec  --bind   your/local/path:/INPUT path/of/the/container/imagename.sif  flashpca --bfile   /INPUT/your_data
   ```  
   
   

  Data Formatting
  
   #### qctool # these is an issue on permission
   Conversion between .vcf and .bgen
   
 with test data inside the container:
   
 ``` 
   singularity exec   imagename2  qctool -g  imagename2/1kg_EU_qc_vcf.vcf -og  example.bgen  
  ```  
  
  
  
  with your own data
  
 ``` 
  singularity exec  --bind   your/local/path:/INPUT path/of/the/container/imagename.sif  qctool -g INPUT/test_vcf.vcf  -og  INPUT/example.bgen"   
 ``` 
    
    #### vcftool
    
  with test data inside the container:  (vcf to bcf)
   
  ``` 
  singularity exec   imagename2 vcftools --vcf  imagename2/1kg_EU_qc_vcf.vcf   --recode-bcf --recode-INFO-all --out converted_output   
  ```  
     
 with your own data:
    
  ``` 
  singularity exec  --bind    your/local/path:/INPUT T path/of/the/container/imagename.sif  vcftools --vcf /INPUT/test_vcf.vcf --recode-bcf --recode-INFO-all --out /INPUT/converted_output  
``` 
  

 
  
  

## References

[1] MILLS, Melinda C.; BARBAN, Nicola; TROPF, Felix C. An Introduction to Statistical Genetic Data Analysis. MIT Press, 2020.


