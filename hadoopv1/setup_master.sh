#!/bin/bash

source ../globals

ip=`cat ../$MASTERNODE_FILENAME | cut -d " " -f1`

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "apt-get install -y openjdk-7-jdk vnc4server firefox"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME  env.sh $ip:
scp -o StrictHostKeyChecking=no -i ../$KEYNAME  core-site.xml $ip:
scp -o StrictHostKeyChecking=no -i ../$KEYNAME  hdfs-site.xml $ip:
scp -o StrictHostKeyChecking=no -i ../$KEYNAME  mapred-site.xml $ip:

scp -o StrictHostKeyChecking=no -i ../$KEYNAME install_hadoop.sh $ip:
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "./install_hadoop.sh"
scp -o StrictHostKeyChecking=no -i ../$KEYNAME start_master.sh $ip:

# ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "./start_master.sh"

# ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "while read -r line;do echo $line | cut -d ' ' -f1 >> $SLAVENODE_FILENAME_HOSTS;done < $SLAVENODE_FILENAME"

