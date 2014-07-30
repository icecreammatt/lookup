FROM ubuntu:14.04
MAINTAINER Matt Carrier

RUN apt-get update
RUN apt-get install -y curl git bzr mercurial

RUN curl -s https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz | tar -v -C /usr/local/ -xz

ENV PATH  /usr/local/go/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
ENV GOPATH  /go
ENV GOROOT  /usr/local/go

WORKDIR /go/src/github.com/icecreammatt/lookup
ADD . /go/src/github.com/icecreammatt/lookup
RUN go get
RUN go build

EXPOSE 5000

ENTRYPOINT ./lookup
