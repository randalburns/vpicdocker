#!/bin/bash
echo `hostname`
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
