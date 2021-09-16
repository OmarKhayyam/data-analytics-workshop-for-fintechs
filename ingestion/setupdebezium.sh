#!/bin/bash

caarn=$1 # This should be the Certificate Authority ARN
cd
sudo yum install -y java-1.8.0 && java -version
mkdir keys && cd keys && cp /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.302.b08-0.amzn2.0.1.x86_64/jre/lib/security/cacerts kafka.client.truststore.jks
keytool -genkey -keystore kafka.client.keystore.jks -validity 300 -storepass mystorepass123 -keypass mystorepass123 -dname "CN=workshopattendee" -alias workshopkey -storetype pkcs12
keytool -keystore kafka.client.keystore.jks -certreq -file client-cert-sign-request -alias workshopkey -storepass mystorepass123 -keypass mystorepass123
sed 's/NEW //g' client-cert-sign-request > cert.1 && rm -f client-cert-sign-request && mv cert.1 client-cert-sign-request
certarn=`aws acm-pca issue-certificate --certificate-authority-arn $caarn --csr fileb://client-cert-sign-request --signing-algorithm "SHA256WITHRSA" --validity Value=10,Type="DAYS" | python3 -c "import sys, json; print(json.dumps(json.load(sys.stdin)))"`
aws acm-pca get-certificate --certificate-authority-arn $caarn --certificate-arn $certarn | python3 -c "import sys, json; certchain = json.load(sys.stdin); print(certchain['Certificate']+"\n"); print(certchain['CertificateChain'])" | sed -e ':a;N;$!ba;s/\\n/\n/g' | tee signed-certificate-from-acm
keytool -keystore kafka.client.keystore.jks -import -file signed-certificate-from-acm -alias workshopkey -storepass mystorepass123 -keypass mystorepass123 -noprompt
echo "security.protocol=SSL" > client.properties
echo "ssl.truststore.location=$PWD/kafka.client.truststore.jks" >> client.properties
echo "ssl.keystore.location=$PWD/kafka.client.keystore.jks" >> client.properties
echo "ssl.keystore.password=mystorepass123" >> client.properties
echo "ssl.key.password=mystorepass123" >> client.properties
cd && curl -O http://packages.confluent.io/archive/6.2/confluent-6.2.0.zip && unzip confluent-6.2.0.zip && cd confluent-6.2.0
echo "Installing the MySQL connector for kafka connect.."
bin/confluent-hub install debezium/debezium-connector-mysql:latest
echo "Installing the S3 connector for kafka connect.."
bin/confluent-hub install confluentinc/kafka-connect-s3:latest
