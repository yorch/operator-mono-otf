#!/bin/bash

WOFF2OTF_DIR=woff2otf
WOFF_DIR=woff
OTF_DIR=otf
CMD=woff2otf/woff2otf.py

if [ ! -d ${WOFF_DIR} ]; then
    echo "Directory ${WOFF_DIR} does not exist"
    exit 1
fi

mkdir -p ${OTF_DIR}

if [ ! -d ${WOFF2OTF_DIR} ]; then
    echo "Cloning OTF conversion tool to ${WOFF2OTF_DIR}"
    git clone git@github.com:hanikesn/woff2otf.git
else
    echo "Updating OTF conversion tool in ${WOFF2OTF_DIR}"
    cd ${WOFF2OTF_DIR}
    git pull
    cd - > /dev/null
fi

echo

find ${WOFF_DIR} -type f -name "*.woff" -exec basename {} \; \
    | while read woffFile
do
    filename=$(echo ${woffFile} | sed 's|\.woff||')
    newFilename="${filename}.otf"
    echo "Converting ${woffFile} to ${newFilename}"
    ${CMD} ${WOFF_DIR}/${woffFile} ${OTF_DIR}/${woffFile}.otf
done

echo
echo "Done!"
