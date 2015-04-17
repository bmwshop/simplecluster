#!/bin/sh
set -x

$CROSSBOW_HOME/cb_hadoop \
    --preprocess \
    --input=hdfs:///crossbow/example/hg19/full.manifest.sl \
    --output=hdfs:///crossbow/example/hg19/output_full \
    --reference=hdfs:///crossbow-refs/hg19.jar
