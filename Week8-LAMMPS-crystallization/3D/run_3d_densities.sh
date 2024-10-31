#!/bin/bash

# Define density range and create output directories
densities=$(seq 0.8 0.1 1.5)
mkdir -p Logs Trajectories Data Images

# Loop over each density
for density in $densities; do
    echo "Running simulation for density $density"

    # Define output file names based on density
    logfile="Logs/3dWCA_density_${density}.log"
    trajfile="Trajectories/3dWCA_T0.1_d${density}_N100000.dcd"
    lammpsfile="Data/3dWCA_T0.1_d${density}_N100000.lammpstrj"
    image_file="Images/3dWCA_density_${density}.tga"

    # Run LAMMPS simulation and save log file
    mpirun lmp -var density $density -in ../Inputs/3dWCA.in -log $logfile

    # Move output trajectory files to organized directories
    mv 3dWCA_T0.1_d${density}_N100000.dcd $trajfile
    mv 3dWCA_T0.1_d${density}_N100000.lammpstrj $lammpsfile

    # Generate a snapshot of the final frame using VMD
    vmd -dispdev text -eofexit <<EOF
mol new $lammpsfile type lammpstrj
mol addfile $trajfile type dcd
display projection Orthographic
mol modstyle 0 0 VDW 0.5 12.0
mol modcolor 0 0 ColorID 6
set num_frames [molinfo top get numframes]
animate goto [expr \$num_frames - 1]
render TachyonInternal $image_file
quit
EOF

    echo "Density $density completed. Log, trajectory, LAMMPS file, and image saved."
done
