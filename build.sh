#!/bin/bash
set -e
#npm install
cd ns

#shopt -s nullglob
for OWL in  *.omn *.owl
do
	echo $OWL
	mono ../omn2ttl/omn2ttl/bin/Release/omn2ttl.exe --uri $OWL
done

cd -
