Data Lake workshop for Fintechs -- Instructions
===============================================

Lab Preparation
---------------

1. Run the following command after you set up the AWS CLI in your shell, you can choose to 
   use a different directory name, change the command accordingly.

        git clone https://github.com/OmarKhayyam/data-lake-ws.git && cd data-lake-ws && ./orchestrator.sh
   
   You will use the output from the cloudformation stack for the rest of these instructions. 
   You can go to the AWS Management Console and then to the Cloudformation console to look at the outputs.

2.  On the AWS Management Console proceed to the EC2 console, choose the 
    instance we just created, click the connect button, click on the session 
    manager tab, click **Connect**. A terminal session will start in your browser window.
    **Again, setup the AWS CLI environment, just the way you set it up
    in the [pre-requisities](../README.md) section in the README**.

3.  Run the following command in the Session Manager session you started
    in step 3. (*you will get the bucket name and the DB endpoint from
    the cloudformation stack output*):

        cd && sudo yum update -y && sudo yum install -y git && git clone \
        https://github.com/OmarKhayyam/data-lake-ws.git && cd \
        data-lake-ws/datagen && ./instance_setup.sh && pip3 install -r \
        ./requirements.txt && ./generatedata.py -s \
        <bucket_name> -e <aurora_db_endpoint>

4.  Open the file badworkflows.py in vi editor and change the line
    number 46 to `for userid in lines\[:4000\]:` and then run the
    following command to start the data generation:

        ./badworkflows.py -e <aurora_db_endpoint>

    This should create the initial data you need. Leave the running and
    proceed to the next step.

5. Reserved
