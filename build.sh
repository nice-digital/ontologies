#!/bin/bash
npm install
cd ns

for OWL in *.{omn,owl}
do
	echo $OWL
	mono ../omn2ttl/omn2ttl/bin/Release/omn2ttl.exe --uri $OWL
	java -jar ../CLLODE/CLLODE.jar $OWL
done

cd -
