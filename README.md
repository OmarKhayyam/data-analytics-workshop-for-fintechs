# Analytics Workshop
The intent of this workshop is to take the participants through a process of building a complete pipeline. 
Starting from ingesting the data. Processing it, and finally consuming the data.

## Brief
The workshop takes you through 3 labs and a preparatory section. The preparatory section creates fake data
that the workshop participant can use to populate an Amazon Aurora MySQL database. As records are added,
the particpants moves on to the next lab. To access the labs navigate to the `instructions` directory in 
this repository.

**Note: While copying commands from workshop instructions, make sure you remove all newlines from the commands

Before you begin, you should have the AWS CLI installed ([instructions for AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)), you should clone this repo, 
here, we assume you can choose to use a different directory name, change the command accordingly.

    git clone https://github.com/OmarKhayyam/data-lake-ws.git && cd data-lake-ws && ./orchestrator.sh

### Lab 0
The participants will create the initial setup that will generate the data for them for the rest of this
workshop. Instructions for **Lab 0** [available here](https://github.com/OmarKhayyam/data-lake-ws/blob/master/instructions/Lab%200%20-%20Prep%20for%20Data%20Lake%20Workshop%20for%20Fintechs%20V2.md).

### Lab 1
Here, the particpant sets up ingestion to move transactional data from the database to a Kinesis Data stream.
Instructions for **Lab 1** [available here](https://github.com/OmarKhayyam/data-lake-ws/blob/master/instructions/Lab%201%20-%20Data%20Lake%20Workshop%20for%20Fintechs%20V2.md).

### Lab 2
In this lab the participant moves to the next stage, where the data is cataloged. This process is run on a
continuous basis as the changes keep streaming in. Instructions for **Lab 2** [available here](https://github.com/OmarKhayyam/data-lake-ws/blob/master/instructions/Lab%202%20-%20Data%20Lake%20Workshop%20for%20Fintechs%20V2.md).

### Lab 3
Finally, this lab demonstrates how easy it is to setup Amazon Athena and Amazon Redshift to query the data. 
Instructions for **Lab 3** [available here](https://github.com/OmarKhayyam/data-lake-ws/blob/master/instructions/Lab%203%20-%20Data%20Lake%20Workshop%20for%20Fintechs%20V2.md).

