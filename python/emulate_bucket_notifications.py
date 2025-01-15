#!/bin/python3

import json
import os
import sys
from datetime import datetime

import boto3

QUEUE_URL = os.environ['QUEUE_URL']

s3_resource = boto3.resource('s3')
sqs_client = boto3.client('sqs')


def build_bucket_notification(bucket_name: str, key: str, size: int) -> str:
    return json.dumps({
        'Records': [
            {
                "eventSource": "aws:s3",
                "eventTime": datetime.now().isoformat(),
                "s3": {
                    "s3SchemaVersion": "1.0",
                    "configurationId": "manual-trigger",
                    "bucket": {
                        "name": bucket_name,
                        "arn": f"arn:aws:s3:::{bucket_name}",
                    },
                    "object": {
                        "key": key,
                        "size": size,
                    },
                },
            },
        ],
    })


def send_bucket_notification(bucket_name: str, key: str, size: int) -> None:
    sqs_client.send_message(
        QueueUrl=QUEUE_URL,
        MessageBody=build_bucket_notification(bucket_name, key, size),
    )


def trigger_job(bucket_name: str, keys: list[str]) -> None:

    if keys:
        for key in keys:
            obj = s3_resource.Object(bucket_name, key)
            size = obj.content_length

            print(f'- {key} ({size})')
            send_bucket_notification(bucket_name, key, size)
    else:
        idx = 1
        bucket = s3_resource.Bucket(bucket_name)
        for obj in bucket.objects.all():
            if obj.key.endswith('.MP4'):
                print(f'- [{idx:04d}] {obj.key} ({obj.size})')
                send_bucket_notification(bucket_name, obj.key, obj.size)
                idx += 1


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print()
        print(f'USAGE:   {sys.argv[0]} [BUCKET_NAME] [[KEY_1] [KEY_2] ... [KEY_N]]')
        print()
        print('Do not forget to export the queue URL')
        print('         export QUEUE_URL=https://sqs.eu-west-1.amazonaws.com/000000000000/queue-name')
        print()
        print('If no [KEY_n] is specified, all objects from that bucket will send a notification to the queue.')
        print()
        sys.exit(1)

    bucket_name = sys.argv[1]
    print(f'Bucket: {bucket_name}')

    keys = None
    if len(sys.argv) > 2:
        keys = sys.argv[2:]
    else:
        print('Will send all bucket objects')

    trigger_job(bucket_name=bucket_name, keys=keys)
