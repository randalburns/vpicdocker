#!/bin/bash
docker run -i --net=host -v /home/vpicrun:/mnt/vpicrun vpic /home/vpic/launch_sshd.sh &
