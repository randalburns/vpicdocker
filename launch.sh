#!/bin/bash

# if you are the master node run the code
if [ $HOSTNAME == 'master' ]; then

echo "Starting vpic on master"

# Move build files to nfs shared mount
#cp -r /home/vpic/* /mnt/vpic
#chown -R vpic:vpic /mnt/vpic/* 

# run the code as vpic user
su vpic -c /home/vpic/runvpic.sh 

# All slave nodes launch the ssh server
else

echo "Starting sshd"
mkdir /var/run/sshd
/usr/sbin/sshd -D

fi
