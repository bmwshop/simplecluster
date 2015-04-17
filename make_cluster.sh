#!/bin/bash

# globals_fn="globals"

source globals

# if [ $# -ne 5 ] ; then
# echo " Usage: make_cluster.sh master_hostname base_slave_hostname domain num_slaves keyname"
# exit 1
# fi

# in v2, all inputs come from globals


echo `date` make_cluster starting with consistency checks


if [ ! -d $CLUSTER_TYPE ];then
	echo "make_cluster unknown cluster type $CLUSTER_TYPE .. directory exist?"
	exit 1
fi


if [ -f $MASTERNODE_FILENAME ];then
	echo "make_cluster masternode file $MASTERNODE_FILENAME" already exists.  Please check it to ensure that there is no live cluster there.
	exit 1
fi

if [ -f $SLAVENODE_FILENAME ];then
	echo "make_cluster slavenode file $SLAVENODE_FILENAME" already exists.  Please check it to ensure that there is no live cluster there.
	exit 1
fi

echo `date` make_cluster creating key...  
./create_key.sh
if [ $? -ne 0 ]; then
 echo `date` 'create_key failed :('
 exit 1
fi

echo `date` make_cluster provisioning master...
./provision_master.sh &

echo `date` make_cluster provisioning slaves...
./provision_slaves.sh &

echo `date` make_cluster waiting for all to provision.. 
wait

echo `date` make_cluster setting up nodes... 
./setup_nodes.sh
if [ $? -ne 0 ]; then
 echo `date` 'setup_nodes failed :('
 exit 1
fi

# echo "KEYNAME=$kname" >> $globals_fn

echo `date` make_cluster all done! 
