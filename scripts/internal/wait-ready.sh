#!/bin/bash
set -e

if [ ! -z "$CONF_READY_WAIT_FILE" ]; then

   if [[ "$CONF_READY_WAIT_FILE" == /* ]]; then
      FILE_READY=$CONF_READY_WAIT_FILE
   else
      FILE_READY=$PROJECT_PATH/$CONF_READY_WAIT_FILE
   fi

   sleep_wait=10
   END=$(($CONF_READY_WAIT_TIMEOUT / $sleep_wait))
   echo " $(date) : Start waiting for file ($FILE_READY) to be ready"
   for i in $(seq 1 $END); do

      if [ -f "$FILE_READY" ]; then
         echo " $(date) : Ready file found ($FILE_READY)"
         break
      else
         echo " $(date) : Waiting Ready file ($FILE_READY)"
      fi

      sleep $sleep_wait
   done
   echo " $(date) : End  waiting for file ($FILE_READY) to be ready"
   if [ ! -f "$FILE_READY" ]; then
      echo " $(date) >>> Error : Ready file not found ($FILE_READY)"
      exit 1
   fi

else
   echo " $(date) : Skip Ready wait"
fi
