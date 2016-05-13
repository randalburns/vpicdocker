#!/bin/bash
docker run -i --net=host -v /vmshare:/mnt/vpicrun vpic /home/vpic/launch_sshd.sh &
