#!/bin/bash

# if you are the master node run the code
if [ $HOSTNAME == 'master' ]; then

echo "Preparing shell on master"

# All slave nodes launch the ssh server
else

echo "Starting sshd"
mkdir /var/run/sshd
/usr/sbin/sshd -D

fi
