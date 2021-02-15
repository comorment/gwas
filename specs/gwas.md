This is a specification of the input data format for GWAS anslysis, recommended in CoMorMent projects.
Current description is work in progress. Please let us know, any feedback is very welcome!

### Genotypes
 
We expect imputed genotype data, potentially split into multiple cohorts at each site.
For example, MoBa imputed genotype data is currently split into three cohorts, one per genotype array: GSA, OMNI and HCE.
We expect the data to be in plink format (.bed/.bim.fam), split per chromosomes, organized for example as follows:
```
<BASEPATH>/<COHORT>/chr@.[bed,bim,fam]   # where @ indicates chr label
```
It is recommended (but not required) that all genetic data within cohort is placed into it's own folder.
A strict requirement is that within each cohort the files are only different by chromosome label, so it is possible
to specify them by a single prefix with ``@`` symbol indicating the location of a chromosome label.

At this stage we only work with hard-call data, not dosage data. Support for dosage data  will came at later stage.
   
### Phenotypes and covariates

For phenotypes and covariates, we expect the data to be organized in a single comma-separated file (hereinafter referred to as *phenotype file*), 
with rows corresponding to individuals, and columns corresponding to relevant variables of interest or covariates.
We expect a single phenotype file (at each site), not split by the genotype cohorts.
The phenotype file must include a subject ID column, containing identifiers that matches the ID in genetic data (i.e. the ``IID`` column in plink files).
The file must contain all covariates needed for GWAS analysis, including principal genetic components.
Column names in the phenotype file must be unique.

Phenotype file should be accompanied by a *data dictionary* file, 
which define whether each variable is a binary (case/control), nominal (a discrete set of values) or continuous.
The data dictionary should be a file with two columns, one row per variable (listed in the first column), with secon column having values *BINARY*, *NOMINAL*, *CONTINUOUS* or *ID*.     

Example ``MoBa.pheno`` file:
```
ID,MDD,PC1,PC2,PC3
1,0,0.1,0.2,0.3
2,1,0.4,0.5,0.6
3,0,0.6,0.7,0.8
```

Example ``MoBa.dict`` file:
```
ID,ID
MDD,BINARY
PC1,CONTINUOUS
PC2,CONTINUOUS
PC3,CONTINUOUS
```
