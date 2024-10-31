#!/bin/bash

# Define range of densities
for density in $(seq 0.5 0.1 1.1); do
    echo "Running simulation for density $density"

    # Set output file names based on density
    logfile="Logs/2dWCA_density_${density}.log"
    trajfile="Trajectories/2dWCA_T0.1_d${density}_N100000.dcd"
    lammpsfile="Data/2dWCA_T0.1_d${density}_N100000.lammpstrj"

    # Run the simulation and save output logs
    mpirun lmp -var density $density -in ../Inputs/2dWCA.in -log $logfile

    # Move output files to organized directories
    mv 2dWCA_T0.1_d${density}_N100000.dcd $trajfile
    mv 2dWCA_T0.1_d${density}_N100000.lammpstrj $lammpsfile

    echo "Density $density completed. Log, trajectory, and LAMMPS file saved."
done
