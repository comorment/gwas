# Docker and Singularity containers for GWAS analysis

Docker and Singularity containers to perform Genome-wide association study (GWAS) via Plink 1.9 (http://zzz.bwh.harvard.edu/plink/) .

## Getting Started

In order to run the developed Docker and Singularity containers you need to install Docker (https://docs.docker.com/get-docker/) and Singularity (https://sylabs.io/guides/3.6/user-guide/quick_start.html?highlight=install),  respectively. You can run each container separately.
 

## For Docker Container

0.  Setup Docker by following the procedures in the official website (https://docs.docker.com/get-docker/). Once you finished type "docker" into Terminal to check whether it has been set up correctly.

1. Pull the docker container from Docker Hub

```
docker pull  dockerhub_username/imagename

```

For example 

```
docker pull bayramalex/hello

```




When you type the command above to the terminal, you will pull the corresponding container to your local and then use it accordingly. 


Alternatively, if you have the "Dockerfile" of the container (the receipe of containers), you can cd to the place where the Dockerfile is and build it locally as:

```
docker build -t imagename .

```

For example 

```
docker build -t  hello

```

After the container image has been build, you can check its existence in your local via typing "docker images". Then you can see all available docker images in your local including  "imagename" . 

2. You can run the pulled/built containers in different ways based on the purpose

### Running Modes

 There are different options available for running the container as you can find here (https://docs.docker.com/engine/reference/run/) in detail. We are presenting some basic ones here:
 
#### Passive mode 

```
docker run  dockerhub_username/imagename <yourcommands>

```

Example: 

```
docker run  bayramalex/hello plink --help

```

#### Interactive mode: You can examine the structure of your container via interactive mode

```
docker run  -it  dockerhub_username/imagename

```

For example:

```
docker run  -it   bayramalex/hello

```

Once you run the code, you have entered inside the container (indicated by '#' sign), then you can run any analysis without typing docker commands as:



Example: 

```
plink    --help
	 
	 
```



#### Mounting your working directory:

It is desired to do analysis with your own data. At this point it is required to mount  a path to the container and do analysis on the data in this path. 

```
docker run  -it -v  /your/local/path:/INPUT dockerhub_username/imagename

```




Once you run the code, you have entered inside the container (indicated by '#' sign). You will also observe INPUT folder which is equivalent to   "/your/local/path".  Then you can run any analysis (without typing docker commands). 

It is also possible to mount your directory in  Passive mode as 

```
docker run  -v  /your/local/path:/INPUT dockerhub_username/imagename <your_commands>

```

If you want to use any data from your local path, you need to call it as  INPUT/name_of_your_data. For details, you can have a look for the examples such as [plink](plink.md#section)


## For Singularity Container

0- Install Singularity to your machine (https://sylabs.io/guides/3.6/user-guide/quick_start.html#quick-installation-steps). It is highly recommended to use  it via a Linux machine. There are still some limitations on Mac OS.

1- Build Singularity image from Docker Hub

 ```
singularity build imagename.sif docker://bayramalex/hello:latest

```

Alternatively you can build it as  'sandbox' to use it in passive mode

```
singularity build --sandbox imagename/  docker://bayramalex/hello:latest

```

Here  a container folder called imagename is created in the working directory. You can cd to this folder and work as if you  are working in the interactive mode in Docker.


Another option is building singularity image directly from the Dockerfile  from your local. This can be achieved by building Docker container locally and pushing it to the  local registry and automatically generating .def (https://sylabs.io/guides/3.5/user-guide/definition_files.html) file which is the receipe for building singularity container. To do in this automatically, you can directly run 

 ```
./singularity/build_from_dockerfile.sh
```

Then imagename.sif is created at /singularity (You can change its name as well)

### Running Modes

As in Docker, Singularity has also many options. We will present some basic features but for details you can visit (https://sylabs.io/guides/3.1/user-guide/cli/singularity_exec.html)

#### Passive mode  
 
 singularity exec /path/of/the/container/imagename.sif  <Your command>
 
#### Interactive mode 

Go to the directory where your 'sandbox' image is located and cd it as

 ```
  cd imagename/
```

Then run your commands as you done in docker containers


#### Mounting your working directory:

 Go to the directory where your data is: cd ~/your/local/path


Run the container by mounting this directory

```
singularity exec -B  $(pwd):/INPUT /path/of/the/container/imagename.sif  <your command>

```

alternatively you can determine the path of the data without going to the corresponding directory as


```
singularity exec -B  /your/local/path:/INPUT /path/of/the/container/imagename.sif  <your command>

```

For details, you can have a look for the examples such as [plink](plink.md#section)







