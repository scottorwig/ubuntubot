# script:
#	- iterates through each table described by a file in the directory at "psTableDirectory" and
#	- exports each table via DDE
#	- processes each file to remove special characters and convert dates to ISO format saving converted file in same directory
#	- reads each converted file a line at a time, splits the data, converts it to a SQL string, and loads data into mySQL
#	- 
#
# scottdawson72

import ConfigParser
import datetime
import follett
import gmailer
import os
import powerschool
import re
import string
import sys
import time
import unittest

config = ConfigParser.ConfigParser()
config.read(['/home/orwig/Dropbox/lincoln_ubuntubot/ubuntubot.cfg'])

gmail_user = config.get('gmail', 'user')
gmail_pwd = config.get('gmail', 'password')
email_body = ''
email_attention_flag = ''
prowl_address = config.get('prowl', 'email')

multiple_building = 0
powerschool_table_directory = config.get('vlad', 'table_directory')
browser_download_directory = config.get('vlad', 'download_directory')
today = datetime.date.today()
date_stamp = today.strftime("%A, %B %d %Y")
powerschool_term_id = 'label=10-11 2010-2011'
field_delimeter = '^'
record_delimiter = '|'
sql_statement_counter = 0


full_path_to_host_file = config.get('ps1000', 'host_file_directory')

whitelist = string.letters + string.digits + ' ' + '/' + '?' + '\\' + '\t' + '.' + '!' + '@' + '#' + '$' + '%' + '&' + '*' + '(' + ')' + '_' + '-' + '=' + '+' + ':' + ';' + '|' + '[' + ']' + '{' + '}' + '<' + '>' + '~' + '^' + '`'
date_finder = re.compile('([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4})')

def characters_from_whitelist_only(dirty_string):
   clean_string = ''
   for shady_character in dirty_string:
      if shady_character in whitelist:
         clean_string += shady_character
   return clean_string

def log_to_email(log_string, email_body):  
   print log_string
   email_body = email_body + '\n' + log_string
   return email_body

## PROCEDURAL CODE STARTS HERE

db_host = 'localhost'
db_user = config.get('powerschoolmirror', 'user')
db_password = config.get('powerschoolmirror', 'password')
db_name = config.get('powerschoolmirror', 'database')
conn = MySQLdb.connect (host = db_host,
                        user = db_user,
                        passwd = db_password,
                        db = db_name)
cursor = conn.cursor ()
cursor.execute ("SELECT VERSION()")
row = cursor.fetchone ()
log_string = 'Connected to mySQL - server version: {0}'.format(row[0])
email_body = log_to_email(log_string, email_body)
cursor.close ()
conn.close ()

