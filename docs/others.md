 # For Docker container
 
 ## PRSICE2 
 
 with data inside the container
 
 ```
docker run  -it bayramalex/gwastools    Rscript PRSice.R --dir . \
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
docker run   -v  /your/local/path:/INPUT bayramalex/gwastools  Rscript PRSice.R --dir . \
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
 

 
 
 ## fastGWA
 
 with test data inside the container:

  ```
docker run -it  bayramalex/gwastools  gcta64 --bfile test --make-grm-part 100 1 --thread-num 5 --out test
 ```
 
 with your own data: 
  
  ```
  docker run  -it -v  /your/local/path:/INPUT  bayramalex/gwastools   gcta64 --bfile INPUT/your_data --make-grm-part 100 1 --thread-num 5 --out INPUT/your_data_output
 
 ```
 

 
 
  ## BoltLMM
  
with test data inside the container:
   ```
   docker run -it  bayramalex/gwastools  bolt \
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
   docker run  -it -v   /your/local/path:/fld   bayramalex/gwastools       bolt \
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
   
   
 ## METAL
 
 
 
 ## KING
 with test data inside the container:

  ```
docker run -it  bayramalex/gwastools  king -b TOY_TARGET_DATA.bed  --related  
  ```  
  
  
   with your own data: 
  
  ``` 
  docker run  -it -v  /your/local/path:/INPUT  bayramalex/gwastools    king -b INPUT/your_data  --related  
  ```
  
 ## flashPCA
 
  with test data inside the container:
  
 ```
docker run -it   bayramalex/gwastools  flashpca --bfile  TOY_TARGET_DATA
  ```  
 
 with your own data 
 
   ``` 
  docker run  -it -v  /your/local/path:/INPUT  bayramalex/gwastools   flashpca --bfile  INPUT/your_data
   ```  
  
  
  Data Formatting
  
   ## qctool
   Conversion between .vcf and .bgen
   
     with test data inside the container:
   
   ``` 
   docker run -it  bayramalex/gwastools   /bin/bash -c   "plink --bfile test  --recode vcf-iid --out test_vcf  && qctool -g test_vcf.vcf  -og example.bgen"   
  ```  
  
  with your own data
  
  ``` 
   docker run  -it -v  /your/local/path:/INPUT  bayramalex/gwastools  /bin/bash -c   "plink --bfile  INPUT/your_data  --recode vcf-iid --out INPUT/test_vcf  && qctool -g INPUT/test_vcf.vcf  -og  INPUT/example.bgen"   
 ``` 
    
    ## vcftool
    
  with test data inside the container:
   
  ``` 
   docker run -it  bayramalex/gwastools  /bin/bash -c   "plink --bfile test  --recode vcf-iid --out test_vcf  &&  vcftools --vcf test_vcf.vcf --recode-bcf --recode-INFO-all --out converted_output"   
  ```  
     
 with your own data:
    
   ``` 
   docker run  -it -v  /your/local/path:/INPUT  bayramalex/gwastools  /bin/bash -c   "plink --bfile  INPUT/your_data  --recode vcf-iid --out INPUT/test_vcf  && vcftools --vcf INPUT/test_vcf.vcf --recode-bcf --recode-INFO-all --out INPUT/converted_output"   
   ``` 


  

## For Singularity Container 


 
 ### PRSICE2


 
 
 ```
singularity exec --no-home -B  $(pwd):/INPUT /home/bayram/GRSworkflow/imagename.sif Rscript PRSice.R --dir . \
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
singularity exec --no-home imagename2  Rscript  imagename2/PRSice.R --dir . \
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


 
 
 ### fastGWA
 
 with test data inside the container:

 ```
  singularity exec --no-home   imagename2     gcta64 --bfile  imagename2/1kg_EU_qc  --make-grm-part 100 1 --thread-num 5 --out  your_data_output
 ```
 
  with with your own data 
  
```
singularity exec --no-home  --bind   your/local/path:/INPUT path/of/the/container/imagename.sif  gcta64 --bfile /INPUT/your_data  --make-grm-part 100 1 --thread-num 5 --out /INPUT/your_data_output
```



  ### BoltLMM
  
   with test data inside the container:
   
   ```
  singularity exec --no-home   imagename2     bolt \
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
     singularity exec --no-home  --bind   your/local/path:/fld path/of/the/container/imagename.sif    bolt \
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

 ### METAL
 
 



 ### KING
 
  with test data inside the container:

 ```
  singularity exec --no-home   imagename2    king -b  imagename2/TOY_TARGET_DATA.bed  --related  
```
  with with your own data 

 ```
singularity exec --no-home  --bind   your/local/path:/INPUT path/of/the/container/imagename.sif  king -b  /INPUT/your_data.bed  --related  
 ```

 ### flashPCA
 
  with test data inside the container:
  
   ```
  singularity exec --no-home   imagename2 flashpca --bfile   imagename2/TOY_TARGET_DATA
  ```  
 
 with your own data 
 
   ``` 
  singularity exec --no-home  --bind   your/local/path:/INPUT path/of/the/container/imagename.sif  flashpca --bfile   /INPUT/your_data
   ```  
   
   

  Data Formatting
  
   #### qctool # these is an issue on permission
   Conversion between .vcf and .bgen
   
     with test data inside the container:
   
   ``` 
   singularity exec --no-home   imagename2  qctool -g  imagename2/1kg_EU_qc_vcf.vcf -og  example.bgen  
   ```  
  
  
  
  with your own data
  
   ``` 
  singularity exec --no-home  --bind   your/local/path:/INPUT path/of/the/container/imagename.sif  qctool -g INPUT/test_vcf.vcf  -og  INPUT/example.bgen"   
   ``` 
    
    ### vcftool
    
  with test data inside the container:  (vcf to bcf)
   
   ``` 
  singularity exec --no-home   imagename2 vcftools --vcf  imagename2/1kg_EU_qc_vcf.vcf   --recode-bcf --recode-INFO-all --out converted_output   
   ```  
     
 with your own data:
    
   ``` 
  singularity exec --no-home  --bind    your/local/path:/INPUT T path/of/the/container/imagename.sif  vcftools --vcf /INPUT/test_vcf.vcf --recode-bcf --recode-INFO-all --out /INPUT/converted_output  
    ``` 
  

 
  
 
