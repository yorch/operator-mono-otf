#!/bin/bash

REPO_URL=git@github.com:hanikesn/woff2otf.git
TOOL_DIR=tool-woff2otf
SOURCE_DIR=woff
OUTPUT_DIR=otf
CMD=tool-woff2otf/woff2otf.py

if [ ! -d ${SOURCE_DIR} ]; then
    echo "Directory ${SOURCE_DIR} does not exist"
    exit 1
fi

if [ ! -d ${TOOL_DIR} ]; then
    echo "Cloning OTF conversion tool to ${TOOL_DIR}"
    git clone ${REPO_URL} ${TOOL_DIR}
else
    echo "Updating OTF conversion tool in ${TOOL_DIR}"
    cd ${TOOL_DIR}
    git pull
    cd - > /dev/null
fi

echo

mkdir -p ${OUTPUT_DIR}

find ${SOURCE_DIR} -type f -name "*.woff" -exec basename {} \; \
    | while read woffFile
do
    filename=$(echo ${woffFile} | sed 's|\.woff||')
    newFilename="${filename}.otf"
    echo "Converting ${woffFile} to ${newFilename}"
    ${CMD} ${SOURCE_DIR}/${woffFile} ${OUTPUT_DIR}/${filename}.otf
done

echo
echo "Done!"
