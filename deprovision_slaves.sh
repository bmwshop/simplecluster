#!/bin/bash

source globals
# slaves_fn="slaves.txt"
# mpihosts_fn="mpi_hosts"


# if [ $# -ne 2 ] ; then
# echo " Usage: deprovision_slaves.sh base_hostname domain"
# exit 1
# fi


hname=$SLAVES_BASE_HOSTNAME
dmn=$DOMAIN

echo `date` 'deprovision_slaves starting'


for i in `sl vs list |grep ${hname} |grep ${dmn} | cut -d " " -f1`
do
  echo `date` "deprovision_slaves canceling node $i"
  $SLCLI_CMD vs cancel $i --really
done

# rm $slaves_fn $mpihosts_fn
if [ -f $SLAVENODE_FILENAME ]; then
  rm $SLAVENODE_FILENAME
fi

if [ -f $SLAVENODE_FILENAME_HOSTS ]; then
  rm $SLAVENODE_FILENAME_HOSTS
fi

echo `date` 'deprovision_slaves done'
