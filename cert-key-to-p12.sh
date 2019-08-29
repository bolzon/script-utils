#!/bin/bash

# converts a certificate + pvt key to a PKCS12 (p12) file
openssl pkcs12 -export -out cert.p12 -inkey my.key -in cert.pem -nodes
