# Hello container
Singularity containers for GWAS and post-GWAS analysis (DEMO).

This repository described a Hello World Singularity container, which you may use to familiraze yourself with Singularity (https://sylabs.io/docs/) and the way it works on your secure HPC environment (TSD, Bianca, Computerome, or similar).
This singularity container is indented as a demo. 
It only contains Plink 1.9 (http://zzz.bwh.harvard.edu/plink/) software.
We are currently working on expanding the container to include a lot of additional software used for GWAS and post-GWAS analysis,
and will shortly make this available here: https://github.com/comorment/gwas .

## Getting Started

* Download ``hello.sif`` and ``hello_demo.tar.gz`` files from [here](https://drive.google.com/drive/folders/1mfxZJ-7A-4lDlCkarUCxEf2hBIxQGO69?usp=sharing)
* Import both files to your secure HPC environment (i.e. TSD, Bianca, Computerome, or similar).
* Run ``mkdir data && tar -xzvf hello_demo.tar.gz -C data`` to extract demo data into a new folder called ``data``.
* Run ``singularity exec --no-home hello.sif plink --help``, to validate that you can run singularity. This command is expected to produce the standard plink help message, starting like this:
  ```
  PLINK v1.90b6.18 64-bit (16 Jun 2020)          www.cog-genomics.org/plink/1.9/
  (C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
  ```
* Run ``singularity exec --no-home -B $(pwd)/data:/data hello.sif plink --bfile /data/chr21 --freq --out /data/chr21`` command, which will mount current folder (the ``$(pwd)``) as ``/data`` inside the container. It will then use plink to calculate allele frequencies, and save the result in current folder.
* Run ``singularity shell --no-home -B $(pwd)/data:/data hello.sif`` to use singularity in an interactive mode. In this mode you can interactively run plink commands. Note that it will consume resources of the machine where  you currently run the singulairty  comand (i.e., most likely, the login node of your HPC cluster).
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
  singularity exec --no-home -B $(pwd)/data:/data hello.sif plink --bfile /data/chr21 --freq --out /data/chr21
  ```

Please [let us know](https://github.com/comorment/gwas/issues/new) if you face any problems.

## TSD-specific instructions

The official documentation fro singularity on TSD  is available [here](https://www.uio.no/english/services/it/research/sensitive-data/use-tsd/hpc/software/singularity.html). Here are more important notes about singularity on TSD:
* ``module load singularity/2.6.1`` is going to be deprecated soon; instead, there will be a local installation of singularity on each Colossus node
* Singularity might be unavailable on some of the interactive nodes. For example, in ``p33`` project it is recommended to run singularity on ``p33-appn-norment01`` node. You may also find it in ``p33-submit`` nodes. 
* You may want to run ``module purge``, to make sure you use locally installed singularity. It is good idea to run ``which singularity`` to validate this.
* Use ``singularity --version`` to find the version of singularity
* Generally, it is a good idea to add ``--no-home`` argument to your singularity commands, to make sure that that scripts such as ``.bashrc`` do not interfere with singularity container. This also applies if you have custom software installed in your home folder. For other options that control isolation of the containers (i.e. ``--containall`` option) see [here](https://sylabs.io/guides/3.1/user-guide/bind_paths_and_mounts.html#using-no-home-and-containall-flags). 
* If you are a developer, and you would like to generate a singularity container, you may want to do it outside of TSD, and then bring just a ``.sif`` file to TSD. Also, building singularity containers is much easier by building a Docker container first (using ``Dockerfile``), and converting such Docker container to a singularity container.
