#!/bin/bash
set -e

. $(pwd)/scripts/internal/build/test/utils/tests-utils.sh
. $(pwd)/scripts/internal/jmeter-utils.sh

#test simple case with file
test_prepare_jtl_args_success() {
   set -e

   JTL_ARG=""
   OUTPUT_JTL_PATH=$(pwd)/jmeter/outjtl
   JMETER_JTL_FILE=result.jtl
   prepare_JTL_args -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$JTL_ARG" " -l $OUTPUT_JTL_PATH/$JMETER_JTL_FILE" test_prepare_jtl_args_success
}

test_prepare_jtl_args_not_fil_success() {
   set -e

   JTL_ARG=""
   OUTPUT_JTL_PATH=$(pwd)/jmeter/outjtl
   JMETER_JTL_FILE=
   prepare_JTL_args -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$JTL_ARG" ""
}

#
test_prepare_jtl_args_fail() {
   set +e

   JTL_ARG=""
   OUTPUT_JTL_PATH=$(pwd)/jmeter/outjtl
   JMETER_JTL_FILE=result.jtl
   prepare_JTL_args dfd -l ddf
   if [ $? -eq 1 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi

}

echo "BEGIN :  Testing prepare_jjtl_args#########################"

echo "Start  :>>>> test_prepare_jtl_args_success"
test_prepare_jtl_args_success
echo "Finish :>>>> test_prepare_jtl_args_success"

echo "Start  :>>>> test_prepare_jtl_args_not_fil_success"
test_prepare_jtl_args_not_fil_success
echo "Finish :>>>> test_prepare_jtl_args_not_fil_success"

echo "Start  :>>>> test_prepare_jtl_args_fail"
test_prepare_jtl_args_fail
echo "Finish :>>>> test_prepare_jtl_args_fail"

echo "END   :  Testing prepare_jjtl_args#########################"
