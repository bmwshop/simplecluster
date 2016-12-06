#!/bin/bash

source ../globals

ip=`cat ../$MASTERNODE_FILENAME | cut -d " " -f2`

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME root@$ip "apt-get install -y openjdk-7-jdk vnc4server firefox"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME env.sh root@$ip:
scp -o StrictHostKeyChecking=no -i ../$KEYNAME install_hadoop.sh root@$ip:
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME root@$ip "./install_hadoop.sh"
# scp -o StrictHostKeyChecking=no -i ../$KEYNAME start_master.sh $ip:


# ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "while read -r line;do echo $line | cut -d ' ' -f1 >> $SLAVENODE_FILENAME_HOSTS;done < $SLAVENODE_FILENAME"

