#!/bin/bash
set -e

#Prapare JMX_ARG
prepare_jmx_args() {
   if [ ! -z "$JMETER_JMX" ]; then
      if [[ $@ == *" -t"* ]] || [[ $@ == "-t"* ]] || [[ $@ == *"--testfile"* ]]; then
         echo "ERROR: JMX file is configured twice using JMETER_JMX env variable ($JMETER_JMX), and arguments using -t or --testfile in ($@)" 1>&2
         return 1
      else
         file="$WORKSPACE_PATH/$JMETER_JMX"
         if [ -f "$file" ]; then
            export JMX_ARG=" -t $WORKSPACE_PATH/$JMETER_JMX"
         else
            echo "ERROR: Configured file in JMETER_JMX ($JMETER_JMX) not found in  : ($file) " 1>&2
            return 1
         fi
      fi
   fi
}

#prepare EXIT_ARG
prepare_exit_args() {
   if [ "$JMETER_EXIT" == "true" ]; then
      export EXIT_ARG=" --remoteexit -Gjmeterengine.remote.system.exit=true -Gserver.exitaftertest=true -Gjmeterengine.force.system.exit=true "
   fi
}

#prepare PROPERTIES_FILES_ARG
prepare_additional_file_properties() {
   if [ ! -z "$JMETER_PROPERTIES_FILES" ]; then
      export PROPERTIES_ARG=" "
      for element in $JMETER_PROPERTIES_FILES; do
         if [[ $element != *".properties" ]]; then
            echo "ERROR: file properties should end with .properties in ($element) from ($JMETER_PROPERTIES_FILES)" 1>&2
            return 1
         fi

         file="$WORKSPACE_PATH/$element"
         fileuser="$USER_PATH/$element"
         if [ -f "$file" ]; then
            export PROPERTIES_ARG=" -q $file$PROPERTIES_ARG"
            if [ -f "$fileuser" ]; then
               export PROPERTIES_ARG=" -q $fileuser$PROPERTIES_ARG"
            fi
         else
            if [ -f "$fileuser" ]; then
               export PROPERTIES_ARG=" -q $fileuser$PROPERTIES_ARG"
            else
               if [[ $element != "jmeter.properties" ]]; then
                  echo "ERROR: Configured properties file ($element) not found in  : ($file) or ($fileuser) " 1>&2
                  return 1
               fi
            fi
         fi
      done
   fi
}

#Prapare JTL_ARG
prepare_JTL_args() {
   if [ ! -z "$JMETER_JTL_FILE" ]; then
      if [[ $@ == *" -l"* ]] || [[ $@ == "-l"* ]] || [[ $@ == *"--logfile"* ]]; then
         echo "ERROR: JTL file is configured twice using JMETER_JTL_FILE env variable ($JMETER_JTL_FILE), and arguments using -l or --logfile in ($@)" 1>&2
         return 1
      else
         if [ ! -d $OUTPUT_JTL_PATH ]; then
            mkdir -p $OUTPUT_JTL_PATH
         fi
         export JTL_ARG=" -l $OUTPUT_JTL_PATH/$JMETER_JTL_FILE"
      fi
   else
      echo "Skip config JTL not present"
   fi
}

#Prapare LOG_ARG
prepare_log_args() {
   if [ ! -z "$JMETER_LOG_FILE" ]; then
      if [[ $@ == *" -j"* ]] || [[ $@ == "-j"* ]] || [[ $@ == *"--jmeterlogfile"* ]]; then
         if [[ "$JMETER_LOG_FILE" != "jmeter.log" ]]; then
            echo "ERROR: LOG file is configured twice using JMETER_LOG_FILE env variable ($JMETER_LOG_FILE), and arguments using -j or --jmeterlogfile in ($@)" 1>&2
            return 1
         fi
         export LOG_ARG=""
      else
         if [ ! -d $OUTPUT_LOG_PATH ]; then
            mkdir -p $OUTPUT_LOG_PATH
         fi
         export LOG_ARG=" --jmeterlogfile $OUTPUT_LOG_PATH/$JMETER_LOG_FILE"
      fi
   else
      echo "Skip config log not present"
   fi
}

#Prepare REPORT_ARG
prepare_report_args() {
   if [ ! -z "$JMETER_REPORT_NAME" ]; then
      if [[ $@ == *" -o"* ]] || [[ $@ == "-o"* ]] || [[ $@ == *"--reportoutputfolder"* ]]; then
         echo "ERROR: Report folder is configured twice using JMETER_REPORT_NAME env variable ($JMETER_REPORT_NAME), and arguments using -o or --reportoutputfolder in ($@)" 1>&2
         return 1
      else
         if [ ! -d $OUTPUT_REPORT_PATH ]; then
            mkdir -p $OUTPUT_REPORT_PATH
         fi
         export REPORT_ARG=" -e -o $OUTPUT_REPORT_PATH/$JMETER_REPORT_NAME"
      fi
   else
      echo "Skip config report not present"
   fi
}

#Prepare CLUSTER_ARG
prepare_cluster_args() {
   if [[ "$CONF_EXEC_IS_SLAVE" == "true" ]]; then
      export CLUSTER_ARG=" --server "
   fi

}

#Prepare JOLOKIA_ARG
prepare_jolokia_jar() {
   if [[ "$CONF_WITH_JOLOKIA" == "true" ]]; then
      jolokia_jar=$(ls $JOLOKIA_LIB)
      if [ -z "$jolokia_jar" ]; then
         echo "ERROR: Jolokia jar notfound ($jolokia_jar)"
         ls -la $JOLOKIA_LIB
         return 1
      fi
      export JOLOKIA_JAR="$JOLOKIA_LIB/$jolokia_jar"
      export JOLOKIA_ARG=" -javaagent:$JOLOKIA_JAR=config=$JOLOKIA_CONFIG "
      echo JOLOKIA_ARG=$JOLOKIA_ARG
   else
      echo "Skip Jolokia, not enabled : "
   fi
}
