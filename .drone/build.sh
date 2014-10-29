#!/bin/bash
set -e
ls -R /var/cache/drone/src
cd /var/cache/drone/src/github.com/icecreammatt/lookup

echo $DOCKERHUB_USERNAME
docker login --username="$DOCKERHUB_USERNAME" --password="$DOCKERHUB_PASSWORD"

go build
go test


status=$?
if [ $status -ne 0 ]
then
    exit $status
fi

./wrapdocker &
sleep 5

docker build -t icecreammatt/lookup .
docker push icecreammatt/lookup
