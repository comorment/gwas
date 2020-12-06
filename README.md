This repository is used to develop and describe singularity containers with various software and analytical tools for GWAS and post-GWAS analysis.

For new users we recommend to go over introductory instructions in [docs/hello.md](docs/hello.md).

If you would like to contribute to developing these containers, see  [docs/contributing.md](docs/contributing.md).

For a tutorial on GWAS with synthetic data, see [docs/gwas.md](docs/gwas.md)

The containers are currently organized as follows:

* hello - a hello-world introductory container
* gwas - basic tools for gwas
* conda - python and R packages distributed via miniconda. This package also contains LD score regression.
* matlab - container allowing to run pre-compiled MATLAB software. This container also has OCTAVE installed.
* R - contaienr for R analysis (installed by native R package manager)

All containers are shared on [Google Drive](https://drive.google.com/drive/folders/1mfxZJ-7A-4lDlCkarUCxEf2hBIxQGO69?usp=sharing).

The instructions also assume that
* you download a ``comorment_ref.tar.gz`` file from the Google drive folder,
* extract it (using ``tar -xzvf comorment_ref.tar.gz``) command,
* create an environmental variable ``COMORMENT_REF`` pointing to the folder containing extracted ``comorment_ref.tar.gz`` data.
