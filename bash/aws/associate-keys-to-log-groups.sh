#!/bin/bash

if [ -z "$1" ]; then
    echo """
    USAGE:

        $0 [KMS_ARN]

    KMS_ARN - AWS resource identifier (e.g. arn:aws:kms:<region>:<account id>:key/<key id>)
"""
    exit 1
fi

KMS_ARN=$1

# this filters log groups that don't have it configured
log_groups=$(aws logs describe-log-groups | jq '.logGroups[] | select(.kmsKeyId == null)' | jq -r .logGroupName)

for lg in $log_groups; do
    echo $lg
    aws logs associate-kms-key --log-group-name "$lg" --kms-key-id "$KMS_ARN"
done
