# script:
#	- iterates through each table described by a file in the directory at "psTableDirectory" and
#	- exports each table via DDE
#	- processes each file to remove special characters and convert dates to ISO format saving converted file in same directory
#	- reads each converted file a line at a time, splits the data, converts it to a SQL string, and loads data into mySQL
#	- 
#
# scottdawson72


import configmanager
import datetime
import erc
import follett
import gmailer
import logging
import MySQLdb
import os
import powerschool
import ps1000
import re
import string
import sys
import time
import tools
import unittest

start_time = datetime.datetime.now()

configuration_values = configmanager.readconfig()

gmail_user = configuration_values['gmail_user']
gmail_pwd = configuration_values['gmail_pwd']
email_body = ''
email_attention_flag = False
prowl_address = configuration_values['prowl_address']
log_file = configuration_values['log_path']
follett_destination_directory = configuration_values['follett_destination_directory']

logging.basicConfig(filename=log_file)

today = datetime.date.today()
date_stamp = today.strftime("%A, %B %d %Y")
powerschool_term_id = 'label=11-12 2011-2012'
field_delimeter = '^'
record_delimiter = '|'
sql_statement_counter = 0

prowl_body = ''


full_path_to_host_file = configuration_values['path_to_host_file']

whitelist = string.letters + string.digits + ' ' + '/' + '?' + '\\' + '\t' + '.' + '!' + '@' + '#' + '$' + '%' + '&' + '*' + '(' + ')' + '_' + '-' + '=' + '+' + ':' + ';' + '|' + '[' + ']' + '{' + '}' + '<' + '>' + '~' + '^' + '`'
date_finder = re.compile('([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4})')

def characters_from_whitelist_only(dirty_string):
   clean_string = ''
   for shady_character in dirty_string:
      if shady_character in whitelist:
         clean_string += shady_character
   return clean_string

# set default values to prevent errors when tables are commented out
inserted_students_calculated = 0
inserted_aggstats = 0
inserted_attendance = 0
inserted_attendance_code = 0
inserted_attendance_taken = 0
inserted_cc = 0
inserted_courses = 0
inserted_graduation_requirements = 0
inserted_log = 0
inserted_period = 0
inserted_schedulecatalogs = 0
inserted_schedulecc = 0
inserted_schedulecoursecatalogs = 0
inserted_scheduledepartments = 0
inserted_scheduleperiods = 0
inserted_sections = 0
inserted_stored_grades = 0
inserted_students = 0
inserted_teachers = 0

prowl_body = 'Session started at {0}'.format(start_time)
#inserted_students_calculated = powerschool.download_students_calculated()
#inserted_aggstats = powerschool.update_aggstats()
#inserted_attendance = powerschool.update_attendance()
#inserted_attendance_code = powerschool.update_attendance_code()
#inserted_attendance_taken = powerschool.update_attendance_taken()
#inserted_cc = powerschool.update_cc()
#inserted_courses = powerschool.update_courses()
#inserted_graduation_requirements = powerschool.update_graduation_requirements()
#inserted_log = powerschool.update_log()
#inserted_period = powerschool.update_period()
#inserted_schedulecatalogs = powerschool.update_schedulecatalogs()
#inserted_schedulecc = powerschool.update_schedulecc()
#inserted_schedulecoursecatalogs = powerschool.update_schedulecoursecatalogs()
#inserted_scheduledepartments = powerschool.update_scheduledepartments()
#inserted_scheduleperiods = powerschool.update_scheduleperiods()
#inserted_sections = powerschool.update_sections()
#inserted_stored_grades = powerschool.update_stored_grades()
inserted_students = powerschool.update_students()
inserted_teachers = powerschool.update_teachers()

homeroom_update_file = powerschool.write_homeroom_upload_file()
cnt_update_file = powerschool.write_cnt_upload_file()

ps1000.write_host_file()
erc.write_erc_update_file()
follett()

end_time = datetime.datetime.now()
elapsed_time = end_time - start_time
prowl_subject = 'vlad has run'
prowl_body = prowl_body + '\nvlad completed a run at {0}'.format(end_time)
prowl_body = prowl_body + '\nElapsed time:{0}'.format(elapsed_time)
gmailer.mail(prowl_address, prowl_subject, prowl_body, gmail_user, gmail_pwd)

db_host = 'localhost'
db_user = configuration_values['db_user']
db_password = configuration_values['db_passwd']
db_name = configuration_values['db_db']
conn = MySQLdb.connect (host = db_host,
                        user = db_user,
                        passwd = db_password,
                        db = db_name)
cursor = conn.cursor ()
sql_string = "INSERT INTO meta_update (time_start, time_end, inserted_aggstats, inserted_attendance, inserted_attendance_code, inserted_attendance_taken, inserted_cc, inserted_courses, inserted_graduation_requirements, inserted_log, inserted_period, inserted_schedulecatalogs, inserted_schedulecc, inserted_schedulecoursecatalogs, inserted_scheduledepartments, inserted_scheduleperiods, inserted_sections, inserted_stored_grades, inserted_students, inserted_students_calculated, inserted_teachers) VALUES ('{0}','{1}','{2}','{3}', '{4}', '{5}', '{6}', '{7}', '{8}', '{9}', '{10}', '{11}', '{12}', '{13}', '{14}', '{15}', '{16}', '{17}', '{18}', '{19}', '{20}')".format(start_time, end_time, inserted_aggstats, inserted_attendance, inserted_attendance_code, inserted_attendance_taken, inserted_cc, inserted_courses, inserted_graduation_requirements, inserted_log, inserted_period, inserted_schedulecatalogs, inserted_schedulecc, inserted_schedulecoursecatalogs, inserted_scheduledepartments, inserted_scheduleperiods, inserted_sections, inserted_stored_grades, inserted_students, inserted_students_calculated, inserted_teachers)
print 'Executing sql_string:'
print sql_string
cursor.execute(sql_string)
