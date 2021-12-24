#!/bin/bash
set -e


echo "#########################################plancheck-install (Start)#########################################"
rm -rf $DEPENCENCIES_TMP_PATH


echo "#########################################plancheck-download (Start)#########################################"
mvn-download.sh -f plancheck-dependencies.xml
echo "#########################################plancheck-download (End)#########################################"
ls -la $DEPENCENCIES_TMP_PATH

jarname=$(ls $DEPENCENCIES_TMP_PATH)

echo "jmeter-plugins-plancheck file =$jarname"

unzip -d $DEPENCENCIES_TMP_PATH/plancheck $DEPENCENCIES_TMP_PATH/$jarname

cp $DEPENCENCIES_TMP_PATH/plancheck/kg/apc/cmdtools/*.sh  ${JMETER_HOME}/bin
chmod +x ${JMETER_HOME}/bin/*.sh
cp $DEPENCENCIES_TMP_PATH/$jarname ${JMETER_HOME}/lib/ext

ls -la $DEPENCENCIES_TMP_PATH
rm -rf $DEPENCENCIES_TMP_PATH

echo "#########################################plancheck-install (End)#########################################"


