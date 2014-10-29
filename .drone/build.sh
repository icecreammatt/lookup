#!/bin/bash
set -e
ls -R /var/cache/drone/src
cd /var/cache/drone/src/github.com/icecreammatt/lookup

go build
go test

echo $DOCKERHUB_USERNAME

status=$?
if [ $status -ne 0 ]
then
    exit $status
fi

./wrapdocker &
sleep 5

docker build -t icecreammatt/lookup .

docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD
docker push icecreammatt/lookup
