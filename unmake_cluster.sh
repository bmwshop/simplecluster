#!/bin/bash
source globals

# if [ $# -ne 4 ] ; then
#  echo " Usage: unmake_cluster.sh master_hostname base_slave_hostname domain keyname"
#  exit 1
# fi

# in v2, all inputs come from globals

mhname=$MASTER_HOSTNAME
slbhname=$SLAVES_BASE_HOSTNAME
dmn=$DOMAIN
kname=$KEYNAME

echo `date` unmake_cluster starting... 

echo `date` unmake_cluster removing key...  
./remove_key.sh

echo `date` unmake_cluster deprovisioning master...
./deprovision_master.sh

if [ -f $MASTERNODE_FILENAME ]; then
  rm $MASTERNODE_FILENAME
fi

echo `date` unmake_cluster deprovisioning slaves...
./deprovision_slaves.sh

if [ -f $SLAVENODE_FILENAME ]; then
  rm $SLAVENODE_FILENAME
fi

if [ -f $MASTERNODE_FILENAME_HOSTS ]; then
  rm $MASTERNODE_FILENAME_HOSTS
fi

if [ -f $SLAVENODE_FILENAME_HOSTS ]; then
  rm $SLAVENODE_FILENAME_HOSTS
fi

echo `date` unmake_cluster all done! 
