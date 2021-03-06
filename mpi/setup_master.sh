#!/bin/bash

source ../globals

ip=`cat ../$MASTERNODE_FILENAME | cut -d " " -f2`

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME root@$ip "apt-get install -y openmpi-bin openmpi-doc libopenmpi-dev nfs-common nfs-kernel-server"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME nfs-master.sh root@$ip:
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME root@$ip "./nfs-master.sh"
# ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "while read -r line;do echo $line | cut -d ' ' -f1 >> $SLAVENODE_FILENAME_HOSTS;done < $SLAVENODE_FILENAME"
