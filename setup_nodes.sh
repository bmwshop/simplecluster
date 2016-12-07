#!/bin/bash

source globals

# kname=$KEYNAME

# sets up sw on all nodes

for i in `cat $MASTERNODE_FILENAME | cut -d " " -f2` `cat $SLAVENODE_FILENAME | cut -d " " -f2`
do
# if [ ! -z $i ]; then
echo `date` setup_nodes.. starting to setup node $i
./setup_node.sh $i &
# fi

done

echo `date` setup_nodes kicked off generic node setup... now waiting...
wait

echo `date` setup_nodes Now setting up the slave nodes.. 
cd ${CLUSTER_TYPE}
# note that we're working in  a dir one level down still 
for i in `cat ../${SLAVENODE_FILENAME} | cut -d " " -f2`
do
 ./setup_slave.sh $i &
done


echo `date` setup_nodes Now setting up the master node.. 

 
./setup_master.sh &

echo `date` setup_nodes Now waiting for the nodes to complete setting up.. 
wait
# get back up.
cd ..

echo `date` setup_nodes Now starting up cluster.. 
mip=`cat $MASTERNODE_FILENAME | cut -d " " -f2`

ssh -o StrictHostKeyChecking=no -i $KEYNAME root@$mip "./start_master.sh"

echo `date` setup_nodes... all done


