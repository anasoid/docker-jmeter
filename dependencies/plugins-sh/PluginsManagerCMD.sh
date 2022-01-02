#!/bin/sh

cmdrunner=$(ls $(dirname $0)/../lib/ | grep -m 1 cmdrunner-2.*.jar)
java -Djava.awt.headless=true $JVM_ARGS -jar $(dirname $0)/../lib/$cmdrunner --tool org.jmeterplugins.repository.PluginManagerCMD "$@"
