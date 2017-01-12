

Repository for NICE ontologies. Currently served as TTL / Jsonld files by NGINX

## Setup
This git repo uses submodules so please clone down this repo using:
```
git clone --recursive https://github.com/nhsevidence/ontologies
```
or if already cloned:
```
cd $REPO_DIR
git submodule update --init --recursive
```

## Requirements
* docker

## Building
```
docker build -t ontologies .
```

## Running as a container:
```
docker run --name ontologies -d ontologies 
```
please ignore this is a test.
