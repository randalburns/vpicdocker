#/bin/bash

# prep and run one of the example input decks
mkdir /mnt/vpic/vpicrun/vpicrun1
cd /home/vpic/vpic.bin
./bin/vpic ../vpic/sample/harris
cd /mnt/vpic/vpicrun/vpicrun1
/home/vpic/vpic.bin/harris.Linux 1 0

## prep and run another
cd /home/vpic/vpic.bin
export CPLUS_INCLUDE_PATH=/home/vpic/vpic/src/util/catalyst/
./bin/vpic ../vpic/sample/8preconnection.cxx
mkdir /mnt/vpic/vpicrun/vpicrun2
cd /mnt/vpic/vpicrun/vpicrun2
export LD_LIBRARY_PATH=/usr/local/paraview.bin/lib
mpirun -machinefile /home/vpic/machinefile /home/vpic/vpic.bin/8preconnection.Linux
