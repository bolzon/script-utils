#!/bin/bash

aws lambda list-functions | jq -r --arg CURRENTFUNCTION "$1" '.Functions[] | select(.FunctionName==$CURRENTFUNCTION) | .FunctionArn'
