#!/bin/bash
set -e

declare -a files=("$USER_PLUGINS_URL_FILE" "$PROJECT_PLUGINS_URL_FILE")

# Copy pluginscopy-
if [ "$CONF_SKIP_PLUGINS_INSTALL" == "false" ]; then

   # download install plugins
   for file in ${files[@]}; do
      if [ -f "$file" ]; then
         echo "Downloading from file: $file"
         while IFS="" read -r line || [ -n "$line" ]; do
            echo "Downloading : $line"
            rm -f /tmp/temp.zip
            wget $line -O /tmp/temp.zip
            unzip -o /tmp/temp.zip -d ${JMETER_ADDITIONAL_TARGET}
            rm -f /tmp/temp.zip
         done <"$file"
      else
         echo "Skip download zip extension plugin from : $file, not found "
      fi
   done

else

   echo "Skip COPY Plugins"
fi
