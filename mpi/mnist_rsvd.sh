#!/bin/bash
#PBS -N mnist_rsvd
#PBS -l select=1:mpiprocs=64,walltime=00:10:00
#PBS -q qexp
#PBS -e mnist_rsvd.e
#PBS -o mnist_rsvd.o

cd ~/KPMS-IT4I-EX/mpi
pwd

module load R
echo "loaded R"

## Fix for warnings from libfabric/1.12 bug
module swap libfabric/1.12.1-GCCcore-10.3.0 libfabric/1.13.2-GCCcore-11.2.0 


echo -e "\n>>>>>>>> 2 R sessions" >&2
time mpirun --map-by ppr:2:node Rscript mnist_rsvd.R
echo -e "\n>>>>>>>> 4 R sessions" >&2
time mpirun --map-by ppr:4:node Rscript mnist_rsvd.R
echo -e "\n>>>>>>>> 8 R sessions" >&2
time mpirun --map-by ppr:8:node Rscript mnist_rsvd.R
echo -e "\n>>>>>>>> 16 R sessions" >&2
time mpirun --map-by ppr:16:node Rscript mnist_rsvd.R
