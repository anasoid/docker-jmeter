#!/bin/bash
set -e

. $(pwd)/scripts/internal/build/test/utils/tests-utils.sh
. $(pwd)/scripts/internal/jmeter-utils.sh

#test simple case with file
test_prepare_report_args_success() {
   set -e

   REPORT_ARG=""
   OUTPUT_REPORT_PATH=$(pwd)/jmeter/outreport
   JMETER_REPORT_NAME=dashboard
   prepare_report_args -fdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   :test_prepare_report_args_success"
   else
      echo "FAIL :test_prepare_report_args_success"
      exit 1
   fi
   assert_equals "$REPORT_ARG" " -e -o $OUTPUT_REPORT_PATH/$JMETER_REPORT_NAME" test_prepare_report_args_success
}


test_prepare_report_args_not_fil_success() {
   set -e

   REPORT_ARG=""
   OUTPUT_REPORT_PATH=$(pwd)/jmeter/outreport
   JMETER_REPORT_NAME=
   prepare_report_args -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$REPORT_ARG" ""
}

#
test_prepare_report_args_fail() {
   set +e

   REPORT_ARG=""
   OUTPUT_REPORT_PATH=$(pwd)/jmeter/outreport
   JMETER_REPORT_NAME=report.report
   prepare_report_args dfd -o ddf
   if [ $? -eq 1 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi

}

echo "BEGIN :  Testing prepare_jreport_args#########################"

echo "Start  :>>>> test_prepare_report_args_success"
test_prepare_report_args_success
echo "Finish :>>>> test_prepare_report_args_success"

echo "Start  :>>>> test_prepare_report_args_not_fil_success"
test_prepare_report_args_not_fil_success
echo "Finish :>>>> test_prepare_report_args_not_fil_success"

echo "Start  :>>>> test_prepare_report_args_fail"
test_prepare_report_args_fail
echo "Finish :>>>> test_prepare_report_args_fail"

echo "END   :  Testing prepare_jreport_args#########################"
