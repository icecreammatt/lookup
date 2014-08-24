FROM icecreammatt/golang

WORKDIR /gopath/src/github.com/icecreammatt/lookup
ADD . /gopath/src/github.com/icecreammatt/lookup/

RUN go build
RUN go install

EXPOSE 5000
CMD []
ENTRYPOINT ["/gopath/bin/lookup"]
