#!/bin/bash

echo "Starting sshd"
mkdir /var/run/sshd
/usr/sbin/sshd -D

