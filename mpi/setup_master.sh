#!/bin/bash

source ../globals

ip=`cat ../$MASTERNODE_FILENAME | cut -d " " -f1`

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "apt-get install -y openmpi-bin openmpi-doc libopenmpi-dev nfs-common nfs-kernel-server"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME nfs-master.sh $ip:
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "./nfs-master.sh"
# ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "while read -r line;do echo $line | cut -d ' ' -f1 >> $SLAVENODE_FILENAME_HOSTS;done < $SLAVENODE_FILENAME"
