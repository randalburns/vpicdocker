#/bin/bash

# make the run directory belong to vpic
cp -r /home/vpic/* /mnt/vpicrun
chown -R vpic:vpic /mnt/vpicrun/*
su vpic

mkdir /mnt/vpicrun/vpic.bin
cd /mnt/vpicrun/vpic.bin
cmake \
  -DUSE_CATALYST=ON \
  -DCMAKE_BUILD_TYPE=Release \
  /mnt/vpicrun/vpic
make -j16

# prep and run one of the example input decks
mkdir /mnt/vpicrun/vpicrun1
cd /mnt/vpicrun/vpic.bin
./bin/vpic ../vpic/sample/harris
cd /mnt/vpicrun/vpicrun1
/mnt/vpicrun/vpic.bin/harris.Linux 1 0

## prep and run another
cd /mnt/vpicrun/vpic.bin
export CPLUS_INCLUDE_PATH=/mnt/vpicrun/vpic/src/util/catalyst/
./bin/vpic ../vpic/sample/8preconnection.cxx
mkdir /mnt/vpicrun/vpicrun2
cd /home/vpicrun/vpicrun2
export LD_LIBRARY_PATH=/usr/local/paraview.bin/lib
mpirun -np 8 /mnt/vpicrun/vpic.bin/8preconnection.Linux
