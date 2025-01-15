#!/bin/python3

import sys

import boto3


def delete_obj(bucket_name: str, key: str) -> None:
    s3_resource = boto3.resource('s3')
    bucket = s3_resource.Bucket(bucket_name)
    try:
        # bucket.object_versions.all().delete()
        bucket.object_versions.filter(Prefix=key).delete()
    except Exception as e:
        print(e)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print()
        print(f'USAGE:   {sys.argv[0]} [BUCKET_NAME] [KEY_1]')
        print()
        sys.exit(1)

    bucket_name = sys.argv[1]
    print(f'Bucket: {bucket_name}')

    key = sys.argv[2]
    delete_obj(bucket_name, key)
