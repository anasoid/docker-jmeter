#!/bin/sh
# Inspired from https://github.com/hhcordero/docker-jmeter-client
# Basically runs jmeter, assuming the PATH is set to point to JMeter bin-dir (see Dockerfile)
#
# This script expects the standdard JMeter command parameters.
#

# Install jmeter plugins available on /plugins volume
echo $PATH
echo
mvn -version

echo
java -version

echo
jmeter --version


echo
timeout 5 ls -al ${JMETER_HOME}

echo  ----------------------------------ls tmp
ls -lah /tmp

echo -----------------------------------mvn-download
mvn-download.sh 


echo  ----------------------------------ls tmp
ls -lah /tmp