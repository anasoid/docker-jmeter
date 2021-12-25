#!/bin/bash
set -e


echo "#########################################plugin-manager-install (Start)#########################################"
rm -rf $DEPENCENCIES_TMP_PATH


echo "#########################################plugin-manager-download (Start)#########################################"
mvn-download.sh -f plugin-manager-dependencies.xml
echo "#########################################plugin-manager-download (End)#########################################"
ls -la $DEPENCENCIES_TMP_PATH

jarname=$(ls $DEPENCENCIES_TMP_PATH)

echo "jmeter-plugin-manager file =$jarname"

unzip -d $DEPENCENCIES_TMP_PATH/manager $DEPENCENCIES_TMP_PATH/$jarname

cp $DEPENCENCIES_TMP_PATH/manager/org/jmeterplugins/repository/*.sh  ${JMETER_HOME}/bin
chmod +x ${JMETER_HOME}/bin/*.sh
cp $DEPENCENCIES_TMP_PATH/$jarname ${JMETER_HOME}/lib/ext

ls -la $DEPENCENCIES_TMP_PATH
rm -rf $DEPENCENCIES_TMP_PATH

echo "#########################################plugin-manager-install (End)#########################################"


