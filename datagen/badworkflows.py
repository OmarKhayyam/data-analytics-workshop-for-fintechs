#!/usr/bin/env python3

import random
import argparse
import mysql.connector
from mysql.connector import errorcode

cities = ['BOM','DEL','BLR','CAL','MAA','GOI','COK','HYD','PNQ','SXR','TRV','AMD','ZER']
trxtypes = ['CREDIT','DEBIT','NONMON']
services = {0: 'fundtransfer',1: 'upi',2: 'enquiry',3: 'forex',4: 'mutualfund-investment',5: 'capitalmarket-investment',6: 'FD',7: 'PensionFund-investment'}

DB_NAME="workshopdb1"
user = 10001
city = 'BOM'

def normal_wf(user,city,dbconn):
    cursor = dbconn.cursor()
    try:
        cursor.execute("USE {};".format(DB_NAME))
    except mysql.connector.Error as err:
        print("Database {} does not exist.".format(DB_NAME)) 
        if err.errno == errorcode.ER_BAD_DB_ERROR:
            print(err)
            exit(1)
    stmt = "INSERT INTO customeractivity(user_id,city,transaction_type,monetary_value,timeinapp,feature_used,ts) VALUES("+str(user)+","+cities[0]+","+'DEBIT'+","+str(2000)+","+str(100)+","+'UPITRANSACTION'+","+CURRENT_TIMESTAMP()+")"
    cursor.execute(stmt)
    cursor.close()

## TEST ##
dbconn = mysql.connector.connect(user='admin',password='master123', host='datagenstack-datasourcedb-f2xrome5ajrm.cluster-ckyzeld8ogd5.us-east-1.rds.amazonaws.com')
normal_wf(user,city,dbconn)
