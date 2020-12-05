This repository is used to develop and describe singularity containers with various software and analytical tools for GWAS and post-GWAS analysis.

For new users we recommend to go over introductory instructions in [docs/hello.md](docs/hello.md).

If you would like to contribute to developing these containers, see instructions in [docs/contributing.md](docs/contributing.md).

The containers are currently organized as follows:

* hello - a hello-world introductory container
* gwas - basic tools for gwas
* conda - python and R packages distributed via miniconda. This package also contains LD score regression.
* matlab - container allowing to run pre-compiled MATLAB software. This container also has OCTAVE installed.
* R - contaienr for R analysis (installed by native R package manager)

