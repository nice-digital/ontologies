#!/bin/bash
set -xe

base=`pwd`

#git submodule update --remote
cd $base/ld-utilities/
./build.sh
cd $base/ns

for TTL in $base/ns/*.ttl
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
