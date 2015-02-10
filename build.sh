#!/bin/bash
git submodule update --remote
cd ld-utilities/
./build.sh
cd ../ns

for OWL in *.omn
do
	  mono ../ld-utilities/src/omn2ttl/omn2ttl/bin/Release/omn2ttl.exe --uri $OWL
	  if [[ $OWL == *"qualitystandard"* ]]
	  then
		    qs=${OWL%.*}
        qs="$qs.ttl"
		    for csv in ../skoscsv/*.csv
		    do
            concept=""
            if [[ $csv == *"Settings"* ]]
            then
                concept="qs:Setting"
            else
                concept="qs:PopulationSpecifier"
            fi
			         fPath=`pwd`
			         fPath="$fPath/$csv"
			         ttl=${fPath%.*}
			         ttl="$ttl.ttl"
			         mono ../ld-utilities/src/csv2skos/csv2skos/bin/Release/csv2skos.exe --uri "$fPath" --baseconcept $concept
			         cat "$ttl" >> "$qs"
		    done
	  fi
	  java -jar ../ld-utilities/src/ComLLODE/out/artifacts/CLLODE/ComLLODE.jar $OWL
done

cd -
