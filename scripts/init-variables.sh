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

#OUPUT
#OUTPUT_JTL_PATH
if [ -z "$OUTPUT_JTL_PATH" ]; then
    export OUTPUT_JTL_PATH="$OUTPUT_PATH/jtl"
fi

#OUTPUT_LOG_PATH
if [ -z "$OUTPUT_LOG_PATH" ]; then
    export OUTPUT_LOG_PATH="$OUTPUT_PATH/log"
fi

#OUTPUT_CSV_PATH
if [ -z "$OUTPUT_CSV_PATH" ]; then
    export OUTPUT_CSV_PATH="$OUTPUT_PATH/csv"
fi

#OUTPUT_REPORT_PATH
if [ -z "$OUTPUT_REPORT_PATH" ]; then
    export OUTPUT_REPORT_PATH="$OUTPUT_PATH/dashboard"
fi

##USER
#USER_DEPENCENCIES_PATH
if [ -z "$USER_DEPENCENCIES_PATH" ]; then
    export USER_DEPENCENCIES_PATH="$USER_PATH/dependencies"
fi
#USER_PLUGINS_PATH
if [ -z "$USER_PLUGINS_PATH" ]; then
    export USER_PLUGINS_PATH="$USER_PATH/plugins"
fi
#USER_LIB_PATH
if [ -z "$USER_LIB_PATH" ]; then
    export USER_LIB_PATH="$USER_PATH/lib"
fi
#USER_PLUGINS_URL_FILE
if [ -z "$USER_PLUGINS_URL_FILE" ]; then
    export USER_PLUGINS_URL_FILE="$USER_DEPENCENCIES_PATH/url.txt"
fi
#USER_MAVEN_SETTINGS
if [ -z "$USER_MAVEN_SETTINGS" ]; then
    export USER_MAVEN_SETTINGS="$USER_DEPENCENCIES_PATH/settings.xml"
fi

##PROJECT
#PROJECT_DEPENCENCIES_PATH
if [ -z "$PROJECT_DEPENCENCIES_PATH" ]; then
    export PROJECT_DEPENCENCIES_PATH="$PROJECT_PATH/dependencies"
fi
#PROJECT_PLUGINS_PATH
if [ -z "$PROJECT_PLUGINS_PATH" ]; then
    export PROJECT_PLUGINS_PATH="$PROJECT_PATH/plugins"
fi
#PROJECT_LIB_PATH
if [ -z "$PROJECT_LIB_PATH" ]; then
    export PROJECT_LIB_PATH="$PROJECT_PATH/lib"
fi
#PROJECT_PLUGINS_URL_FILE
if [ -z "$PROJECT_PLUGINS_URL_FILE" ]; then
    export PROJECT_PLUGINS_URL_FILE="$PROJECT_DEPENCENCIES_PATH/url.txt"
fi
#PROJECT_MAVEN_SETTINGS
if [ -z "$PROJECT_MAVEN_SETTINGS" ]; then
    export PROJECT_MAVEN_SETTINGS="$PROJECT_DEPENCENCIES_PATH/settings.xml"
fi


#WAIT

if [ -z "$CONF_READY_WAIT_TIMEOUT" ]; then
    export CONF_READY_WAIT_TIMEOUT="1200"
fi

#JMX
export JMETER_JMX_FINAL="$WORKSPACE_PATH/$JMETER_JMX"

#plugins manager
export PluginsManagerCMD=$JMETER_HOME/bin/PluginsManagerCMD.sh

#Test Plan Check
export TestPlanCheck=$JMETER_HOME/bin/TestPlanCheck.sh
