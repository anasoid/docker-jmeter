#!/bin/bash
set -e

# Declare an array of string with type
declare -a folders=("$USER_DEPENCENCIES_PATH" "$PROJECT_DEPENCENCIES_PATH")



if [ "$CONF_SKIP_PLUGINS_INSTALL" == "false" ]; then

   # lib dependencies`s
   for folder in ${folders[@]}; do
      FILE=$folder/plugins-lib-dependencies.xml
      if [ -f "$FILE" ]; then
         echo "Download lib dependencies from :     $FILE"
         mvn-download.sh -f $FILE -t $LIB_TARGET
      else
         echo "Skip download lib dependencies       $FILE, not found "
      fi
   done

   # lib/ext dependencies
   for folder in ${folders[@]}; do
      FILE=$folder/plugins-lib-ext-dependencies.xml
      if [ -f "$FILE" ]; then
         echo "Download lib/ext dependencies from : $FILE"
         mvn-download.sh -f $FILE -t $EXT_TARGET
      else
         echo "Skip download lib/ext dependencies   $FILE, not found "
      fi
   done

else
   echo "Skip DEPENDENCIES Maven"
fi
