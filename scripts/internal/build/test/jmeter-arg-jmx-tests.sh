#!/bin/bash
set -e

. $(pwd)/scripts/internal/jmeter-utils.sh

assert_equals() {
   if [ "$1" == "$2" ]; then
      export EXEC_MODE_UP="MASTER"
   else
      echo "Error!  Assertion  equals ($1) <> ($2),in $3"
      exit 1
   fi
}

test_prepare_jmx_args_success() {
   set -e
   JMX_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_JMX=test-plan.jmx
   prepare_jmx_args
   if [ $? -eq 0 ]; then
      echo "OK   :test_prepare_jmx_args_success"
   else
      echo "FAIL :test_prepare_jmx_args_success"
      exit 1
   fi
   assert_equals $JMX_ARG "$WORKSPACE_PATH/$JMETER_JMX" test_prepare_jmx_args_success
}

test_prepare_jmx_args_fail_file_notfound() {
   set +e
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_JMX=test-plann.jmx
   prepare_jmx_args 
   if [ $? -eq 1 ]; then
      echo "OK   :test_prepare_jmx_args_fail_file_notfound"
   else
      echo "FAIL :test_prepare_jmx_args_fail_file_notfound"
      exit 1
   fi

}

echo "BEGIN :  Testing prepare_jmx_args"

echo "start test_prepare_jmx_args_fail_file_notfound";
test_prepare_jmx_args_fail_file_notfound
echo "start test_prepare_jmx_args_success";
test_prepare_jmx_args_success


echo "END   :  Testing prepare_jmx_args"
