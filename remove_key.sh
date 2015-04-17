#!/bin/bash

source globals

kname=$KEYNAME

echo `date` remove_key starting with keyname $kname

rm $kname $kname.pub

$SLCLI_CMD sshkey remove $kname --really

if [ $? -eq 0 ]; then
 echo `date` remove_key ... removed key $kname in SL and on disk
else
 echo `date` 'remove_key failed :('
fi
