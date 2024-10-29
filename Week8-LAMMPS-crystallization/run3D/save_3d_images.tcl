i# Load the trajectory and configuration files
set density [lindex $argv 0]
set traj_file "3dWCA_T0.1_d${density}_N100000.dcd"
set init_file "3dWCA_T0.1_d${density}_N100000.lammpstrj"

# Load the files into VMD
mol new $init_file type lammpstrj
mol addfile $traj_file type dcd

# Go to the final frame
set num_frames [molinfo top get numframes]
animate goto [expr $num_frames - 1]

# Set up visualization (Perspective view, Points representation, and Particle size 0.5)
display projection perspective
mol modstyle 0 0 Points 3.0
mol modcolor 0 0 ColorID 6

# Save the image
set image_name "density_${density}.png"
render snapshot $image_name

# Quit VMD
quit
