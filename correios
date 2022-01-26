#!/bin/bash

#
# USAGE
#   sh correios.sh <object code>
#
# @author Alexandre Bolzon <blzn@mail.ru>
# @date 2018/02/23
#

echo 'Rastreando objeto "'$1'"'

FILE_CORREIOS=/tmp/correios.html
OBJ_CORREIOS=$(printf 'Objetos=%s' $1)
URL_CORREIOS='http://www2.correios.com.br/sistemas/rastreamento/resultado_semcontent.cfm'

curl -s -X POST -H 'Content-type: application/x-www-form-urlencoded' -d $OBJ_CORREIOS $URL_CORREIOS > $FILE_CORREIOS

google-chrome $FILE_CORREIOS
rm $FILE_CORREIOS
