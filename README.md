## Singularity containers for GWAS and post-GWAS analysis
This repository is used to develop and document singularity containers with various software and analytical tools for GWAS and post-GWAS analysis.

## Getting started
For new users we recommend to go over introductory instructions in [docs/hello.md](docs/hello.md), which explain the basic usage of singularity containers, using a minimalistic example (singularity container with ``plink`` binary).

If you would like to contribute to developing these containers, please see  [docs/contributing.md](docs/contributing.md).

For a tutorial on GWAS with synthetic data, see [docs/gwas.md](docs/gwas.md).

## Prerequisites (to running tutorials):
* download containers shared on the [Google Drive](https://drive.google.com/drive/folders/1mfxZJ-7A-4lDlCkarUCxEf2hBIxQGO69?usp=sharing).
* download ``comorment_ref.tar.gz`` file from the above Google Drive folder, extract it with ``tar -xzvf comorment_ref.tar.gz`` command,
  and create an environmental variable ``COMORMENT_REF`` pointing to the folder containing extracted ``comorment_ref.tar.gz`` data.
  If you want to see the content of ``comorment_ref.tar.gz`` without downloading and extracting, 
  you may take a quick look [here](https://github.com/norment/comorment_data). This is a private repository, and you need to get access.
  Please contact Oleksandr and Bayram by e-mail and send us your github user name. If you don't have it, create one [here](http://github.com/join).
* create an empty folder called ``data``, for storing the results and intermediate files produced by running containers.
  (most instructinos mount this folder like this: ``-B data:/data``).

## Description of available containers:
* ``hello`` - a hello-world introductory container
* ``gwas`` - basic tools for gwas (``plink``, ``plink2``, ``prsice``, ``BoltLMM``)
* ``python3`` - python3 packages distributed via miniconda. This package also contains jupyter notebook.
* ``ldsc`` - LD score regression
* ``matlab`` - container allowing to run pre-compiled MATLAB software. This container also has OCTAVE installed.
* ``R`` - contaienr for R analysis (installed by native R package manager)

All containers have a shared layer of common utilities (``wget``, ``gzip``, etc). 

## Feedback

If you face any issues, or if you need additional software, please let us know by creating an [issue](https://github.com/comorment/gwas/issues/new). 
