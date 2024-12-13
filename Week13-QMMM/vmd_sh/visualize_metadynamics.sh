#!/bin/bash

# Ensure required modules are loaded
module load vmd/1.9.3

# Input and output files
TOPOLOGY_FILE="../Outputs/metad1_initmonitor/complex_LJ_mod.prmtop"
TRAJECTORY_FILE="../Outputs/metad1_initmonitor/METADYN-combined.xyz.gz"
OUTPUT_DIR="../Figures"
BEFORE_IMAGE="$OUTPUT_DIR/before_reaction.png"
AFTER_IMAGE="$OUTPUT_DIR/after_reaction.png"
MOVIE="$OUTPUT_DIR/reaction_movie.mpg"

# Ensure the output directory exists
mkdir -p $OUTPUT_DIR

# Check if the trajectory file exists
if [ ! -f "$TRAJECTORY_FILE" ]; then
  echo "Error: Trajectory file $TRAJECTORY_FILE not found!"
  exit 1
fi

# Create the VMD script dynamically
VMD_SCRIPT="metadynamics_visualization.vmd"
cat > $VMD_SCRIPT << EOF
# Load trajectory
mol new $TOPOLOGY_FILE type parm7
mol addfile $TRAJECTORY_FILE type xyz waitfor all

# Representation for protein
mol representation NewCartoon
mol selection protein
mol addrep top

# Representation for ligand (Dynamic Bonds)
mol representation DynamicBonds
mol selection {not protein and within 5 of protein}
mol addrep top

# "Before" Reaction Frame
animate goto 0
render TachyonInternal -format png $BEFORE_IMAGE

# "After" Reaction Frame
animate goto end
render TachyonInternal -format png $AFTER_IMAGE

# Create a movie of the entire trajectory
render movie tachyon $MOVIE
EOF

# Run VMD in text mode with the generated script
vmd -dispdev text -e $VMD_SCRIPT

# Confirm output
if [ -f "$BEFORE_IMAGE" ] && [ -f "$AFTER_IMAGE" ] && [ -f "$MOVIE" ]; then
  echo "Visualization completed successfully."
  echo "Before image: $BEFORE_IMAGE"
  echo "After image: $AFTER_IMAGE"
  echo "Movie: $MOVIE"
else
  echo "Visualization failed. Check the logs for details."
fi
