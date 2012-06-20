# this code requires at config file
# specify the path here
config_file_path = r'ubuntubot.cfg'

import ConfigParser
import csv
import datetime
import logging
import MySQLdb
import os
import string
import time

config = ConfigParser.ConfigParser()
config.read([config_file_path])

destination_directory = config.get('versatrans', 'destination_directory')
kindergarten_file_name = 'versatrans_new_kindergarten.csv'
kindergarten_full_path = os.path.join(destination_directory,kindergarten_file_name)

def write_new_k():
    db_host = 'localhost'
    db_user = config.get('powerschoolmirror', 'user')
    db_password = config.get('powerschoolmirror', 'password')
    db_name = config.get('powerschoolmirror', 'database')
    conn = MySQLdb.connect (host = db_host,
                        user = db_user,
                        passwd = db_password,
                        db = db_name)
    
    kindergarten_sql = """SELECT Mailing_Street, Student_Number, Home_Phone AS FamilyID, gender, last_name, first_name, middle_name, Home_Phone, DOB, Mailing_City, Mailing_State, Mailing_Zip, Next_School, 'K1' AS Grade FROM students WHERE Sched_NextYearGrade='0' AND Enroll_Status='-1' ORDER BY Next_School, last_name, first_name"""
    print kindergarten_sql
    cursor = conn.cursor()
    cursor.execute(kindergarten_sql)
    result = cursor.fetchall()    
    
    #can't use csv writer because I have to split one of the result elements first
    file_writer = open(kindergarten_full_path, 'w')
    line_counter = 0
    for student in result:
	print student
	address_split = student[0].split(' ',1)
	line_to_write = student[1] #student number
	line_to_write += ',' + student[2] #family id
	line_to_write += ',' + student[3] #gender
	line_to_write += ',' + student[4] #last name
	line_to_write += ',' + student[5] #first name
	line_to_write += ',' + student[6] #middle name
	line_to_write += ',' + student[7] #home phone
	line_to_write += ',' + student[8].strftime('%m/%d/%Y') #dob
	line_to_write += ',' + address_split[0] #house number
	try:
		line_to_write += ',' + address_split[1] #street
	except:
		line_to_write += ','
	line_to_write += ',' + student[9] #city
	line_to_write += ',' + student[10] #state
	line_to_write += ',' + student[11] #zip
	line_to_write += ',' + student[12] #school
	line_to_write += ',' + student[13] #K
	print line_to_write
        file_writer.write(line_to_write + '\n')
	line_counter = line_counter + 1

    file_writer.close()
    print str(line_counter) + ' lines written'

if __name__ == "__main__":
    write_new_k()
