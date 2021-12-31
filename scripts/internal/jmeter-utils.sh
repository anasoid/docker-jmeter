#!/bin/bash

#Prapare JMX_ARG
prepare_jmx_args() {
   if [ ! -z "$JMETER_JMX" ]; then
      if [[ $@ == *" -t"* ]] || [[ $@ == "-t"* ]]; then
         echo "ERROR: JMX file is confgured twice using JMETER_JMX env variable ($JMETER_JMX), and arguments using -t or --testfile in ($@)" 1>&2
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
         echo "ERROR: JMX file is not confgured using JMETER_JMX env variable and arguments using -t or --testfile , arguments ($@)" 1>&2
         return 1

      fi
   fi

}
