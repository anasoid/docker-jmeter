#!/bin/bash
set -e

. $(pwd)/scripts/internal/build/test/utils/tests-utils.sh
. $(pwd)/scripts/internal/jmeter-utils.sh

#test simple case with file
test_prepare_log_args_success() {
   set -e

   LOG_ARG=""
   OUTPUT_LOG_PATH=$(pwd)/jmeter/outlog
   JMETER_LOG_FILE=jmeter.log
   prepare_log_args -fdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$LOG_ARG" " --jmeterlogfile $OUTPUT_LOG_PATH/$JMETER_LOG_FILE" test_prepare_log_args_success
}

#test simple case with file
test_prepare_log_args_not_fil_default_success() {
   set -e

   LOG_ARG=""
   OUTPUT_LOG_PATH=$(pwd)/jmeter/outlog
   JMETER_LOG_FILE=jmeter.log
   prepare_log_args -j dfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$LOG_ARG" ""
}

test_prepare_log_args_not_fil_success() {
   set -e

   LOG_ARG=""
   OUTPUT_LOG_PATH=$(pwd)/jmeter/outlog
   JMETER_LOG_FILE=
   prepare_log_args -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$LOG_ARG" ""
}

#
test_prepare_log_args_fail() {
   set +e

   LOG_ARG=""
   OUTPUT_LOG_PATH=$(pwd)/jmeter/outlog
   JMETER_LOG_FILE=log.log
   prepare_log_args dfd -j ddf
   if [ $? -eq 1 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi

}

echo "BEGIN :  Testing prepare_jlog_args#########################"

echo "Start  :>>>> test_prepare_log_args_success"
test_prepare_log_args_success
echo "Finish :>>>> test_prepare_log_args_success"

echo "Start  :>>>> test_prepare_log_args_not_fil_success"
test_prepare_log_args_not_fil_success
echo "Finish :>>>> test_prepare_log_args_not_fil_success"

echo "Start  :>>>> test_prepare_log_args_not_fil_default_success"
test_prepare_log_args_not_fil_default_success
echo "Finish :>>>> test_prepare_log_args_not_fil_default_success"

echo "Start  :>>>> test_prepare_log_args_fail"
test_prepare_log_args_fail
echo "Finish :>>>> test_prepare_log_args_fail"

echo "END   :  Testing prepare_jlog_args#########################"
