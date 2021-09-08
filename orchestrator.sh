#!/bin/bash

## Instantiate CF Template
aws cloudformation create-stack --stack-name datagenstack --template-body file://$PWD/datagen/DataLakeLabPrep.yml --capabilities CAPABILITY_NAMED_IAM

aws cloudformation wait stack-create-complete --stack-name datagenstack

s3bucketname=`aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.load(sys.stdin)['Stacks'][0]['Outputs'][0]['OutputValue'])"`

ec2instance=`aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.load(sys.stdin)['Stacks'][0]['Outputs'][1]['OutputValue'])"`

echo "S3 Bucket: "$s3bucketname" EC2 Instance Id: "$ec2instance

