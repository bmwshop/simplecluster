#!/bin/bash

source ../globals

if [ $# -ne 1 ] ; then
 echo " Usage: setup_slave.sh ip"
 exit 1
fi

ip=$1

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME root@$ip "apt-get install -y openjdk-7-jdk"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME env.sh root@$ip:
scp -o StrictHostKeyChecking=no -i ../$KEYNAME install_hadoop.sh root@$ip:
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME root@$ip "./install_hadoop.sh"

# scp -o StrictHostKeyChecking=no -i ../$KEYNAME start_slave.sh $ip:

