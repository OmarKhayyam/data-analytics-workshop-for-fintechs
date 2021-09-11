#!/usr/bin/env python3

import random
import argparse
import mysql.connector
from mysql.connector import errorcode

cities = ['BOM','DEL','BLR','CAL','MAA','GOI','COK','HYD','PNQ','SXR','TRV','AMD','ZER']
trxtypes = ['CREDIT','DEBIT','NONMON']
services = ['FUNDTRANSFER','UPITRANSACTION','ENQUIRY','FOREX','MF-INVEST','CAPITALMARKET-INVEST','FD-INVEST','PENSIONFUND-INVEST']

DB_NAME="workshopdb1"
user = 10002
city = 'CAL'

def normal_wf(user,city,dbconn):
    cursor = dbconn.cursor(prepared=True)
    stmt = """INSERT INTO workshopdb1.customeractivity(user_id,city,transaction_type,monetary_value,timeinapp,feature_used) VALUES(%s,%s,%s,%s,%s,%s)"""
    cursor.execute(stmt,(user,city,trxtypes[1],2000,100,services[1]))
    dbconn.commit()
    cursor.close()

## TEST ##
dbconn = mysql.connector.connect(user='admin',password='master123', host='datagenstack-datasourcedb-f2xrome5ajrm.cluster-ckyzeld8ogd5.us-east-1.rds.amazonaws.com')
print("Created the connection..")
normal_wf(user,city,dbconn)
print("Inserted the data..")
dbconn.close()
## TEST COMPLETE##

#Initialize parser
parser = argparse.ArgumentParser()

#Add argument flag
parser.add_argument("-e","--endpoint",help = "DB end point")

#Read arguments from commandline
args = parser.parse_args()

if args.endpoint:
    ep = args.endpoint

dbconn = mysql.connector.connect(user='admin',password='master123', host=ep)


