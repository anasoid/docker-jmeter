#!/bin/bash
set -e

get_list_csv_files() {
   pwd
   (
      cd $WORKSPACE_PATH
      find -L -iname *.csv -ipath "$CONF_CSV_SPLIT_PATTERN"
   )
   pwd

}

split_csv_file_all_csv() {
   if [ "$CONF_CSV_SPLIT" == "true" ]; then
      for csvfilefull in $(get_list_csv_files); do
         split_csv_file $WORKSPACE_PATH/$csvfilefull $CONF_EXEC_WORKER_COUNT $CONF_EXEC_WORKER_NUMBER $CONF_CSV_WITH_HEADER $csvfilefull
      done
   fi
}

split_csv_file() {
   csvfilefull=$1
   slave_count=$2
   slave_num=$3
   with_header=$4
   relative_path=$5

   #valdate
   if [ "$slave_count" -lt "1" ] || [ "$slave_num" -lt "0" ] || [ "$slave_count" -lt "$slave_num" ]; then
      echo "Worker count : $slave_count"
      echo "Worker number : $slave_num"
      echo "Error : Config worker not correct, Worker count should be greater or equal than worker number, and they should be geater than 0" 1>&2
      exit 1
   fi

   tmp_file=/tmp/spliting
   echo "INFO" "csvfilefull=${csvfilefull}"
   csvfile="${csvfilefull##*/}"
   echo "INFO" "Processing file.. $csvfile"
   lines_total=$(cat "${csvfilefull}" | wc -l)
   if [ "$lines_total" -gt "0" ]; then
      touch $tmp_file
      i=0
      while IFS= read -r line; do
         ((i = i + 1))
         if [ "$i" == "1" ] && [ "$CONF_CSV_WITH_HEADER" == "true" ]; then
            echo "$line" >>$tmp_file
            continue
         fi
         if [ "$(($i % $slave_count))" == "$(($slave_num % $slave_count))" ]; then
            echo "$line" >>$tmp_file
         fi
      done <"$csvfilefull"
      if [ "$CONF_CSV_DIVIDED_TO_OUT" == "true" ]; then
         destination_file=$OUTPUT_CSV_PATH/$relative_path.$slave_num
         folder="$(dirname "$destination_file")"
         if [ ! -d $folder ]; then
            mkdir -p $folder
         fi
         cp -rv $tmp_file $destination_file
      fi
      mv -fv $tmp_file $csvfilefull

   else

      echo "WRAN : Skip split empty file : $csvfilefull"
   fi
}
