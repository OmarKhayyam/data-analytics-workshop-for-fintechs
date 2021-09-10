#!/bin/bash

## Instantiate CF Template
aws cloudformation create-stack --stack-name datagenstack --template-body file://$PWD/datagen/DataLakeLabPrep_V2.yml --capabilities CAPABILITY_NAMED_IAM

aws cloudformation wait stack-create-complete --stack-name datagenstack

counter=0

while [ $counter -lt 3 ]
do
	if [`aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.load(sys.stdin)['Stacks'][0]['Outputs'][$counter]['OutputKey'])"` == "SourceAndDataBucket"]
	then
		s3bucketname=`aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.load(sys.stdin)['Stacks'][0]['Outputs'][$counter]['OutputValue'])"`
	elif [`aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.load(sys.stdin)['Stacks'][0]['Outputs'][$counter]['OutputKey'])"` == "DBEndpoint"]
	then
		dbep=`aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.load(sys.stdin)['Stacks'][0]['Outputs'][$counter]['OutputValue'])"`
	else
		ec2instance=`aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.load(sys.stdin)['Stacks'][0]['Outputs'][$counter]['OutputValue'])"`
	fi
	counter=$counter+1
done

echo "S3 Bucket: "$s3bucketname 
echo "EC2 Instance Id: "$ec2instance
echo "Database Endpoint: "$dbep

