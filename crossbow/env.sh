#!/bin/bash

set -x

source ./globals
# settings specific to Hadoop v1

HADOOP_ROOT=/usr/local/hadoop
# user names for various services
HDFS_USER=hadoop
HADOOP_USER=hadoop
# ahem.  but then again.
HADOOP_GROUP=hadoop

DFS_NAME_DIR=/usr/local/hadoop/hdfs/nn
DFS_DATA_DIR=/data

JDK=openjdk-7-jdk
JDK_ROOT=/usr/lib/jvm/java-7-openjdk-amd64/jre

# secondary namenode only
#FS_CHECKPOINT_DIR=/usr/local/hadoop/hdfs/snn

# HDFS_LOG_DIR=/var/log/hadoop/$HDFS_USER
# HDFS_PID_DIR=/var/run/hadoop/$HDFS_USER

HADOOP_CONF_DIR=$HADOOP_ROOT/conf

# MAPRED_LOG_DIR=/var/log/hadoop/$MAPRED_USER






