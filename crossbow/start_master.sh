#!/bin/bash

set -x

source ./env.sh

echo `date` formatting the namenode...
su $USER -c "/usr/local/hadoop/bin/hadoop namenode -format"


su $USER -c "/usr/local/hadoop/bin/start-all.sh"