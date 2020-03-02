#!/usr/bin/env python3.7

''' 
This script deals with this terraform error: 
Error: error deleting S3 Bucket (terraform-up-and-running-state-26022020): BucketNotEmpty:
The bucket you tried to delete is not empty. You must delete all versions in the bucket.
'''

import boto3


BUCKET = 'terraform-up-and-running-state-26022020'

s3 = boto3.resource('s3')
bucket = s3.Bucket(BUCKET)
bucket.object_versions.delete()

# if you want to delete the now-empty bucket as well, uncomment this line:
bucket.delete()
