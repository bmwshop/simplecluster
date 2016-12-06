#!/bin/bash

source globals

# kfname="sshkey"

#creates a new keypair and adds it to SL.

# if [ $# -ne 1 ] ; then
# echo " Usage: create_key.sh unique_keyname"
# exit 1
# fi

kname=$KEYNAME

aa=`$SLCLI_CMD sshkey list |grep $kname`

if [ ! -z "$aa" ]; then 
  echo "key $kname is already present in SL. Please select a non-existing key."
  exit 1
fi

echo `date` create_key starting with keyname $kname

# generate the thing first
ssh-keygen -t rsa -b 2048 -f $kname -q -N ""

# add it to the SL account
$SLCLI_CMD sshkey add $kname -f $kname.pub

if [ $? -eq 0 ]; then
 echo `date` create_key ... created key $kname in SL and on disk
 exit 0
else
 echo `date` 'create_key failed :('
 exit 1
fi
