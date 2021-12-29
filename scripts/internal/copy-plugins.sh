#!/bin/bash
set -e

declare -a foldersExt=("$USER_PLUGINS_PATH" "$PROJECT_PLUGINS_PATH")
declare -a foldersLib=("$USER_LIB_PATH" "$PROJECT_LIB_PATH")

# Copy plugins
if [ "$CONF_SKIP_PLUGINS_INSTALL" == "false" ]; then

   # lib/ext dependencies`s
   for folder in ${foldersExt[@]}; do
      if [ -d "$folder" ]; then
         echo "Copy plugins from  :     $folder to $EXT_TARGET"
         cp -vrf "$folder"/. $EXT_TARGET/
      else
         echo "Skip copy plugin from : $folder, not found "
      fi
   done

   # lib dependencies`s
   for folder in ${foldersLib[@]}; do
      if [ -d "$folder" ]; then
         echo "Copy plugins from  :    $folder to $LIB_TARGET"
         cp -vrf "$folder"/. $LIB_TARGET/
      else
         echo "Skip copy plugin from : $folder, not found "
      fi
   done
else
   echo "Skip COPY Plugins"
fi
