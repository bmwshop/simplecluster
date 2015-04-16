#!/bin/bash

source globals

# provisions a slave node
if [ $# -ne 1 ] ; then
echo " Usage: provision_slave.sh hostname"
exit 1
fi

hname=$1

dmn=$DOMAIN
kname=$KEYNAME
dc=$DATACENTER

nic=$SLAVE_NIC

currentTime=$(date)
before=$(date +%s)

disk=$SLAVE_DISK

echo `date` .. starting to provision VM ${hname}.${dmn} in $dc
id=`sl cci create --datacenter=$dc --hostname=$hname --domain=$dmn --disk=$disk --n=$nic --cpu=$SLAVE_CPU --memory=$SLAVE_MEM --os=$SLAVE_OS --key=$kname --hourly --really --wait=86400  --format=raw |grep "^id" |awk '{print $2}'`


echo `date` .. done provisioning VM ${hname}.${dmn} id $id in $dc
after=$(date +%s)
delta="$(expr $after - $before)"
echo `date` ... provisioning done in $delta in $dc
private_ip=`sl cci detail $id --format=raw |grep "^private_ip" |awk '{print $2}'`
public_ip=`sl cci detail $id --format=raw |grep "^public_ip" |awk '{print $2}'`


# save the ip
echo "$private_ip $public_ip $hname" >> $SLAVENODE_FILENAME
echo "$hname" >> $SLAVENODE_FILENAME_HOSTS