# go through each table in the table directory
for file_name in os.listdir(powerschool_table_directory):
   file_name_split = os.path.splitext(file_name)
   district_at_once = True
   buildings_list = []
   delete_and_replace_records = True
   search_all_records = True
   if file_name_split[1] == '.table':
      table_stats = file_name_split[0].rsplit('-')
      table_name_with_caps = table_stats[1]
      table_name = string.lower(table_name_with_caps)
      table_number = table_stats[2]
      
      table_full_path_for_reader = os.path.join(powerschool_table_directory, file_name)
      fields_reader = open(table_full_path_for_reader, 'r')
      field_at_a_time = fields_reader.readlines()
      field_list = []
      fields_br_string = ''
      fields_comma_string = ''
      filter_field_name = ''
      filter_operator = ''
      filter_value = ''
      
      log_string = 'File {0} appears to be a table descriptor for {1}'.format(file_name,table_name)
      email_body = log_to_email(log_string,email_body)
      
      for field in field_at_a_time:
         if field[0:14] == '#BUILDINGLIST:':
            print 'Found the building list {0}'.format(field)
            district_at_once = False
            building_string = field.replace('#BUILDINGLIST:','')
            building_string_no_returns = building_string.replace('\n','')
            print 'Splitting string "{0}" into buildings'.format(building_string_no_returns)
            building_string_split = building_string_no_returns.rsplit(',')
            for building in building_string_split:
               buildings_list.append(building)
            print 'buildingsList is {0}'.format(buildings_list)
         elif field[0:7] == '#FILTER':
            search_all_records = False
            print 'Found the filter {0}'.format(field)
            filter_string = field.replace('#FILTER:','')
            filter_string_no_returns = filter_string.replace('\n','')
            print 'Splitting string "{0}"'.format(filter_string_no_returns)
            filter_string_split = filter_string_no_returns.rsplit(':')
            filter_field_name = filter_string_split[0]
            filter_operator = filter_string_split[1]
            filter_value = filter_string_split[2]
            print 'Will filter {0}, {1}, {2}'.format(filter_field_name,filter_operator,filter_value)
         elif field[0:9] == '#NODELETE':
            print 'Records in the mirror table will NOT be deleted before new data is added'
            delete_and_replace_records = False
         elif field [0:2] == '# ':
            print 'Found the comment {0}'.format(field)
         else:
            clean_field = characters_from_whitelist_only(field)
            field_lower_case = string.lower(clean_field)
            field_list.append(field_lower_case)
            if len(fields_br_string) > 0:
               fields_br_string += '<br>'
            fields_br_string += field_lower_case
            if len(fields_comma_string) > 0:
               fields_comma_string += ','
            fields_comma_string += field_lower_case
            field_list.append(field_lower_case)
      
      
      log_string = 'Field list is {0}'.format(field_list)
      email_body = log_to_email(log_string, email_body)
      log_string = 'fields_br_string is {0}'.format(fields_br_string)
      email_body = log_to_email(log_string, email_body)
      log_string = 'fields_comma_string is {0}'.format(fields_comma_string)
      email_body = log_to_email(log_string, email_body)
      
      download_file_name = table_name + '.download'
      downloaded_file_path = os.path.join(browser_download_directory, download_file_name)
      
      # if a manual download is not provided, download one using PowerSchool
      if not os.path.exists(downloaded_file_path):
         do_next = 'download that sucker'
         log_string = 'Manual download file does not exist at {0}'.format(downloaded_file_path)
         email_body = log_to_email(log_string, email_body)
         cleaned_table_full_path, record_count = powerschool.download_table()
         email_body = email_body + '\n' + str(download_result)
      else:
         log_string = 'Manual download file exists at {0}'.format(downloaded_file_path)
         email_body = log_to_email(log_string, email_body)
         log_string = 'Sending file to the module powerschool.py for processing'
         email_body = log_to_email(log_string, email_body)
         cleaned_table_full_path, record_count, email_body = powerschool.process_downloaded_table(downloaded_file_path,'|', email_body)
         log_string = 'Cleaned file with {0} records written to "{1}" - processing . . .'.format(record_count, cleaned_table_full_path)
         email_body = log_to_email(log_string, email_body)
         print 'Waiting 10 seconds for things to settle down'
         time.sleep(10)

      log_string = 'About to re-open cleaned file at "{0}"'.format(cleaned_table_full_path)
      print log_string
      email_body = email_body + '\n' + log_string
      # Re-open the cleaned, combined file that was just created
      # Read each line, splitting it into individual fields
      # and immediately writing this data to the database
      db_connection = MySQLdb.connect (host = "localhost", user = "root", passwd = "UsingData2Improve", db = "powerschoolmirror")
      cursor = db_connection.cursor ()
      if delete_and_replace_records:
         delete_statement = 'DELETE FROM ' + table_name
         log_string = 'Executing delete statement "{0}"'.format(delete_statement)
         print log_string
         email_body += email_body + '/' + log_string
         cursor.execute(delete_statement)
      else:
         print 'Existing records will not be deleted from {0}'.format(table_name)
      try:
         print 'About to re-open the cleaned data file {0}'.format(cleaned_table_full_path)
         cleaned_file_reader = open(cleaned_table_full_path, 'r')
         clean_line_at_a_time = cleaned_file_reader.readlines()
      except:
         log_string = 'Strange, I can not open the file "{0}"'.format(cleaned_table_full_path)
         print log_string
         email_body = email_body + '\n' + log_string
         email_attn_flag = 'POSSIBLE ERROR -'
      sql_statement_counter = 0
      for clean_line in clean_line_at_a_time:
         data_list = clean_line.split(field_delimeter)
         sql_data_string = "('" + "','".join(data_list) + "')"
         sql_string = 'REPLACE INTO ' + table_name + '(' + fields_comma_string + ') VALUES ' + sql_data_string
         print sql_string
         cursor = db_connection.cursor ()
         cursor.execute(sql_string)
         db_connection.commit()
         sql_statement_counter = sql_statement_counter + 1
      try:
         cleaned_file_reader.close()
         db_connection.close()
      except:
         print 'Error trying to close the cleaned_file_reader'
   
      log_string = 'Executed {0} SQL statements on table {1}'.format(sql_statement_counter, table_name)
      print log_string
      email_body = email_body + '\n' + log_string
      
      #if sql_statement_counter < 500:
         #email_attn_flag = 'POSSIBLE ERROR -'
         #log_string = 'IS {0} SQL STATEMENTS AN ERROR?'.format(sql_statement_counter)
         #print log_string
         #email_body = email_body + '\n' + log_string


#email_subject_base = 'vlad report from {0}'.format(date_stamp)
#email_subject = email_attention_flag + ' ' + email_subject_base
#gmailer.mail(email_recipients, email_subject, email_body, gmail_user, gmail_pwd)

prowl_subject = 'vlad has run'
prowl_body = 'vlad completed a run at {0}'.format(date_stamp)
gmailer.mail(prowl_address, prowl_subject, prowl_body, gmail_user, gmail_pwd)

time_stamp = time.strftime("%a, %d %b %Y %H:%M:%S +0000", time.localtime())
#module_write_ps1000_host_filewrite_host_file(fullPathToHostFile, time_stamp, date_stamp, email_recipients)
