#!/bin/bash
set -e

. $(pwd)/scripts/internal/build/test/utils/tests-utils.sh
. $(pwd)/scripts/internal/jmeter-utils.sh

#test simple case with file
test_prepare_properties_args_success() {
   set -e

   PROPERTIES_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_PROPERTIES_FILES=jmeter.properties
   prepare_additional_file_properties -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$PROPERTIES_ARG" " -q $WORKSPACE_PATH/jmeter.properties "
}
#test simple case with file
test_prepare_properties_args_success_user() {
   set -e

   PROPERTIES_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   USER_PATH=$(pwd)/tests/users/user1
   JMETER_PROPERTIES_FILES=jmeter.properties
   prepare_additional_file_properties -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$PROPERTIES_ARG" " -q $USER_PATH/jmeter.properties -q $WORKSPACE_PATH/jmeter.properties "
   USER_PATH=""
}

test_prepare_properties_args_with_default_file_success() {
   set -e

   PROPERTIES_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/
   USER_PATH=$(pwd)/tests/
   JMETER_PROPERTIES_FILES=jmeter.properties
   prepare_additional_file_properties -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$PROPERTIES_ARG" " "
}

test_prepare_properties_args_withoutfile_success() {
   set -e

   PROPERTIES_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_PROPERTIES_FILES=
   prepare_additional_file_properties -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$PROPERTIES_ARG" ""
}

test_prepare_properties_args_multi_file_success() {
   set -e

   PROPERTIES_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_PROPERTIES_FILES="jmeter.properties jmeter.properties"
   prepare_additional_file_properties -jfdfdfdfd dfd-tfd
   if [ $? -eq 0 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
   assert_equals "$PROPERTIES_ARG" " -q $WORKSPACE_PATH/jmeter.properties -q $WORKSPACE_PATH/jmeter.properties "
}

#test given file not found.
test_prepare_properties_args_fail_file_notfound() {
   set +e

   PROPERTIES_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_PROPERTIES_FILES=not.properties

   prepare_additional_file_properties -jfdfdfdfd dfd-tfd

   if [ $? -eq 1 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
}

#test given file not found.
test_prepare_properties_args_fail_file_format() {
   set +e

   PROPERTIES_ARG=""
   WORKSPACE_PATH=$(pwd)/tests/projects/sample1
   JMETER_PROPERTIES_FILES=test-plan.jmx

   prepare_additional_file_properties -jfdfdfdfd dfd-tfd

   if [ $? -eq 1 ]; then
      echo "OK   "
   else
      echo "FAIL "
      exit 1
   fi
}

echo "BEGIN :  Testing prepare_properties_args#########################"

echo "Start  :>>>> test_prepare_properties_args_success"
test_prepare_properties_args_success
echo "Finish :>>>> test_prepare_properties_args_success"

echo "Start  :>>>> test_prepare_properties_args_success"
test_prepare_properties_args_success_user
echo "Finish :>>>> test_prepare_properties_args_success_user"

echo "Start  :>>>> test_prepare_properties_args_with_default_file_success"
test_prepare_properties_args_with_default_file_success
echo "Finish :>>>> test_prepare_properties_args_with_default_file_success"

echo "Start  :>>>> test_prepare_properties_args_withoutfile_success"
test_prepare_properties_args_withoutfile_success
echo "Finish :>>>> test_prepare_properties_args_withoutfile_success"

echo "Start  :>>>> test_prepare_properties_args_multi_file_success"
test_prepare_properties_args_multi_file_success
echo "Finish :>>>> test_prepare_properties_args_multi_file_success"

echo "Start  :>>>> test_prepare_properties_args_fail_file_notfound"
test_prepare_properties_args_fail_file_notfound
echo "Finish :>>>> test_prepare_properties_args_fail_file_notfound"

echo "Start  :>>>> test_prepare_properties_args_fail_file_format"
test_prepare_properties_args_fail_file_format
echo "Finish :>>>> test_prepare_properties_args_fail_file_format"



echo "END   :  Testing prepare_jproperties_args#########################"
