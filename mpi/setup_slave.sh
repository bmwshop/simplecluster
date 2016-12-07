#!/bin/bash

source ../globals

if [ $# -ne 1 ] ; then
 echo " Usage: setup_slave.sh ip"
 exit 1
fi

ip=$1

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME root@$ip "apt-get install -y openmpi-bin openmpi-doc libopenmpi-dev nfs-common nfs-kernel-server"
scp -o StrictHostKeyChecking=no -i ../$KEYNAME nfs-minion.sh root@$ip:
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME root@$ip "./nfs-minion.sh"
# ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "while read -r line;do echo $line | cut -d ' ' -f1 >> $SLAVENODE_FILENAME_HOSTS;done < $SLAVENODE_FILENAME"
