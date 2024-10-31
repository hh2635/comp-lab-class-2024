#!/bin/bash

# Load VMD module (adjust if necessary for your environment)
module load vmd/1.9.3

# Run VMD with the specified script to automate visualization and save the movie
vmd -dispdev text -eofexit <<EOF
# Load the LAMMPS trajectory file and DCD file
mol new 2dWCA_T0.1_d0.5_N100000.lammpstrj type lammpstrj
mol addfile 2dWCA_T0.1_d0.5_N100000.dcd type dcd

# Set the representation to VDW (Van der Waals) and adjust particle size to 0.5
mol modstyle 0 0 VDW 0.5 12.0
mol modcolor 0 0 ColorID 6

# Save a snapshot of the final frame as a PNG
set num_frames [molinfo top get numframes]
animate goto [expr \$num_frames - 1]
render TachyonInternal 2dWCA_final_frame.tga
EOF

echo "Visualization and snapshot script executed."
