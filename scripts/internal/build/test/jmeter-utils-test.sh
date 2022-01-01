#!/bin/bash
set -e

. $(pwd)/scripts/internal/build/test/args/jmeter-arg-jmx-tests.sh
. $(pwd)/scripts/internal/build/test/args/jmeter-arg-exit-tests.sh
. $(pwd)/scripts/internal/build/test/args/jmeter-arg-jtl-tests.sh
. $(pwd)/scripts/internal/build/test/args/jmeter-arg-log-tests.sh
. $(pwd)/scripts/internal/build/test/args/jmeter-arg-properties-tests.sh
. $(pwd)/scripts/internal/build/test/args/jmeter-arg-report-tests.sh

set -e
