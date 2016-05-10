#!/bin/bash

# if you are the master node run the code
if [ $HOSTNAME == 'master' ]; then

echo "Sleeping 5 on master"

sleep 5

echo "Starting vpic on master"

# make the run directory belong to vpic
cp -r /home/vpic/* /mnt/vpicrun
mkdir -p /mnt/vpicrun/vpic.bin
chown -R vpic:vpic /mnt/vpicrun/*

# run the vpic code  on master
su vpic -c /mnt/vpicrun/runvpic.sh 

# All slave nodes launch the ssh server
else

echo "Starting sshd"
mkdir /var/run/sshd
/usr/sbin/sshd -D

fi
