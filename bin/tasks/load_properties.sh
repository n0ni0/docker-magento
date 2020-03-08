#!/bin/bash

set -a # Enable export all variables

source ${PROPERTIES_DIR}/colors

ROOT_DIR=$PWD

for PROPERTIES_ROOT_DIR in ${ROOT_DIR} ${ROOT_DIR}/.. ${ROOT_DIR}/../..
do
    CUSTOM_PROPERTIES=${PROPERTIES_ROOT_DIR}/properties
    if [ -f ${CUSTOM_PROPERTIES} ]; then
        source ${CUSTOM_PROPERTIES}
    fi
done

set +a # Disable export all variables
