package main

import (
    "testing"
    "net/http"
    "io/ioutil"
    "strings"
)

func TestMain(t *testing.T) {
    go main()

    resp, err := http.Get("http://localhost:5000")
    if err != nil {
        t.Errorf("Request Failed")
        t.FailNow()
    }
    defer resp.Body.Close()

    response, err := ioutil.ReadAll(resp.Body)
    ipString := strings.Split(string(response), ":")
    if len(ipString) > 0 {
        if ipString[0] != "127.0.0.1" {
            t.Errorf("Response did not match\nValue: %s", response)
        }
    } else {
        t.Errorf("Response did not include port value %s", response)
    }
}

func TestReadPort(t *testing.T) {
    args := []string {"lookup"}
    if readPort(args) != "5000" {
        t.Errorf("Port does not match 5000")
    }

    args = []string {"lookup", "3002"}
    if readPort(args) != "3002" {
        t.Errorf("Port does not match 3002")
    }

    args = []string {}
    if readPort(args) != "5000" {
        t.Errorf("Port does not match 5000")
    }
}
