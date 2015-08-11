#!/bin/bash
set -xe

git submodule update --remote
cd ld-utilities/
./build.sh
cd ../ns

for OWL in ./*.omn
do
	  mono ../ld-utilities/src/omn2ttl/omn2ttl/bin/Release/omn2ttl.exe --uri $OWL
	  if [[ $OWL == *"qualitystandard"* ]]
	  then
		    qs=${OWL%.*}
        qs="$qs.ttl"
        fsharpi ../ld-utilities/src/csv2skos/csv2skos.fsx >> "$qs"
	  fi
done

for TTL in ./*.ttl
do
	  java -jar ../ld-utilities/src/ComLLODE/out/artifacts/CLLODE/ComLLODE.jar $TTL
done

cd -
