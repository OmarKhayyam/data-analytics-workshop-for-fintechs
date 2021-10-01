Data Lake workshop for Fintechs -- Instructions
===============================================

Lab 3 - Consumption
-------------------

36. **\[Takes time\]** Click **Crawlers** under **Data catalog** in the
    left panel of the Glue management console. Click on the **Add
    crawler button,** on the next page give the crawler a name,
    uncollapse **Tags, description, security configuration, and
    classifiers**. Choose the security configuration we created, and
    click **Next**. On the **Specify crawler source type** page choose
    **Existing catalog tables** and click **Next**. On the **Choose
    catalog tables** page, click **Add** for the destination table we
    created in step 27 and click **Next**. On the **Choose an IAM role**
    page, choose **Choose an existing IAM role**. From the drop-down
    choose the role with the name containing the string **WSGlueRole**
    and click **Next**. Finally, on the **Create a schedule for this
    crawler** page, from the drop-down choose **Custom** and provide a
    cron expression according to your latency needs. Something like the
    following expression will run this every 5 minutes every day.

    0/5 \* \* \* ? \*

    Click **Next**. On the next page i.e. **Configure the crawler's
    output**, leave everything as-is, just click **Next**. Finally,
    review and **Finish**.

37. You can test this through Amazon Athena. Go to the Athena console,
    navigate to the **Query Editor.** Make sure you have Athena Query
    output location setup. After setting up the output location you can
    try the following query,

    select count(\*) as TotalNumberOfEntries from
    datalakeworkshopdb.customerrequests\_destination;

    You can try other queries of your choice, to see how long it takes
    for an entry to reach your data lake, try this. **\[Takes time\]**
    Go to the Session Manager session that is pumping data into the data
    source, copy the last userid that is inserted, and run the following
    query repeatedly,

    select \* from datalakeworkshopdb.customerrequests\_destination
    where user\_id = ??????;

38. Alternatively, on your laptop/desktop change directory in your repo
    to consumption, and update stack like before with the
    ConsumptionLayer.yml template. Check the updated cloudformation
    stack Output for the Redshift IAM role ARN that you will need.

39. Go to the Redshift console and start the Query Editor, run the
    following queries,

    create external schema spectrum from data catalog database
    \'datalakeworkshopdb\' iam\_role
    \'arn:aws:iam::299653513543:role/datagenstack-WSRedshiftIAMRole-?????????????\'
    create external database if not exists;

    If the **Query Editor** asks to create a new connection, accept it.
    For the **Database name**, provide the string workshopredshiftdb.
    For **User name**, provide the string admin. Click the **Connect
    button**. Try this query, you should get the output you are looking
    for,

    select \* from spectrum.\<destination\_table\_from\_glue\_catalog\>
    limit 50;

    **Instructions for Cleanup for Resources created by hand:**

    **Stop migration task, delete migration task, delete endpoints,
    delete replication instance, delete certificates, stop Glue ETL job,
    stop crawler, delete tables. Finally, delete stack.**
