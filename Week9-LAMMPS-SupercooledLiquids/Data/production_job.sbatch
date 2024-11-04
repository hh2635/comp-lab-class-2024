#!/bin/bash
#SBATCH --job-name=production_run
#SBATCH --output=production_output.log
#SBATCH --error=production_error.log
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --time=02:00:00  # Adjusted time to be three times shorter than equilibration runs

# Load LAMMPS environment
source /scratch/work/courses/CHEM-GA-2671-2024fa/software/lammps-gcc-30Oct2022/setup_lammps.bash

# Step 1: Define the temperatures for production runs (same as equilibration)
temperatures=(1.5 1.0 0.9 0.8 0.7 0.65 0.6 0.55 0.5 0.475)  # Adjust range as needed

# Step 2: Run production simulations at each temperature
echo "Starting production simulations..."
for temp in "${temperatures[@]}"; do
    echo "Running production at temperatiure $temp..."
    mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T${temp}.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
done

echo "Production simulations completed."
