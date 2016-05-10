#!/bin/bash
docker run -i --net=host -v /home/vpic/vpicrun:/mnt/vpicrun vpic /home/vpic/launch_sshd.sh &
