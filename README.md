# Analytics Workshop
The intent of this workshop is to take the participants through a process of building a complete pipeline. 
Starting from ingesting the data. Processing it, and finally consuming the data.

## Brief
The workshop takes you through 3 labs and a preparatory section. The preparatory section creates fake data
that the workshop participant can use to populate an Amazon Aurora MySQL database. As records are added,
the particpants moves on to the next lab. To access the labs navigate to the `instructions` directory in 
this repository.

### Lab 1
Here, the particpant sets up ingestion to move transactional data from the database to a Kinesis Data stream.

### Lab 2
In this lab the participant moves to the next stage, where the data is cataloged. This process is run on a
continuous basis as the changes keep streaming in.

### Lab 3
Finally, this lab demonstrates how easy it is to setup Amazon Athena and Amazon Redshift to query the data. 

