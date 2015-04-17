#!/bin/sh

# this sets up HDFS for hg19 processing
# create the dirs in HDFS

echo creating HDFS dirs...
hadoop dfs -mkdir /crossbow-refs
hadoop dfs -mkdir /crossbow/example/hg19

# fetch the files from SL object store..
# Note that the sl manifest points back to the SL object store..
echo fetching the ref genome and manifest from SoftLayer Object Store..  
wget http://sjc01.objectstorage.softlayer.net/v1/AUTH_93d78f90-1d15-4ee2-aa8d-57fbffc9db44/bdclass/full.manifest.sl
wget http://sjc01.objectstorage.softlayer.net/v1/AUTH_93d78f90-1d15-4ee2-aa8d-57fbffc9db44/bdclass/hg19.jar



# push the ref genome into hdfs
echo pushing the reference genome into HDFS..
hadoop dfs -put hg19.jar /crossbow-refs/hg19.jar

# push the manifest into hdfs
echo pushing the manifest into HDFS...
hadoop dfs -put full.manifest.sl /crossbow/example/hg19/full.manifest.sl
