#!/bin/bash
cd
sudo yum -y update
sudo yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum install -y mysql-community-client
sudo yum install -y git
git clone https://github.com/OmarKhayyam/data-lake-aws.git
