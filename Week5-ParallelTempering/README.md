1. Created directories for each temperature:
   mkdir T300 T400 T600

2. Edited .mdp files to set the temperatures to 300K, 363K, and 440K:
   vi T400/adp.mdp  --> ref_t = 363
   vi T600/adp.mdp  --> ref_t = 440

3. Generated .tpr files:
   gmx_mpi grompp -f T300/adp.mdp -c adp.gro -p adp.top -o T300/adp.tpr
   gmx_mpi grompp -f T400/adp.mdp -c adp.gro -p adp.top -o T400/adp.tpr
   gmx_mpi grompp -f T600/adp.mdp -c adp.gro -p adp.top -o T600/adp.tpr

4. Requested an interactive node with 3 tasks and ran the simulation:
   srun --ntasks=3 --cpus-per-task=1 --time=01:00:00 --pty bash
   mpirun -np 3 gmx_mpi mdrun -s adp -multidir T300/ T400/ T600/ -deffnm adp_exchange3temps -replex 500

5. Analyzed log files for exchange probability and calculated potential energy histograms.

6. Generated free energy surfaces and tracked replica temperature movement using demux.pl.

The MDanalysis.ipynb visualize the datas, as required in the assignment.

All the figures are saved in the Figures folder. 
