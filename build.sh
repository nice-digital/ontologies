#!/bin/bash
set -xe

base=`pwd`

git submodule update --remote
cd $base/ld-utilities/
./build.sh
cd $base/ns

for OWL in ./*.omn
do
	  mono $base/ld-utilities/src/omn2ttl/omn2ttl/bin/Release/omn2ttl.exe --uri $OWL
	  if [[ $OWL == *"qualitystandard"* ]]
	  then
		    qs=${OWL%.*}
        qs="$qs.ttl"
        cd $base/ld-utilities/src/csv2skos/
        fsharpi csv2skos.fsx >> $base/ns/$qs
        cd -
	  fi
done

for TTL in $base/ns/*.ttl
do
	  java -jar ../ld-utilities/src/ComLLODE/out/artifacts/CLLODE/ComLLODE.jar $TTL
done

cd -
