#!/bin/bash

URL=https://fonts.cdnfonts.com/css/operator-mono
DIR=woff

mkdir -p ${DIR}

curl -s ${URL} \
    | grep 'https://' \
    | sed "s|.*url('\(.*\)') format.*|\1|" \
    | while read fontUrl
do
    filename=$(echo ${fontUrl} | sed 's|.*/||')
    echo "Downloading ${fontUrl} to ${DIR}/${filename}"
    wget -q "${fontUrl}" -O "${DIR}/${filename}"
done

echo
echo "Done!"
