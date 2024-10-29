#!/bin/bash

# Directory to store log files and output
mkdir -p Trajectories
mkdir -p Data

# Loop over densities from 0.5 to 1.1 in steps of 0.1
for density in $(seq 0.5 0.1 1.1)
do
    echo "Running simulation at density $density"
    # Run the LAMMPS simulation and save the output to a log file
    mpirun lmp -var density $density -in ../Inputs/2dWCA.in -log Trajectories/log_density_${density}.log

    # Move output files to Trajectories/ or Data/
    mv 2dWCA_T0.1_d${density}_N100000.dcd Trajectories/
    mv 2dWCA_T0.1_d${density}_N100000.lammpstrj Data/
done
