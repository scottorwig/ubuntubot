# code abandoned because we may have found another solution

import configmanager
import datetime
import logging
import MySQLdb
import string
import time
import xml.etree.ElementTree as ET

settings = configmanager.readconfig()
db_user = settings['db_user']
db_passwd = settings['db_passwd']
db_db = settings ['db_db']

attribute_dictionary = {'SchemaVersionMinor': '2', 'SubmittingSystemVersion': '1.0', 'CollectionName': 'EarlyRoster', 'SubmittingSystemVendor': 'ScottOrwig', 'CollectionId': '101', 'SchemaVersionMajor': 'Collection', 'SubmittingSystemName': 'ubuntubot', 'xsi:noNamespaceSchemaLocation': 'http://cepi.state.mi.us/msdsxml/EarlyRosterCollection2.xsd', 'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance'}
root = ET.Element('EarlyRosterGroup', attribute_dictionary)

full_path_to_early_roster = r'/home/scott/etl/early_roster.xml'

today = datetime.date.today()
dateStamp = today.strftime("%A, %B %d %Y")

def write_early roster():
   db=MySQLdb.connect(user=db_user,passwd=db_passwd,db=db_db)
   cursor = db.cursor()
   cursor.execute("""SELECT Student_Number,Last_Name, First_Name, Middle_Name, DOB, Home_Phone, SchoolID, Grade_Level, Home_Room, LTRIM(CONCAT(cnt1_fname,' ',cnt1_lname)) AS ContactName, Mailing_Street, Mailing_City, Mailing_State, Mailing_Zip FROM students WHERE Enroll_Status='0' OR Enroll_Status='-1' ORDER BY Grade_Level""")

   result = cursor.fetchall()
   record_count = len(result)
   log_string = '{0} records SELECTed from the database'.format(record_count)
   print log_string

   file_writer = open(fullPathToHostFile, 'w')
   print 'Waiting 5 seconds to make sure the file is open for writing'
   time.sleep(5)
   print 'Writing to:'.format(fullPathToHostFile)
   write_count = 0
   for record in result:
      line_to_write  = record[0] + ','
      line_to_write  += record[1] + ','
      line_to_write  += record[2] + ','