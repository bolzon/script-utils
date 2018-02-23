#!/bin/bash

echo 'Rastreando objeto "'$1'"'

OBJ_CORREIOS=$(printf 'Objetos=%s' $1)
URL_CORREIOS='http://www2.correios.com.br/sistemas/rastreamento/resultado_semcontent.cfm'

curl -s -X POST -H 'Content-type: application/x-www-form-urlencoded' -d $OBJ_CORREIOS $URL_CORREIOS > /tmp/correios.html

google-chrome /tmp/correios.html

rm /tmp/correios.html
