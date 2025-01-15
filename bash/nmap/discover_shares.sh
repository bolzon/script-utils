#!/bin/bash

# discover enumerable shared on a network machine

cd /usr/share/nmap/scripts
nmap --script=smb-enum-shares.nse 192.168.1.102
