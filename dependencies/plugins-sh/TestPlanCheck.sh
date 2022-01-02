#!/bin/sh

cmdrunner=$(ls $(dirname $0)/../lib/ | grep -m 1 cmdrunner-2.*.jar)
java -Djava.awt.headless=true -Dlog4j.configurationFile=$(dirname $0)/log4j2.xml -jar $(dirname $0)/../lib/$cmdrunner --tool TestPlanCheck "$@"
