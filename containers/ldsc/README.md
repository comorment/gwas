# Running LD SCore on Singularity container

A tutorial on how to run LD SCore (https://github.com/bulik/ldsc) on Singularity container. 
## Getting Started

* Download ``ldsc.sif``  (placed in ldsc_v1.1) and  ``hello_demo.tar.gz`` files from [here](https://drive.google.com/drive/folders/1mfxZJ-7A-4lDlCkarUCxEf2hBIxQGO69?usp=sharing)
* Import both files to your secure HPC environment (i.e. TSD, Bianca, Computerome, or similar).
* Run ``tar -xzvf hello_demo.tar.gz`` to extract demo data.
* Import both files to your secure HPC environment (i.e. TSD, Bianca, Computerome, or similar).

* Run ``singularity exec --no-home   ldsc.sif /ldsc/ldsc.py -h``, to validate that you can run singularity. This command is expected to produce the standard plink help message, starting like this:
 ```
usage: ldsc.py [-h] [--out OUT] [--bfile BFILE] [--l2] [--extract EXTRACT]
               [--keep KEEP] [--ld-wind-snps LD_WIND_SNPS]
               [--ld-wind-kb LD_WIND_KB] [--ld-wind-cm LD_WIND_CM]
.
.
.
 ```
* Run ``singularity exec --no-home -B $(pwd):/data   ldsc.sif /ldsc/ldsc.py --bfile /data/chr21 --l2 --ld-wind-cm 1  --out /data/OUT `` command, which will mount current folder (the ``$(pwd)``) as ``/data`` inside the container. It will then use plink to calculate allele frequencies, and save the result in current folder.
* Run ``singularity shell --no-home -B $(pwd):/data ldsc.sif`` to use singularity in an interactive mode. In this mode you can interactively run plink commands. Note that it will consume resources of the machine where  you currently run the singulairty  comand (i.e., most likely, the login node of your HPC cluster).
* Run singularity container within SLURM job scheduler, by creating a ``ldsc_slurm.sh`` file (by adjusting the example below), and running ``sbatch ldsc_slurm.sh``:
  ```
  #!/bin/bash
  #SBATCH --job-name=ldsc
  #SBATCH --account=p697
  #SBATCH --time=00:10:00
  #SBATCH --cpus-per-task=1
  #SBATCH --mem-per-cpu=8000M
  module load singularity/2.6.1
  singularity exec --no-home   ldsc.sif /ldsc/ldsc.py -h
  singularity exec --no-home -B $(pwd):/data   ldsc.sif /ldsc/ldsc.py --bfile /data/chr21 --l2 --ld-wind-cm 1  --out /data/OUT
  ```

Please [let us know](https://github.com/comorment/demo/issues/new) if you face any problems.
