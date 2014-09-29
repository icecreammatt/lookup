docker run --restart=always \
    --cap-drop=ALL \
    --name iplookup \
    -d -p 127.0.0.1:$1:5000 -t iplookup
