#!/bin/bash
set -e

TEST_RELATIVE_PATH=scripts/before-test.sh
declare -a files=("$USER_PATH/$TEST_RELATIVE_PATH" "$WORKSPACE_PATH/$TEST_RELATIVE_PATH")

# Exce before test
for file in ${files[@]}; do
   if [ -f "$file" ]; then
      echo "Execute $file before test"
      chmod +x $file
      $file
   else
      echo "Skip execute : $file, before test found "
   fi
done

execute_scripts_from_folders() {
   TEST_RELATIVE_PATH=scripts/before-test.sh
   declare -a files=("$USER_PATH/$TEST_RELATIVE_PATH" "$WORKSPACE_PATH/$TEST_RELATIVE_PATH")

   # Exce before test
   for file in ${files[@]}; do
      if [ -f "$file" ]; then
         echo "Execute $file before test"
         chmod +x $file
         $file
      else
         echo "Skip execute : $file, before test found "
      fi
   done
}

execute_scripts_before_test() {
   execute_scripts_from_folders "scripts/before-test.sh"

}

execute_scripts_after_test() {
   execute_scripts_from_folders "scripts/after-test.sh"

}
