#!/bin/bash

# if you are the master node run the code
if [ $HOSTNAME == 'master' ]; then

echo"Sleeping 10"

sleep 10

echo "Starting vpic on master"

#make the vpic directory writeable
mkdir /mnt/vpic/vpicrun
chown -R vpic:vpic /mnt/vpic/vpicrun

# run the code as vpic user
su vpic -c /home/vpic/runvpic.sh 

# All slave nodes launch the ssh server
else

echo "Starting sshd"
mkdir /var/run/sshd
/usr/sbin/sshd -D

fi
