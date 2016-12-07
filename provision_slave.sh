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
#echo "$SLCLI_CMD --really --format=raw vs create --datacenter=$dc --hostname=$hname --domain=$dmn --disk=$disk --network=$nic --cpu=$SLAVE_CPU --memory=$SLAVE_MEM --os=$SLAVE_OS --key=$kname --billing=hourly --wait=86400" 
id=`$SLCLI_CMD --really --format=raw vs create --datacenter=$dc --hostname=$hname --domain=$dmn --disk=$disk --network=$nic --cpu=$SLAVE_CPU --memory=$SLAVE_MEM --os=$SLAVE_OS --key=$kname --billing=hourly --wait=86400  |grep "^id" |awk '{print $2}'`


echo `date` .. done provisioning VM ${hname}.${dmn} id $id in $dc
after=$(date +%s)
delta="$(expr $after - $before)"
echo `date` ... provisioning done in $delta in $dc
private_ip=`$SLCLI_CMD --format=raw vs detail $id |grep "^private_ip" |awk '{print $2}'`
public_ip=`$SLCLI_CMD --format=raw vs detail $id |grep "^public_ip" |awk '{print $2}'`


# save the ip
echo "$private_ip $public_ip $hname" >> $SLAVENODE_FILENAME
echo "$hname" >> $SLAVENODE_FILENAME_HOSTS
