#!/bin/bash

source globals

# globals_fn="globals"
# globals_fn_classic="globals.classic"
# master_fn="master.txt"

master_fn=$MASTERNODE_FILENAME

# provisions the master node
# if [ $# -ne 3 ] ; then
# echo " Usage: provision_master.sh hostname domain keyname"
# exit 1
# fi

hname=$MASTER_HOSTNAME
dmn=$DOMAIN
kname=$KEYNAME
dc=$DATACENTER

currentTime=$(date)
before=$(date +%s)

cci_cpu=$MASTER_CPU
cci_mem=$MASTER_MEM
cci_os=$MASTER_OS

nic=$MASTER_NIC
disk=$MASTER_DISK

echo `date` .. starting to provision VM ${hname}.${dmn} in $dc
#echo "$SLCLI_CMD --really --format=raw vs create --datacenter=$dc --hostname=$hname --domain=$dmn --cpu=$cci_cpu --disk=$disk --network=$nic --memory=$cci_mem --os=$cci_os --key=$kname --billing=hourly --wait=86400"  
id=`$SLCLI_CMD --really --format=raw vs create --datacenter=$dc --hostname=$hname --domain=$dmn --cpu=$cci_cpu --disk=$disk --network=$nic --memory=$cci_mem --os=$cci_os --key=$kname --billing=hourly --wait=86400  |grep "^id" |awk '{print $2}'`


echo `date` .. done provisioning VM ${hname}.${dmn} id $id in $dc
after=$(date +%s)
delta="$(expr $after - $before)"
echo `date` ... provisioning done in $delta in $dc
private_ip=`$SLCLI_CMD --format=raw vs detail $id |grep "^private_ip" |awk '{print $2}'`
public_ip=`$SLCLI_CMD --format=raw vs detail $id |grep "^public_ip" |awk '{print $2}'`

# overwrite the globals file
# cp -p $globals_fn $globals_fn_classic
# sed -i "s/10.104.15.22/$ip/" $globals_fn

# save the master ip
echo "$private_ip $public_ip $hname" > $master_fn
echo "$hname" > $MASTERNODE_FILENAME_HOSTS
