#!/bin/bash
set -e

# Declare an array of string with type
declare -a folders=("$USER_PLUGINS_PATH" "$PROJECT_PLUGINS_PATH")

if [ "$CONF_SKIP_PLUGINS_INSTALL" == "false" ]; then

   # lib dependencies`s
   for folder in ${folders[@]}; do
      if [ -d "$folder" ]; then
         echo "Copy plugins from  :    $folder"
         cp -vf $folders ${JMETER_HOME}/lib/ext
      else
         echo "Skip copy plugin from : $folder, not found "
      fi
   done
else
   echo "Skip COPY Plugins"
fi
