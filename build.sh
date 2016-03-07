#!/bin/bash
set -xe

base=`pwd`

git submodule update --remote
cd $base/ld-utilities/
./build.sh
cd $base/ns

for OWL in ./{,**/}*.omn
do
	  mono $base/ld-utilities/src/omn2ttl/omn2ttl/bin/Release/omn2ttl.exe --uri $OWL
done
#fsharpi -I $base/ld-utilities ./csv2skos.fsx $base/ld-utilities
for TTL in $base/ns/{,**/}*.ttl
do
		ld=${TTL%.*}
		prefix=${ld##*/}
    java -jar ../ld-utilities/lib/owl2jsonld/owl2jsonld.jar --all-imports --prefix $prefix --output $ld.jsonld file:$TTL
done
for TTL in $base/ns/{,**/}*.ttl
do
	  java -jar ../ld-utilities/src/ComLLODE/out/artifacts/CLLODE/ComLLODE.jar $TTL
done

cd -
