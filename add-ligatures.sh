#!/bin/bash

REPO_URL=git@github.com:drod3763/kiliman-operator-mono-lig-docker.git
TOOL_DIR=tool-ligatures
SOURCE_DIR=otf
OUTPUT_DIR=otf-with-ligatures
CMD=woff2otf/woff2otf.py

if [ ! -d ${SOURCE_DIR} ]; then
    echo "Directory ${SOURCE_DIR} does not exist"
    exit 1
fi

if [ ! -d ${TOOL_DIR} ]; then
    echo "Cloning ligatures tool to ${TOOL_DIR}"
    git clone ${REPO_URL} ${TOOL_DIR}
else
    echo "Updating ligatures tool in ${TOOL_DIR}"
    cd ${TOOL_DIR}
    git pull
    cd - > /dev/null
fi

echo

mkdir -p ${OUTPUT_DIR}

cp -p ${SOURCE_DIR}/*.otf ${TOOL_DIR}/input

docker-compose -f ${TOOL_DIR}/docker-compose.yaml run --rm operator-mono-lig

cp -p ${TOOL_DIR}/build/*.otf ${OUTPUT_DIR}

echo
echo "Done!"
