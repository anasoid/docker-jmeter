#!/bin/bash
set -e

. jmeter-utils.sh

#Prapare JMX_ARG
prepare_jmx_args
#prepare EXIT_ARG
prepare_exit_args
#prepare PROPERTIES_ARG
prepare_additional_file_properties
#Prapare JTL_ARG
prepare_JTL_args
#Prapare LOG_ARG
prepare_log_args
#Prepare REPORT_ARG
prepare_report_args
#Prepare CLUSTER_ARG
prepare_cluster_args
#prepare JOLOKIA_JAR
prepare_jolokia_jar

if [[ "$CONF_EXEC_IS_SLAVE" == "true" ]]; then
    if [ ! -d $OUTPUT_LOG_PATH ]; then
        mkdir -p $OUTPUT_LOG_PATH
    fi
    (
        sleep 10
        java -jar $JOLOKIA_JAR --config $JOLOKIA_CONFIG start Jmeter >$OUTPUT_LOG_PATH/jolokia.log
    ) &
else
    JVM_ARGS="$JVM_ARGS $JOLOKIA_ARG "
fi

export JVM_ARGS=" $JVM_ARGS $JMETER_JVM_ARGS $JMETER_JVM_EXTRA_ARGS "

echo "JVM_ARGS=${JVM_ARGS}"

FULL_ARGS="$JMETER_DEFAULT_ARGS $JMX_ARG $EXIT_ARG $PROPERTIES_ARG $JTL_ARG $LOG_ARG $REPORT_ARG $CLUSTER_ARG "

echo "FULL_ARGS=$FULL_ARGS"

echo "jmeter ALL ARGS=$FULL_ARGS $@"

echo "START Running Jmeter on ($(date)) with timeout ($CONF_EXEC_TIMEOUT)"

timeout -s 9 $CONF_EXEC_TIMEOUT jmeter $FULL_ARGS $@

echo "End   Running Jmeter on ($(date)) "
