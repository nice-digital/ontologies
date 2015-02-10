#!/bin/bash
set -e
npm install
cd ns

shopt -s nullglob
for OWL in *.owl
do
    TTLNAME=${OWL%.*}.ttl
    echo $TTLNAME
    curl 'http://mowl-power.cs.man.ac.uk:8080/converter/convert' -H 'Accept-Encoding: gzip, deflate' --data 'ontology=@$OWL&format=Turtle' --compressed -o $TTLNAME
done

cd -
