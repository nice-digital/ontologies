#!/bin/bash
git submodule update --remote
cd ns

for OWL in *.{omn,owl}
do
	echo $OWL
	mono ../ld-utilities/src/omn2ttl/omn2ttl/bin/Release/omn2ttl.exe --uri $OWL
	java -jar ../ld-utilities/src/ComLLODE/out/artifacts/CLLODE/ComLLODE.jar $OWL
done

cd -
