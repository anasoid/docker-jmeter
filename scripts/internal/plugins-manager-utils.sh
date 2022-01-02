#!/bin/bash
set -e

#Check config
if [[ "$WITH_BASE_PLUGINS" == "false" ]]; then
   if [[ ! -z "$JMETER_PLUGINS_MANAGER_INSTALL_LIST" ]] || [[ "$JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX" == "true" ]]; then
      echo "ERROR: This Image doesn't support Jmeter-plugin installation, please use image with version plugin" 1>&2
      return 1
   fi
fi

#JMETER_PLUGINS_MANAGER_INSTALL_LIST
if [[ ! -z "$JMETER_PLUGINS_MANAGER_INSTALL_LIST" ]]; then
   echo "Installing plugins from list: $JMETER_PLUGINS_MANAGER_INSTALL_LIST"
   $PluginsManagerCMD install $JMETER_PLUGINS_MANAGER_INSTALL_LIST
else
   echo "Skip install JMETER_PLUGINS_MANAGER_INSTALL_LIST"
fi

#JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX
if [[ "$JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX" == "true" ]]; then
   echo "Installing plugins for JMX"
   $PluginsManagerCMD install-for-jmx $JMETER_JMX_FINAL
else
   echo "Skip install JMETER_PLUGINS_MANAGER_INSTALL_FOR_JMX"
fi
