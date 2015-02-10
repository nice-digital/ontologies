#!/bin/bash
cd ns

for fn in *.owl
do
ttlname = $(basename $fn .ttl)
curl 'http://mowl-power.cs.man.ac.uk:8080/converter/convert' -H 'Accept-Encoding: gzip, deflate' --data 'ontology=@fn&format=Turtle' --compressed -o ttlname
done

cd -
