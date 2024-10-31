#!/bin/bash

# Load VMD module if required
module load vmd/1.9.3

# Define range of densities and image output path
output_path="Images"

# Make sure the output directory exists
mkdir -p $output_path

# Loop over densities
for density in $(seq 0.5 0.1 1.1); do
    echo "Visualizing density $density"

    # Set file paths based on density
    lammpstrj_file="Data/2dWCA_T0.1_d${density}_N100000.lammpstrj"
    dcd_file="Trajectories/2dWCA_T0.1_d${density}_N100000.dcd"
    image_file="$output_path/2dWCA_density_${density}.tga"

    # Run VMD in text mode with inline commands to set up visualization and render an image
    vmd -dispdev text -eofexit <<EOF
# Load the LAMMPS trajectory file and DCD file
mol new $lammpstrj_file type lammpstrj
mol addfile $dcd_file type dcd

# Set the representation to VDW (Van der Waals) and adjust particle size to 0.5
mol modstyle 0 0 VDW 0.5 12.0
mol modcolor 0 0 ColorID 6

# Go to the final frame
set num_frames [molinfo top get numframes]
animate goto [expr \$num_frames - 1]

# Save a snapshot of the final frame using TachyonInternal renderer
render TachyonInternal $image_file
EOF

    echo "Visualization for density $density saved as $image_file."
done
