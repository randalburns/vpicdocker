#!/bin/bash

## make the run directory belong to vpic
cp -r /home/vpic/* /mnt/vpicrun
mkdir -p /mnt/vpicrun/vpic.bin
mkdir -p /mnt/vpicrun/vpicrun1
mkdir -p /mnt/vpicrun/vpicrun2
chown -R vpic:vpic /mnt/vpicrun/*
#
# run the vpic code  on master
su vpic -c /home/vpic/dockerrunvpic.sh 

