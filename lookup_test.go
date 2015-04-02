package main

import (
	"io/ioutil"
	"net/http"
	"strings"
	"testing"
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
		if ipString[0] != "127.0.0.1\n" {
			t.Errorf("Response did not match\nValue: %s", response)
		}
	} else {
		t.Errorf("Response did not include port value %s", response)
	}

	resp, err = http.Get("http://localhost:5000/user-agent")
	if err != nil {
		t.Errorf("Request Failed")
		t.FailNow()
	}
	defer resp.Body.Close()

	response, err = ioutil.ReadAll(resp.Body)
	userAgent := string(response)
	expected := "Go 1.1 package http\n"
	if userAgent != expected {
		t.Errorf("User Agent did not match expected value:%s:", response)
	}
}

func TestReadPort(t *testing.T) {
	args := []string{"lookup"}
	if readPort(args) != "5000" {
		t.Errorf("Port does not match 5000")
	}

	args = []string{"lookup", "3002"}
	if readPort(args) != "3002" {
		t.Errorf("Port does not match 3002")
	}

	args = []string{}
	if readPort(args) != "5000" {
		t.Errorf("Port does not match 5000")
	}
}
