#!/bin/bash
docker run -i --net=host -v /vmshare:/mnt/h3d h3d /home/vpic/launch_sshd.sh &
