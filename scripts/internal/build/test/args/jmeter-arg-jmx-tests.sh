#!/bin/bash
set -e

. $(pwd)/scripts/internal/build/test/utils/tests-utils.sh
. $(pwd)/scripts/internal/jmeter-utils.sh



#test simple case with file
test_prepare_jmx_args_success() {
   set -e

   JMX_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_JMX=test-plan.jmx
   prepare_jmx_args -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   :test_prepare_jmx_args_success"
   else
      echo "FAIL :test_prepare_jmx_args_success"
      exit 1
   fi
   assert_equals "$JMX_ARG" " -t $WORKSPACE_PATH/$JMETER_JMX" test_prepare_jmx_args_success
}

#test given file not found.
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

#test success case from args.
test_prepare_jmx_args_success_from_args() {
   set -e

   JMX_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_JMX=
   prepare_jmx_args " -t $WORKSPACE_PATH/test-plan.jmx"
   if [ $? -eq 0 ]; then
      echo "OK   :test_prepare_jmx_args_success_from_args"
   else
      echo "FAIL :test_prepare_jmx_args_success_from_args"
      exit 1
   fi
   assert_equals "$JMX_ARG" "" test_prepare_jmx_args_success
}


#Missng jmx file config.
test_prepare_jmx_args_fail_duplicate_config() {
   set +e

   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_JMX="test-plan.jmx"

   prepare_jmx_args -t gddgd
   if [ $? -eq 1 ]; then
      echo "OK   :test_prepare_jmx_args_fail_duplicate_config"
   else
      echo "FAIL :test_prepare_jmx_args_fail_duplicate_config"
      exit 1
   fi
}

echo "BEGIN :  Testing prepare_jmx_args#########################"

echo "Start  :>>>> test_prepare_jmx_args_fail_file_notfound"
test_prepare_jmx_args_fail_file_notfound
echo "Finish :>>>> test_prepare_jmx_args_fail_file_notfound"

echo "Start  :>>>> test_prepare_jmx_args_success"
test_prepare_jmx_args_success
echo "Finish :>>>> test_prepare_jmx_args_success"

echo "Start  :>>>> test_prepare_jmx_args_success_from_args"
test_prepare_jmx_args_success_from_args
echo "Finish :>>>> test_prepare_jmx_args_success_from_args"

echo "Start  :>>>> test_prepare_jmx_args_fail_duplicate_config"
test_prepare_jmx_args_fail_duplicate_config
echo "Finish :>>>> test_prepare_jmx_args_fail_duplicate_config"


echo "END   :  Testing prepare_jmx_args#########################"
