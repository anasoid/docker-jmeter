#!/bin/bash
set -e

. $(pwd)/scripts/internal/build/test/utils/tests-utils.sh
. $(pwd)/scripts/internal/jmeter-utils.sh

#test simple case with fill data
test_prepare_exit_args_fill() {
   set -e

   EXIT_ARG=""
   JMETER_EXIT=""
   prepare_exit_args -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   :test_prepare_exit_args_fill"
   else
      echo "FAIL :test_prepare_exit_args_fill"
      exit 1
   fi
   assert_equals "$EXIT_ARG" ""
}

#test simple case with fill data
test_prepare_exit_args_not_fill() {
   set -e

   EXIT_ARG=""
   JMETER_EXIT="true"
   prepare_exit_args -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   :test_prepare_exit_args_not_fill"
   else
      echo "FAIL :test_prepare_exit_args_not_fill"
      exit 1
   fi
   assert_equals "$EXIT_ARG" " --remoteexit -Gjmeterengine.remote.system.exit=true -Gserver.exitaftertest=true -Gjmeterengine.force.system.exit=true "
}


echo "BEGIN :  Testing prepare_exit_args#########################"

echo "Start  :>>>> test_prepare_exit_args_fill"
test_prepare_exit_args_fill
echo "Finish :>>>> test_prepare_exit_args_fill"

echo "Start  :>>>> test_prepare_exit_args_not_fill"
test_prepare_exit_args_not_fill
echo "Finish :>>>> test_prepare_exit_args_not_fill"


echo "END   :  Testing prepare_exit_args#########################"
