#!/bin/bash
set -e
ls -R /var/cache/drone/src
cd /var/cache/drone/src/ci.mattcarrier.net/icecreammatt/lookup
#cd /gopath/src/github.com/icecreammatt/lookup

go build
go test

status=$?
if [ $status -ne 0 ]
then
    exit $status
fi

wrapdocker &
sleep 5

docker build -t icecreammatt/lookup .
docker push icecreammatt/lookup
