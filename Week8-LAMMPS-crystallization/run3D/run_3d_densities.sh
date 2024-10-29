#!/bin/bash

# Create directories for logs, trajectories, and images if they don't exist
mkdir -p Trajectories Data images

# Loop over densities from 0.8 to 1.5 in steps of 0.1
for density in $(seq 0.8 0.1 1.5)
do
    echo "Running simulation at density $density"
    # Run the LAMMPS simulation and save the output to a log file
    mpirun lmp -var density $density -in ../Inputs/3dWCA.in -log Data/log_density_${density}.log

    # Move output files to Trajectories/ or Data/
    mv dump.3dWCA.lammpstrj Trajectories/dump_3dWCA_d${density}.lammpstrj
    mv log.3dWCA Data/log_3dWCA_d${density}.log
done
