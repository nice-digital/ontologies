#!/bin/bash

docker build -t nice/ontologies .
docker run -v $(pwd):/ontologies -it nice/ld-docker-build sh -c "cd /ontologies;./build.sh"
cp -R ns contentlayer/
docker build -t nice/ontologies ./contentlayer/
rm -rf contentlayer/ns
docker push nice/ontologies
