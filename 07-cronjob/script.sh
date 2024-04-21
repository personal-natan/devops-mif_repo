#!/bin/bash

export AWS_ACCESS_KEY_ID="access_keyid"
export AWS_SECRET_ACCESS_KEY="secret_keyid"
export AWS_DEFAULT_REGION="default_region"

aws s3 cp s3://s3-ec2-init/backup.zip /mnt/backup/
