#!/bin/bash
set -x

source ../globals

echo target user is $USER

if [ $# -ne 1 ] ; then
 echo " Usage: setup_slave.sh ip"
 exit 1
fi

ip=$1

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "apt-get install -y openjdk-7-jdk g++ git"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME env.sh $ip:

scp -o StrictHostKeyChecking=no -i ../$KEYNAME  core-site.xml $ip:
scp -o StrictHostKeyChecking=no -i ../$KEYNAME  hdfs-site.xml $ip:
scp -o StrictHostKeyChecking=no -i ../$KEYNAME  mapred-site.xml $ip:

scp -o StrictHostKeyChecking=no -i ../$KEYNAME install_hadoop.sh $ip:

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME $ip "./install_hadoop.sh"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME install_crossbow.sh $USER@$ip: 
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME -l $USER $ip "./install_crossbow.sh"

ssh -o StrictHostKeyChecking=no -i ../$KEYNAME -l $USER $ip "echo 'export CROSSBOW_HOME=/home/hadoop/crossbow' >> .profile"
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME -l $USER $ip "echo 'export HADOOP_HOME=/usr/local/hadoop'  >> .profile"
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME -l $USER $ip "echo 'export CROSSBOW_BOWTIE_HOME=/home/hadoop/bowtie-1.1.1' >> .profile"
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME -l $USER $ip "echo 'export CROSSBOW_SOAPSNP_HOME=/home/hadoop/crossbow/soapsnp' >> .profile"
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME -l $USER $ip "echo 'export CROSSBOW_SRATOOLKIT_HOME=/home/hadoop/sratoolkit.2.4.5-2-ubuntu64/bin' >> .profile"
ssh -o StrictHostKeyChecking=no -i ../$KEYNAME -l $USER $ip "echo 'export PATH=$PATH:/usr/local/hadoop/bin:/home/hadoop/bowtie-1.1.1/bin' >> .profile"

scp -o StrictHostKeyChecking=no -i ../$KEYNAME start_slave.sh $ip:

