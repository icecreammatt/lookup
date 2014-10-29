FROM icecreammatt/golang

RUN apt-get install -y apparmor  
RUN curl -s https://get.docker.io/ubuntu/ | sudo sh
ADD wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

WORKDIR /gopath/src/github.com/icecreammatt/lookup
ADD . /gopath/src/github.com/icecreammatt/lookup/
RUN go get github.com/icecreammatt/lookup

RUN go build
RUN go install

EXPOSE 5000
CMD []
ENTRYPOINT ["/gopath/bin/lookup"]
