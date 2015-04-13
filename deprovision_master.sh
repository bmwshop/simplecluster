#!/bin/bash

source globals

# globals_fn="globals"
# globals_fn_classic="globals.classic"
# master_fn="master.txt"


# if [ $# -ne 2 ] ; then
# echo " Usage: deprovision_master.sh base_hostname domain"
# exit 1
# fi


hname=$MASTER_HOSTNAME
dmn=$DOMAIN

echo `date` 'deprovision_master starting'


for i in `sl cci list --format=raw |grep "${hname}.${dmn}" | cut -d " " -f1`
do
  echo `date` "deprovision_master canceling node $i"
  sl cci cancel $i --really
done

# rm $master_fn 
# mv $globals_fn_classic $globals_fn
if [ -f $MASTERNODE_FILENAME ]; then
  rm $MASTERNODE_FILENAME
fi

if [ -f $MASTERNODE_FILENAME_HOSTS ]; then
  rm $MASTERNODE_FILENAME_HOSTS
fi


echo `date` 'deprovision_master done'