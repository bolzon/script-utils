#!/bin/bash

# prints the db names from mongodb

echo 'show dbs' | mongo --quiet | grep -E '^\w+' -o -s
