#!/bin/bash

# sweep network and brings IP of connected machines
# cut command brings only the 5th column

nmap -sn -n 192.168.1.0/24 | grep 192 # | cut -d ' ' -f 5
