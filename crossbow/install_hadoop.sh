#!/bin/bash

# source globals
source ./env.sh

# apt-get install $JDK -y

hver=1.2.1

wget http://apache.claz.org/hadoop/core/hadoop-${hver}/hadoop-${hver}.tar.gz
tar xzf hadoop-${hver}.tar.gz
mv hadoop-${hver} $HADOOP_ROOT
rm hadoop-${hver}.tar.gz
chown -R $HADOOP_USER.$HADOOP_USER $HADOOP_ROOT

# only for the name node. we're cheating by including it in this file
# mkdir -p $DFS_NAME_DIR
# chown -R $HDFS_USER:$HADOOP_GROUP $DFS_NAME_DIR
# chmod -R 755 $DFS_NAME_DIR


# on all data nodes

mkdir -p $DFS_DATA_DIR
chown -R $HDFS_USER:$HADOOP_GROUP $DFS_DATA_DIR
chmod -R 755 $DFS_DATA_DIR




# the awesome hadoop conf dir

# mkdir -p $HADOOP_CONF_DIR

# copy the apache template files
# cp /usr/local/hadoop/etc/hadoop/* $HADOOP_CONF_DIR

# copy our template files
cp ./core-site.xml $HADOOP_CONF_DIR
cp ./hdfs-site.xml $HADOOP_CONF_DIR
cp ./mapred-site.xml $HADOOP_CONF_DIR
cp ./$SLAVENODE_FILENAME_HOSTS $HADOOP_CONF_DIR/slaves

# our master will also be a slave
cat ./$MASTERNODE_FILENAME_HOSTS >> $HADOOP_CONF_DIR/slaves

# set java home in hadoop-env.sh

sed -i "1 i\export JAVA_HOME=$JDK_ROOT" $HADOOP_CONF_DIR/hadoop-env.sh
# mv $HADOOP_CONF_DIR/hadoop-env.sh h.temp
# echo 'export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre' >> $HADOOP_CONF_DIR/hadoop-env.sh
# cat h.temp >> $HADOOP_CONF_DIR/hadoop-env.sh
# rm h.temp

# chown -R $HDFS_USER:$HADOOP_GROUP $HADOOP_CONF_DIR/../
# chmod -R 755 $HADOOP_CONF_DIR/../








