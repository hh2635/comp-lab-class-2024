#!/bin/bash

#SBATCH --job-name=cp2k_simulation
#SBATCH --output=cp2k_output_%j.log
#SBATCH --error=cp2k_error_%j.log
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=06:00:00

# Load the CP2K module
module load cp2k/openmpi/intel/20201212

# Run CP2K
mpirun -np 12 cp2k.popt -i water.inp -o water_md_sim.log
