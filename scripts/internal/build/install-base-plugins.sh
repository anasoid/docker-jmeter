#!/bin/bash
set -e

plancheck-download.sh
plugin-manager-download.sh
mvn-download.sh -f plugins-lib-dependencies.xml -t ${JMETER_HOME}/lib
