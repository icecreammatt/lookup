// Matt Carrier 2014
// Client IP Lookup
// lookup <PORT>

package main

import (
    "fmt"
    "net/http"
    "os"
    "strings"
)

type IpPong struct {}

func (ipPong IpPong) ServeHTTP(w http.ResponseWriter, r *http.Request) {
    ipAddress := r.Header.Get("X-Real-IP")
    if ipAddress == "" {
        ipAddress = strings.Split(r.RemoteAddr, ":")[0]
    }
    fmt.Fprint(w, ipAddress)
}

func readPort(args []string) string {
    port := "5000"
    if len(args) > 1 {
        port = args[1]
    }
    fmt.Printf("Starting server on port %s\n", port)
    return port
}

func main() {
    var ipResponse IpPong
    port := readPort(os.Args)
    serve := "localhost:" + port
    http.ListenAndServe(serve, ipResponse)
}
