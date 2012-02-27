import configmanager
import datetime
import logging
import MySQLdb
import string
import time

settings = configmanager.readconfig()
db_user = settings['db_user']
db_passwd = settings['db_passwd']
db_db = settings ['db_db']

fullPathToHostFile = r'/home/orwig/etl/HOST.dat'

today = datetime.date.today()
dateStamp = today.strftime("%A, %B %d %Y")

def write_host_file():
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
      line_to_write  += record[3] + ','
      line_to_write  += str(record[4]) + ','
      line_to_write  += record[5] + ','
      line_to_write  += record[6] + ','
      line_to_write  += record[7] + ','
      line_to_write  += record[8] + ','
      line_to_write  += str(record[9]) + ','
      line_to_write  += record[10] + ','
      line_to_write  += record[11] + ','
      line_to_write  += record[12] + ','
      line_to_write  += record[13]
      file_writer.write(line_to_write + '\r\n')
      print line_to_write
      write_count = write_count + 1

   # pause before and after writing as a precaution due to some strange file corruption issues - may be unnecessary
   print 'Sleeping for 5 seconds before closing file'
   time.sleep(5)
   file_writer.close()
   print 'Sleeping for 5 seconds after closing file'
   time.sleep(5)

write_host_file()
