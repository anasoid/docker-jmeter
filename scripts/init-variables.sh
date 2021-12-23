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

export WORKSPACE_PATH=${PROJECT_PATH}

if [ "$CONF_COPY_TO_WORKSPACE" == "true" ]; then
    export WORKSPACE_PATH=${WORKSPACE_TARGET}
fi

echo "Using WORKSPACE  folder ($WORKSPACE_PATH ) "
