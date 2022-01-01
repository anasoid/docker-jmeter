#!/bin/bash

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
   else
      if [[ $@ == *" -t"* ]] || [[ $@ == "-t"* ]]; then
         echo "Using JMX from arguments"
         export JMX_ARG=""
      else
         if [[ $@ == *" -g"* ]] || [[ $@ == "-g"* ]] || [[ $@ == *"--reportonly"* ]]; then
            echo "Use report Only"
         else
            echo "ERROR: JMX file is configured twice using JMETER_JMX env variable ($JMETER_JMX), and arguments using -t or --testfile in ($@)" 1>&2
            return 1
         fi

      fi

   fi
}

#prepare EXIT_ARG
prepare_exit_args() {
   if [ "$JMETER_EXIT" == "true" ]; then
      export EXIT_ARG=" -Jjmeterengine.remote.system.exit=true --remoteexit "
   fi
}

#prepare PROPERTIES_FILES_ARG
prepare_additional_file_properties() {
   if [ ! -z "$JMETER_PROPERTIES_FILES" ]; then
      for element in $JMETER_PROPERTIES_FILES; do
         if [[ $element == *".properties" ]]; then
            echo "ERROR: file popeties should end with .properties in ($element) from ($JMETER_PROPERTIES_FILES)" 1>&2
            return 1
         fi

         file="$WORKSPACE_PATH/$element"
         if [ -f "$file" ]; then
            export PROPERTIES_FILES_ARG=" -q $file$PROPERTIES_FILES_ARG 
            "
         else
            echo "ERROR: Configured propeties file ($element) not found in  : ($file) " 1>&2
            return 1
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
         export JTL_ARG=" -t $OUTPUT_JTL_PATH/$JMETER_JTL_FILE"
      fi
   else
      echo "Skip config JTL not present"
   fi
}

#Prapare JTL_ARG
prepare_log_args() {
   if [ ! -z "$JMETER_LOG_FILE" ]; then
      if [[ $@ == *" -j"* ]] || [[ $@ == "-j"* ]] || [[ $@ == *"--jmeterlogfile"* ]]; then
         if [[ "$JMETER_LOG_FILE" != "jmeter.log" ]]; then
            echo "ERROR: LOG file is configured twice using JMETER_LOG_FILE env variable ($JMETER_LOG_FILE), and arguments using -j or --jmeterlogfile in ($@)" 1>&2
            return 1
         fi
         export LOG_ARG=""
      else
         export LOG_ARG=" --jmeterlogfile $OUTPUT_LOG_PATH/$JMETER_LOG_FILE"
      fi
   else
      echo "Skip config JTL not present"
   fi
}

#Prepare REPORT_ARG
prepare_report_args() {
   if [ ! -z "$JMETER_REPORT_NAME" ]; then
      if [[ $@ == *" -o"* ]] || [[ $@ == "-o"* ]] || [[ $@ == *"--reportoutputfolder"* ]]; then
         echo "ERROR: Report folder is configured twice using JMETER_REPORT_NAME env variable ($JMETER_REPORT_NAME), and arguments using -o or --reportoutputfolder in ($@)" 1>&2
         return 1
      else
         export REPORT_ARG=" -o $OUTPUT_REPORT_PATH/$JMETER_REPORT_NAME"
      fi
   else
      echo "Skip config JTL not present"
   fi
}
