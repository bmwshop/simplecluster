#!/bin/bash

source globals

# slaves_fn="slaves.txt"
# mpihosts_fn="mpi_hosts"

# provisions the slave nodes
# if [ $# -ne 4 ] ; then
# echo " Usage: provision_slaves.sh num base_hostname domain keyname"
# exit 1
# fi

currentTime=$(date)
before=$(date +%s)

echo `date` .. starting to provision $num slaves

for j in `seq 1 $NUM_SLAVES`; do
 ./provision_slave.sh  ${SLAVES_BASE_HOSTNAME}${j} &
done

echo `date` provision_slaves provisioning kicked off... now waiting...
wait

after=$(date +%s)
delta="$(expr $after - $before)"
echo `date` provision_slaves... all slaves done in $delta

# the slaves wrote the slaves file.  Now, we need to update mpi_hosts
# cp -p $slaves_fn $mpihosts_fn

