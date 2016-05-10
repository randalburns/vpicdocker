#/bin/bash

cd /mnt/vpicrun/vpic.bin
cmake \
  -DUSE_CATALYST=ON \
  -DCMAKE_BUILD_TYPE=Release \
  /mnt/vpicrun/vpic
make -j16

# prep and run one of the example input decks
mkdir -p /mnt/vpicrun/vpicrun1
cd /mnt/vpicrun/vpic.bin
./bin/vpic ../vpic/sample/harris
cd /mnt/vpicrun/vpicrun1
/mnt/vpicrun/vpic.bin/harris.Linux 1 0

## prep and run another
cd /mnt/vpicrun/vpic.bin
export CPLUS_INCLUDE_PATH=/mnt/vpicrun/vpic/src/util/catalyst/
./bin/vpic ../vpic/sample/8preconnection.cxx
mkdir -p /mnt/vpicrun/vpicrun2
cd /mnt/vpicrun/vpicrun2
export LD_LIBRARY_PATH=/usr/local/paraview.bin/lib
echo "Sleeping 5 to wait for filehandle."
sleep 5
echo "Launching 8preconnection"
LD_LIBRARY_PATH=/usr/local/paraview.bin/lib mpiexec -machinefile /mnt/vpicrun/machinefile /mnt/vpicrun/vpic.bin/8preconnection.Linux
