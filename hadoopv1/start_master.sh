#!/bin/bash

set -x

echo `date` formatting the namenode...
su hadoop -c "/usr/local/hadoop/bin/hadoop namenode -format"


su hadoop -c "/usr/local/hadoop/bin/start-all.sh"