=====================
SINGULARITY AND SLURM
=====================

This tutorial explains what a singularity container is, when to use it and how.

TL;DR: 

* if you want to launch a simulation on a cluster but don't want (or *can't*) compile your model,
* if you want to use exactly the same environment on multiple computers,
* if you want to manage several models which all require specific environments, and you want to isolate each one, 
* if you need to install specific softwares/libraries that are not available on the cluster 

Singularity can help you !

I When to use singularity
=========================

II How to build and use a singularity container
===============================================

Building your own container is not a prerequisite. If you already have a container, you can skip to II.2.
You can also try to use the container built on spirit1 in "/scratchx/jkaradayi/singu_tuto" 

II.1. building a singularity container
--------------------------------------
Use docker - tuto step 
Warning: can't install stuff on cluster - need root - need to do it **before** sending your image to the cluster

II.2. use a singularity container
---------------------------------

You can try the image in "/scratchx/jkaradayi/singu_tuto" 

* to connect to the singularity image : "$singularity run /scratchx/jkaradayi/singu_tuto" connects you to the image. You are now **in** the container. If you want to use a model, you need to compile it **inside** the container. When using ```singularity run```, it mounts your home folder inside the container, you can access every folder/files in your home from inside the container and use them/interact with them.

* to launch a job using slurm : use the following script as example. Basics : use a slurm script that runs the singularity container and runs your model from inside of it


III A practical course
======================

A small example to show you how to 1) generate a singularity container, 2) use it on spirit1/2, 3) launch a slurm job

III.1 Generating a singularity container
----------------------------------------

For a more detailed tutorial on how to build a recipe, see [sylabs.io](https://docs.sylabs.io/guides/2.6/user-guide/container_recipes.html)

Note that you can also use docker images with singularity, so I you already know how to build a docker image, you can skip this section.


* For this example, we will build a container *recipe* from scratch. This container will contain a small program in fortran, parallelised with OpenMPI. You will need to edit the recipe and replace the *<...>*

* Take the tutorial.recipe as a template. The recipe is made of a **Header** followed by **Sections**. The **Header** tells singularity how to build the base of the image (which OS to use inside the image, where to pull it from ...). Our template will build an image using Ubuntu 20, which it gets from a docker base image.

* First, let's add our fortran code inside the container. The syntax is basically the same as *cp* in linux, but here the source is in the host filesystem, while the destination is in the container filesystem. 
Complete the copy to put the .F90 file in the /home/tuto directory of the container

* Now let's look at the %post section, this is where you will tell singularity the dependency you need. As said before, we want to use our container for a small fortran program, that we want to launch using openmpi. 

* We now have a basic recipe. We can now try to build it and compile the fortran code inside (note that you could also compile the code using the recipe, but this way we'll explore the container)
