#!/bin/bash

set -x

source globals
# settings specific to Hadoop v2

# user names for various services
HDFS_USER=$USER
YARN_USER=$USER
ZOOKEEPER_USER=$USER
HIVE_USER=$USER
WEBHCAT_USER=$USER
HBASE_USER=$USER
PIG_USER=$USER
# ahem.  but then again.
HADOOP_GROUP=$USER

DFS_NAME_DIR=/usr/local/hadoop/hdfs/nn
DFS_DATA_DIR=/usr/local/hadoop/hdfs/dn

# secondary namenode only
FS_CHECKPOINT_DIR=/usr/local/hadoop/hdfs/snn

HDFS_LOG_DIR=/var/log/hadoop/$HDFS_USER
HDFS_PID_DIR=/var/run/hadoop/$HDFS_USER

HADOOP_CONF_DIR=/etc/hadoop/conf

YARN_LOCAL_DIR=/usr/local/hadoop/yarn

YARN_LOG_DIR=/var/log/hadoop/$YARN_USER
YARN_PID_DIR=/var/run/hadoop/$YARN_USER

MAPRED_LOG_DIR=/var/log/hadoop/$MAPRED_USER






