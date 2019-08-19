#!/bin/bash

# exports certificate
keytool -exportcert -keystore mykeystore.jks -alias myalias -file mycert.der

# exports private keys (needs password)
keytool -importkeystore -srckeystore mykeystore.jks -destkeystore mycert.p12 -deststoretype pkcs12
