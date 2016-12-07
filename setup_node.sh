#!/bin/bash

source globals

if [ $# -ne 1 ] ; then
echo " Usage: setup_node.sh ipaddr"
exit 1
fi

ipaddr=$1
kname=$KEYNAME

echo `date` setup_node.sh starting on $ipaddr

# let us update /etc/hosts first... 
# must remove the original record from /etc/hosts ...
rhn=`ssh -n -o StrictHostKeyChecking=no -i $kname root@$ipaddr "hostname"`
ssh -n -o StrictHostKeyChecking=no -i $kname root@$ipaddr sed -i "/$rhn/d" /etc/hosts

echo `date` setup_node.sh checking the master file
while read -r i
do
  echo `date` setup_node.sh processing master line $i
  sip=`echo "$i" | cut -d " " -f2`
  shn=`echo "$i" | cut -d " " -f3`
  chk=`ssh -n -o StrictHostKeyChecking=no -i $kname root@$ipaddr "grep $sip /etc/hosts"`
  if [ -z "$chk" ]; then
    echo `date` setup_node.sh adding master line $i
	ssh -n -o StrictHostKeyChecking=no -i $kname root@$ipaddr "echo $sip $shn.$DOMAIN $shn >> /etc/hosts"
  fi
done < $MASTERNODE_FILENAME

echo `date` setup_node.sh checking the slaves file
while read -r i
do
  echo `date` setup_node.sh processing slave line $i
  sip=`echo "$i" | cut -d " " -f2`
  shn=`echo "$i" | cut -d " " -f3`
  chk=`ssh -n -o StrictHostKeyChecking=no -i $kname root@$ipaddr "grep $sip /etc/hosts"`
  if [ -z "$chk" ]; then
    echo `date` setup_node.sh adding slave line $i
	ssh -n -o StrictHostKeyChecking=no -i $kname root@$ipaddr "echo $sip $shn.$DOMAIN $shn >> /etc/hosts"
  fi
done < $SLAVENODE_FILENAME

echo `date` setup_node.sh now installing packages and configuring keys

# for i in `cat $MASTERNODE_FILENAME` `cat $SLAVENODE_FILENAME`
# do
#   sip=`echo "$i" | cut -d " " -f1`
#   shn=`echo "$i" | cut -d " " -f2`
#   chk=`ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "grep $sip /etc/hosts"`
#   if [ -z "$chk" ]; then
#	ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "echo $sip $shn.$DOMAIN $shn >> /etc/hosts"
#  fi
# done


ssh -o StrictHostKeyChecking=no -i $kname root@$ipaddr "apt-get update && apt-get install -y build-essential openssh-server openssh-client ntp curl unzip" 

scp -o StrictHostKeyChecking=no -i $kname globals root@$ipaddr:globals
scp -o StrictHostKeyChecking=no -i $kname $MASTERNODE_FILENAME root@$ipaddr:$MASTERNODE_FILENAME
scp -o StrictHostKeyChecking=no -i $kname $SLAVENODE_FILENAME root@$ipaddr:$SLAVENODE_FILENAME
scp -o StrictHostKeyChecking=no -i $kname $MASTERNODE_FILENAME_HOSTS root@$ipaddr:$MASTERNODE_FILENAME_HOSTS
scp -o StrictHostKeyChecking=no -i $kname $SLAVENODE_FILENAME_HOSTS root@$ipaddr:$SLAVENODE_FILENAME_HOSTS


# ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "git clone https://github.com/irifed/softlayer-mpicluster.git"
# configure cluster software
ssh -o StrictHostKeyChecking=no -i $kname root@$ipaddr "echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config"
ssh -o StrictHostKeyChecking=no -i $kname root@$ipaddr "adduser --disabled-password --gecos \"\" $USER"

ssh -o StrictHostKeyChecking=no -i $kname root@$ipaddr "mkdir -m 700 ~${USER}/.ssh"
scp -o StrictHostKeyChecking=no -i $kname $kname root@$ipaddr:/home/${USER}/.ssh/id_rsa
scp -o StrictHostKeyChecking=no -i $kname $kname.pub root@$ipaddr:/home/${USER}/.ssh/id_rsa.pub
ssh -o StrictHostKeyChecking=no -i $kname root@$ipaddr "cat /home/${USER}/.ssh/id_rsa.pub >> /home/${USER}/.ssh/authorized_keys"
ssh -o StrictHostKeyChecking=no -i $kname root@$ipaddr "chmod 0600 /home/${USER}/.ssh/authorized_keys"
ssh -o StrictHostKeyChecking=no -i $kname root@$ipaddr "chmod 0600 /home/${USER}/.ssh/id_rsa.pub"

ssh -o StrictHostKeyChecking=no -i $kname root@$ipaddr "chown -R $USER.$USER /home/${USER}/.ssh"

scp -o StrictHostKeyChecking=no -i $kname globals ${USER}@${ipaddr}:globals
scp -o StrictHostKeyChecking=no -i $kname $MASTERNODE_FILENAME ${USER}@${ipaddr}:$MASTERNODE_FILENAME
scp -o StrictHostKeyChecking=no -i $kname $SLAVENODE_FILENAME ${USER}@${ipaddr}:$SLAVENODE_FILENAME
scp -o StrictHostKeyChecking=no -i $kname $MASTERNODE_FILENAME_HOSTS ${USER}@${ipaddr}:$MASTERNODE_FILENAME_HOSTS
scp -o StrictHostKeyChecking=no -i $kname $SLAVENODE_FILENAME_HOSTS ${USER}@${ipaddr}:$SLAVENODE_FILENAME_HOSTS


echo `date` ... all done


