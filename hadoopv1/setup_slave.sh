#!/bin/bash

source ../globals

if [ $# -ne 1 ] ; then
 echo " Usage: setup_slave.sh ip"
 exit 1
fi

ip=$1

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "apt-get install -y openjdk-7-jdk"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME env.sh $ip:

scp -o StrictHostKeyChecking=no -i ../$KEYNAME  core-site.xml $ip:
scp -o StrictHostKeyChecking=no -i ../$KEYNAME  hdfs-site.xml $ip:
scp -o StrictHostKeyChecking=no -i ../$KEYNAME  mapred-site.xml $ip:

scp -o StrictHostKeyChecking=no -i ../$KEYNAME install_hadoop.sh $ip:

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "./install_hadoop.sh"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME start_slave.sh $ip:

