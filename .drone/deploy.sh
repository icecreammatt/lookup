#!/bin/bash
set -e  
docker pull icecreammatt/lookup  
docker stop lookup
docker rm lookup  
docker run -d -p :5000 -e VIRTUAL_HOST=ip.mattcarrier.net --name iplookup icecreammatt/lookup
