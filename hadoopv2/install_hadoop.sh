#!/bin/bash

# source globals
source env.sh

hver=2.4.1

wget http://www.motorlogy.com/apache/hadoop/common/current/hadoop-${hver}.tar.gz
tar xzf hadoop-${hver}.tar.gz
mv hadoop-${hver} /usr/local/hadoop
rm hadoop-${hver}.tar.gz
chown $USER.$USER /usr/local/hadoop

# only for the name node. we're cheating here by including it in this file
mkdir -p $DFS_NAME_DIR
chown -R $HDFS_USER:$HADOOP_GROUP $DFS_NAME_DIR
chmod -R 755 $DFS_NAME_DIR

# for the secondary name node
# mkdir -p $FS_CHECKPOINT_DIR
# chown -R $HDFS_USER:$HADOOP_GROUP $FS_CHECKPOINT_DIR
# chown -R 755 $FS_CHECKPOINT_DIR

# on all data nodes

mkdir -p $DFS_DATA_DIR
chown -R $HDFS_USER:$HADOOP_GROUP $DFS_DATA_DIR
chmod -R 750 $DFS_DATA_DIR

# on the resource manager and data nodes
mkdir -p $YARN_LOCAL_DIR
chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOCAL_DIR
chmod -R 755 $YARN_LOCAL_DIR

# on all nodes

mkdir -p $HDFS_LOG_DIR
chown -R $HDFS_USER:$HADOOP_GROUP $HDFS_LOG_DIR
chmod -R 755 $HDFS_LOG_DIR


mkdir -p $HDFS_PID_DIR
chown -R $HDFS_USER:$HADOOP_GROUP $HDFS_PID_DIR
chmod -R 755 $HDFS_PID_DIR

mkdir -p $YARN_LOG_DIR
chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOG_DIR
chmod -R 755 $YARN_LOG_DIR


mkdir -p $YARN_PID_DIR
chown -R $YARN_USER:$HADOOP_GROUP $YARN_PID_DIR
chmod -R 755 $YARN_PID_DIR

mkdir -p $MAPRED_LOG_DIR
chown -R $MAPRED_USER:$HADOOP_GROUP $MAPRED_LOG_DIR
chmod -R 755 $MAPRED_LOG_DIR

# the awesome hadoop conf dir

mkdir -p $HADOOP_CONF_DIR

# copy the apache template files
cp /usr/local/hadoop/etc/hadoop/* $HADOOP_CONF_DIR

# copy our template files
cp core-site.xml $HADOOP_CONF_DIR
cp hdfs-site.xml $HADOOP_CONF_DIR
cp yarn-site.xml $HADOOP_CONF_DIR
cp mapred-site.xml $HADOOP_CONF_DIR

chown -R $HDFS_USER:$HADOOP_GROUP $HADOOP_CONF_DIR/../
chmod -R 755 $HADOOP_CONF_DIR/../







