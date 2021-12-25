#!/bin/bash
set -e

#Define default target for libs
export LIB_TARGET=${JMETER_HOME}/lib
export EXT_TARGET=${JMETER_HOME}/lib/ext
export JMETER_ADDITIONAL_TARGET=${JMETER_HOME}

if [ "$CONF_SKIP_PLUGINS_INSTALL" == "false" ]; then
    export LIB_TARGET=$JMETER_ADDITIONAL_LIB
    export EXT_TARGET=$JMETER_ADDITIONAL_EXT
    export JMETER_ADDITIONAL_TARGET=$JMETER_ADDITIONAL_HOME
fi
echo "Using additional libs folder ($LIB_TARGET ,$LIB_TARGET ) "

#WORKSPACE
export WORKSPACE_PATH=${PROJECT_PATH}
if [ "$CONF_COPY_TO_WORKSPACE" == "true" ]; then
    export WORKSPACE_PATH=${WORKSPACE_TARGET}
fi
echo "Using WORKSPACE  folder ($WORKSPACE_PATH ) "

#SLAVE/MASTER
export WORKSPACE_PATH=${PROJECT_PATH}
if [ "${EXEC_MODE,,}" == "master" ]; then
    export EXEC_MODE_UP="MASTER"
elif [ "${EXEC_MODE,,}" == "slave" ]; then
    export EXEC_MODE_UP="SLAVE"
else
    echo "Error!  Invalid EXEC_MODE  (${EXEC_MODE}), should be slave or master" 1>&2
    exit 1
fi
echo "Using EXEC_MODE_UP  ($EXEC_MODE_UP ) "
