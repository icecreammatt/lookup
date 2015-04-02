docker run --restart=always \
    --cap-drop=ALL \
    --name ip.mattcarrier.net \
    -d -p 127.0.0.1:$1:5000 -t icecreammatt/lookup
