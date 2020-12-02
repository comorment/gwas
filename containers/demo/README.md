# Singularity containers for GWAS and post-GWAS analysis (DEMO).

This repository described a Hello World Singularity container, which you may use to familiraze yourself with Singularity (https://sylabs.io/docs/) and the way it works on your secure HPC environment (TSD, Bianca, Computerome, or similar).
This singularity container is indented as a demo. 
It only contains Plink 1.9 (http://zzz.bwh.harvard.edu/plink/) software.
We are currently working on expanding the container to include a lot of additional software used for GWAS and post-GWAS analysis,
and will shortly make this available here: https://github.com/comorment/gwas .

## Getting Started

* Download ``hello.sif`` and ``hello_demo.tar.gz`` files from [here](https://drive.google.com/drive/folders/1mfxZJ-7A-4lDlCkarUCxEf2hBIxQGO69?usp=sharing)
* Import both files to your secure HPC environment (i.e. TSD, Bianca, Computerome, or similar).
* Run ``tar -xzvf hello_demo.tar.gz`` to extract demo data.
* Run ``singularity exec --no-home hello.sif plink --help``, to validate that you can run singularity. This command is expected to produce the standard plink help message, starting like this:
  ```
  PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
  (C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
  ```
* Run ``singularity exec --no-home -B $(pwd):/data hello.sif plink --bfile /data/chr21 --freq --out /data/chr21`` command, which will mount current folder (the ``$(pwd)``) as ``/data`` inside the container. It will then use plink to calculate allele frequencies, and save the result in current folder.
* Run ``singularity shell --no-home -B $(pwd):/data hello.sif`` to use singularity in an interactive mode. In this mode you can interactively run plink commands. Note that it will consume resources of the machine where  you currently run the singulairty  comand (i.e., most likely, the login node of your HPC cluster).
* Run singularity container within SLURM job scheduler, by creating a ``hello_slurm.sh`` file (by adjusting the example below), and running ``sbatch hello_slurm.sh``:
  ```
  #!/bin/bash
  #SBATCH --job-name=hello
  #SBATCH --account=p697
  #SBATCH --time=00:10:00
  #SBATCH --cpus-per-task=1
  #SBATCH --mem-per-cpu=8000M
  module load singularity/2.6.1
  singularity exec --no-home hello.sif plink --help
  singularity exec --no-home -B $(pwd):/data hello.sif plink --bfile /data/chr21 --freq --out /data/chr21
  ```

Please [let us know](https://github.com/comorment/demo/issues/new) if you face any problems.
