#!/bin/bash
set -e
mkdir -p ${JOLOKIA_LIB}
mvn-download.sh -f jolokia.xml -t ${JOLOKIA_LIB}
cp $DEPENCENCIES_PATH/jolokia.properties $JOLOKIA_PATH/