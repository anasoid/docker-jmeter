#!/bin/bash
set -e

#Define default target for libs
export LIB_TARGET=${JMETER_HOME}/lib
export EXT_TARGET=${JMETER_HOME}/lib/ext
export JMETER_ADDITIONAL_TARGET=${JMETER_HOME}

echo "Using libs folder ($LIB_TARGET ,$EXT_TARGET ) "

#WORKSPACE
export WORKSPACE_PATH=${PROJECT_PATH}
if [ "$CONF_COPY_TO_WORKSPACE" == "true" ]; then
    export WORKSPACE_PATH=${WORKSPACE_TARGET}
fi
echo "Using WORKSPACE  folder ($WORKSPACE_PATH ) "

#JMX
export JMETER_JMX_FINAL="$WORKSPACE_PATH/$JMETER_JMX"

#plugins manager
export PluginsManagerCMD=$JMETER_HOME/bin/PluginsManagerCMD.sh

#Test Plan Check
export TestPlanCheck=$JMETER_HOME/bin/TestPlanCheck.sh
