#!/bin/sh
export COMMIT_ID=`cat build_version.txt` 
echo $COMMIT_ID 
until docker ps 
do 
    sleep 3 
done 
cd orc8r/cloud/docker 
./build.py -a 
# For v1.1.0
# export MAGMA_VERSION=v1.1.0
# For v2.0.0
export MAGMA_VERSION=v2.0.0

export MAGMA_TAG=$MAGMA_VERSION-$COMMIT_ID 
echo $MAGMA_TAG 
export REGISTRY=docker-registry:5000
# For v1.1.0
# for image in proxy controller prometheus-cache alertmanager-configurer prometheus-configurer grafana 
# For v2.0.0
for image in nginx controller fluentd cache test
do 
    ../../../orc8r/tools/docker/publish.sh -r $REGISTRY -i $image -v $MAGMA_TAG
done 
# For v1.1.0
# cd ../../../symphony/app/fbcnms-projects/magmalte 
# For v2.0.0
cd ../../../nms/app/packages/magmalte
docker-compose build magmalte 
COMPOSE_PROJECT_NAME=magmalte ../../../../orc8r/tools/docker/publish.sh -r $REGISTRY -i magmalte -v $MAGMA_TAG
