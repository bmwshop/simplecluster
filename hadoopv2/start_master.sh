#!/bin/bash

source env.sh

set -x

echo `date` formatting the namenode...
/usr/local/hadoop/bin/hdfs namenode -format


/usr/local/hadoop/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR  --script hdfs start namenode

# are we running datanode on the master?
# /usr/local/hadoop/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR  --script hdfs start datanode

# are we running mapreduce on the master?
/usr/local/hadoop/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
# /usr/local/hadoop/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR  start nodemanager

/usr/local/hadoop/sbin/yarn-daemon.sh start proxyserver --config $HADOOP_CONF_DIR
/usr/local/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR


# /usr/local/hadoop/sbin/hadoop-daemon.sh --config /usr/local/hadoop/etc/hadoop  --script hdfs start namenode
# /usr/local/hadoop/sbin/hadoop-daemon.sh --config /usr/local/hadoop/etc/hadoop  --script hdfs start datanode
# /usr/local/hadoop/sbin/yarn-daemon.sh --config /usr/local/hadoop/etc/hadoop start resourcemanager
# /usr/local/hadoop/sbin/yarn-daemon.sh --config /usr/local/hadoop/etc/hadoop start nodemanager
# /usr/local/hadoop/sbin/yarn-daemon.sh start proxyserver --config /usr/local/hadoop/etc/hadoop
# /usr/local/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver --config /usr/local/hadoop/etc/hadoop