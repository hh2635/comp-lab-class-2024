#!/bin/bash

# Job settings for the HPC scheduler
#SBATCH --job-name=vmd_render
#SBATCH --output=viz_output.log
#SBATCH --error=viz_error.log
#SBATCH --time=00:10:00
#SBATCH --partition=short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G

# Load the VMD module (adjust to your HPC's module system)
module load vmd/1.9.3

# Define input and output paths
TOPOLOGY_FILE="Inputs/complex.prmtop"
COORD_FILE="Inputs/complex.inpcrd"
OUTPUT_IMAGE="Figures/ligand_centered.tga"
VMD_SCRIPT="Analysis/viz_topology.vmd"

# Create the VMD script dynamically
cat > $VMD_SCRIPT << EOF
# Load topology and coordinate files
mol new $TOPOLOGY_FILE type parm7
mol addfile $COORD_FILE type inpcrd

# Set representations
# Protein in New Cartoon
mol representation NewCartoon
mol selection protein
mol addrep top

# Ligands in CPK
mol representation CPK
mol selection {not protein and not water and not ions}
mol addrep top

# Center the view on one ligand
set sel [atomselect top "not protein and not water and not ions"]
set sel_center [measure center \$sel]
set view [molinfo top get center_matrix]
set move_matrix [trans offset [vecsub \$sel_center [lindex \$view 0]]]
trans apply \$move_matrix

# Render image using Tachyon
render TachyonInternal $OUTPUT_IMAGE

# Exit VMD
quit
EOF

# Run VMD in text mode with the generated script
vmd -dispdev text -e $VMD_SCRIPT

# Confirm output
if [ -f "$OUTPUT_IMAGE" ]; then
  echo "Figure successfully generated: $OUTPUT_IMAGE"
else
  echo "Figure generation failed."
fi
