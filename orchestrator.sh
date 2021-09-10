#!/bin/bash

## Instantiate CF Template
aws cloudformation create-stack --stack-name datagenstack --template-body file://$PWD/datagen/DataLakeLabPrep.yml --capabilities CAPABILITY_NAMED_IAM

aws cloudformation wait stack-create-complete --stack-name datagenstack

aws cloudformation describe-stacks --stack-name datagenstack | python3 -c "import sys, json; print(json.dumps(json.load(sys.stdin)['Stacks'][0]['Outputs'], indent = 3))"
