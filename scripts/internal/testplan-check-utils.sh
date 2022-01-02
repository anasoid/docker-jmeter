#!/bin/bash
set -e

#Check config
if [[ "$WITH_BASE_PLUGINS" == "false" ]]; then
   if [[ "$JMETER_CHECK_ONLY" == "true" ]]; then
      echo "ERROR: This Image doesn't support Jmeter-plugin installation, please use image with version plugin" 1>&2
      return 1
   fi
fi

#JMETER_CHECK_ONLY
if [[ "$JMETER_CHECK_ONLY" == "true" ]]; then
   echo "TestPlanCheck for JMX"
   $TestPlanCheck --jmx $JMETER_JMX_FINAL
else
   echo "Skip TestPlanCheck"
fi
