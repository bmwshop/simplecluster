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

echo `date` .. starting to provision VM ${hname}.${dmn} in $dc
id=`sl cci create --datacenter=$dc --hostname=$hname --domain=$dmn --cpu=$cci_cpu --n=$nic --memory=$cci_mem --os=$cci_os --key $kname --hourly --really --wait=86400  --format=raw |grep "^id" |awk '{print $2}'`


echo `date` .. done provisioning VM ${hname}.${dmn} id $id in $dc
after=$(date +%s)
delta="$(expr $after - $before)"
echo `date` ... provisioning done in $delta in $dc
private_ip=`sl cci detail $id --format=raw |grep "^private_ip" |awk '{print $2}'`
public_ip=`sl cci detail $id --format=raw |grep "^public_ip" |awk '{print $2}'`

# overwrite the globals file
# cp -p $globals_fn $globals_fn_classic
# sed -i "s/10.104.15.22/$ip/" $globals_fn

# save the master ip
echo "$private_ip $public_ip $hname" > $master_fn
echo "$hname" > $MASTERNODE_FILENAME_HOSTS
