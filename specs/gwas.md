Specification for input data format for GWAS analysis:

1. Genotypes
 
We expect imputed genotype data, which can be split into multiple cohorts at each site.
For example, MoBa imputed genotype data is currently split into three cohorts, one per genotype array: GSA, OMNI and HCE.
We expect the data to be in plink format (.bed/.bim.fam), split per chromosomes, with files named as follows:

```
<ROOT>/<COHORT>/chr@.[bed,bim,fam]
```

At this stage we only work with hard-call data, not dosage data. Support for dosage data  will came at later stage.
   
2. Phenotypes and covariates

For phenotypes and covariates, we expect the data to be organized in a single tab-separated file (refered to as *phenotype file*), 
with rows corresponding to individuals, and columns corresponding to relevant variables of interest or covariates.
We expect a single phenotype file, not split by cohorts as genotype files.
The phenotype file must include subject ID column, which matches the ID in genetic data (the ``IID`` column in plink files).
The file must contain all covariates needed for GWAS analysis, including principal genetic components.
Column names in the phenotype file must be unique.

Phenotype file should be accompanied by a *data dictionary* file, which define whether each variable is a binary (case/control), nominal (a discrete set of values) or continuous.
The data dictionary should be a file with two columns, one row per variable (listed in the first column), with secon column having values *BINARY*, *NOMINAL*, *CONTINUOUS* or *ID*.     

