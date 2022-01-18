#!/bin/bash
set -e

export WORKSPACE_PATH=${PROJECT_PATH}

if [ "$CONF_COPY_TO_WORKSPACE" == "true" ]; then
    rm -rf WORKSPACE_TARGET
    mkdir $WORKSPACE_TARGET
    export WORKSPACE_PATH=${WORKSPACE_TARGET}
    cp -rv "$PROJECT_PATH"/. $WORKSPACE_PATH
fi

cd $WORKSPACE_PATH
echo "Using WORKSPACE  folder ($WORKSPACE_PATH ) "
