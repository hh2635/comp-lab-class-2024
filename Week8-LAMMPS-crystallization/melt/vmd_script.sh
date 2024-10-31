#!/bin/bash

# Load VMD module (adjust if necessary for your environment)
module load vmd/1.9.3

# Run VMD with the specified script to automate visualization and save the movie
vmd -dispdev text -eofexit <<EOF
# Load the LAMMPS trajectory file
mol new dump.melt type lammpstrj

# Set orthographic display type
display projection Orthographic

# Set representation to VDW (Van der Waals)
mol modstyle 0 0 VDW

# Set particle size to 0.5
mol modscale 0 0 0.5

# Render movie as a series of images (adjust output path as needed)
render snapshot /path/to/figures/frames/frame

# Combine images into a movie if desired (this may require additional tools)
EOF

echo "Visualization and movie generation script executed."
