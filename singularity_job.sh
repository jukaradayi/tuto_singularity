#!/bin/bash
# run simulation
# warning: meant to be run in singularity container

echo "hello from inside the container"
mpirun -np $NJOBS <executable> 
