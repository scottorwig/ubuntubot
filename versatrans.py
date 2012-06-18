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
    
    kindergarten_sql = """SELECT Student_Number, Home_Phone AS FamilyID, gender, last_name, first_name, middle_name, Home_Phone, DOB, Mailing_Street, Mailing_City, Mailing_State, Mailing_Zip, Next_School, 'K' AS Grade FROM students WHERE Sched_NextYearGrade='0' AND Enroll_Status='-1' ORDER BY last_name, first_name"""
    print kindergarten_sql
    cursor = conn.cursor()
    cursor.execute(kindergarten_sql)
    result = cursor.fetchall()    
    
    csv_writer = csv.writer(kindergarten_full_path, 'w')
    
    for student in result:
        csv_writer.writerow(student)

if __name__ == "__main__":
    write_new_k()