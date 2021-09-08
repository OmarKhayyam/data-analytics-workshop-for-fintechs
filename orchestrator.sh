#!/bin/bash

## Instantiate CF Template
aws cloudformation create-stack --stack-name datagenstack --template-body file://$PWD/datagen/DataLakeLabPrep.yml --capabilities CAPABILITY_NAMED_IAM

aws cloudformation wait stack-create-complete --stack-name datagenstack

s3bucketname=`aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.load(sys.stdin)['Stacks'][0]['Outputs'][0]['OutputValue'])"`

ec2instance=`aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.load(sys.stdin)['Stacks'][0]['Outputs'][1]['OutputValue'])"`

echo $s3bucketname $ec2instance

aws ssm send-command --instance-ids "$ec2instance" --document-name "AWS-RunShellScript" --comment "Git clone repo" --parameters 'commands=["cd /home/ec2-user","git clone https://github.com/OmarKhayyam/data-lake-aws.git"]'
