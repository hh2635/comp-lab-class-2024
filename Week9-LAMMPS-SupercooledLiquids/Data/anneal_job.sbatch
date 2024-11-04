#!/bin/bash
#SBATCH --job-name=system_anneal
#SBATCH --output=anneal_output.log
#SBATCH --error=anneal_error.log
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --time=04:00:00
#SBATCH --mem=8GB

# Load LAMMPS environment
source /scratch/work/courses/CHEM-GA-2671-2024fa/software/lammps-gcc-30Oct2022/setup_lammps.bash

# Step 1: Create the system
echo "Creating the system..."
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_create.lmp -var id 1 -in ../Inputs/create_3d_binary.lmp

# Step 2: Define the temperatures for annealing
temperatures=(1.5 1.0 0.9 0.8 0.7 0.65 0.6 0.55 0.5 0.475)  # Add 0.45 if needed

# Step 3: Anneal the system through the temperature sequence
echo "Starting annealing process..."
for temp in "${temperatures[@]}"; do
    echo "Equilibrating at temperature $temp..."
    mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T${temp}.lmp -var id 1 -in ../Inputs/anneal_3d_binary.lmp
done

echo "Annealing process completed."
