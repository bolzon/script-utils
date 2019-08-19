#!/bin/bash

keytool -export -alias myalias -file mycert.der -keystore mykeystore.jks
openssl x509 -in mycert.der -inform der -noout -text

