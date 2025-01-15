#!/bin/bash
# @author Alexandre Bolzon <blzn@mail.ru>
# @date 23/02/2018

if [ -z "$1" ]; then
    echo """
    USAGE:

       $0 <object code>
"""
    exit 1
fi

echo 'Rastreando objeto "'$1'"'

FILE_CORREIOS=/tmp/correios.html
OBJ_CORREIOS=$(printf 'Objetos=%s' $1)
URL_CORREIOS='http://www2.correios.com.br/sistemas/rastreamento/resultado_semcontent.cfm'

curl -s -X POST -H 'Content-type: application/x-www-form-urlencoded' -d $OBJ_CORREIOS $URL_CORREIOS > $FILE_CORREIOS

google-chrome $FILE_CORREIOS
rm $FILE_CORREIOS
