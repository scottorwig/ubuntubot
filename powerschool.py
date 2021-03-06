from selenium import selenium
from selenium import webdriver
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException
import configmanager
import datetime
import logging
import MySQLdb
import os
import re
import string
import time
import tools
import unittest

configuration_values = configmanager.readconfig()

powerschool_server_root = configuration_values['powerschool_server_root']
powerschool_pw_page = configuration_values['powerschool_pw_page']
powerschool_user_password = configuration_values['powerschool_user_password']
etl_directory = configuration_values['etl_directory']

db_host = 'localhost'
db_user = configuration_values['db_user']
db_password = configuration_values['db_passwd']
db_name = configuration_values['db_db']
conn = MySQLdb.connect (host = db_host,
                        user = db_user,
                        passwd = db_password,
                        db = db_name)
cursor = conn.cursor ()

config_server_root = configuration_values['powerschool_server_root']
config_pw_page = configuration_values['powerschool_pw_page']
config_user_password = configuration_values['powerschool_user_password']
browser_download_directory = configuration_values['browser_download_directory']
browser_partial_download = os.path.join(browser_download_directory,'student.export.text.crdownload')
browser_completed_download = os.path.join(browser_download_directory,'student.export.text')
archive_folder = configuration_values['archive_folder']

whitelist = string.letters + string.digits + ' ' + '/' + '?' + '.' + '!' + '@' + '#' + '$' + '%' + '&' + '*' + '(' + ')' + '_' + '-' + '=' + '+' + ':' + ';' + '|' + '[' + ']' + '{' + '}' + '<' + '>' + '~' + '^' + '`'
date_finder = re.compile('([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4})')

def characters_from_whitelist_only(dirty_string):
    clean_string = ''
    for character in dirty_string:
        if character in whitelist:
            clean_string += character
    return clean_string

def convert_english_date_to_iso_date(englishDate):
    year = ''
    yearFinder = re.compile('[0-9]{1,2}/[0-9]{1,2}/([0-9]{2,4})')
    monthFinder = re.compile('([0-9]{1,2})/[0-9]{1,2}/[0-9]{2,4}')
    dayFinder = re.compile('[0-9]{1,2}/([0-9]{1,2})/([0-9]{2,4})')
    yearMatch = yearFinder.search(englishDate.group())
    monthMatch = monthFinder.search(englishDate.group())
    dayMatch = dayFinder.search(englishDate.group())
    isoString = yearMatch.group(1) + '-' + monthMatch.group(1).zfill(2) + '-' + dayMatch.group(1).zfill(2)
    return isoString

def dump_table_to_archive(table_name):
    current_time = datetime.datetime.now()
    datetime_stamp = current_time.strftime('%Y%m%d_%H%M%S')
    dump_file_name = 'dump_' + table_name + '_' + datetime_stamp + '.sql'
    full_path_to_dump = os.path.join(archive_folder,dump_file_name)
    sql_string = 'mysqldump --user=' + db_user + ' --password=' + db_password + ' ' + db_name + ' ' + table_name + ' -r ' + full_path_to_dump
    print sql_string
    os.system(sql_string)
    return full_path_to_dump

def write_homeroom_upload_file():
    current_time = datetime.datetime.now()
    datetime_stamp = current_time.strftime('%Y%m%d_%H%M%S')
    update_file_name = 'homeroom_update_' + datetime_stamp + '.tab'
    full_path_to_update_file = os.path.join(etl_directory,update_file_name)
    missing_homeroom_file_name = 'missing_homeroom_' + datetime_stamp + '.tab'
    full_path_to_missing_homeroom_file = os.path.join(etl_directory,missing_homeroom_file_name)
    db_host = 'localhost'
    db_user = configuration_values['db_user']
    db_password = configuration_values['db_passwd']
    db_name = configuration_values['db_db']
    conn = MySQLdb.connect (host = db_host,
                        user = db_user,
                        passwd = db_password,
                        db = db_name)
    homeroom_update_query = """SELECT students.Student_Number, students.ID, First_Name, Last_Name, students_calculated.period_3_teacher FROM students, students_calculated WHERE students.ID=students_calculated.student_id AND students.SchoolID='500' AND Home_Room='' AND students_calculated.period_3_teacher<>'' AND Enroll_Status = '0' ORDER BY students_calculated.period_3_teacher"""
    print homeroom_update_query
    cursor = conn.cursor()
    cursor.execute(homeroom_update_query)
    result = cursor.fetchall()
    update_writer = open(full_path_to_update_file,'w')
    update_header = 'Student_Number\tFirst_Name\tLast_Name\tHome_Room\r\n'
    update_writer.write(update_header)
    for student in result:
        line_to_write =  student[0] + '\t'
        line_to_write += student[2] + '\t'
        line_to_write += student[3] + '\t'
        line_to_write += student[4]
        print line_to_write
        update_writer.write(line_to_write + '\r\n') 
    update_writer.close()
    missing_homeroom_query = """SELECT students.Student_Number, First_Name, Last_Name, students.SchoolID, students.Grade_Level FROM students, students_calculated WHERE students.ID=students_calculated.student_id AND Home_Room='' AND students_calculated.period_3_teacher='' AND Enroll_Status = '0' ORDER BY students.SchoolID, students.Last_Name, students.First_Name"""
    cursor.execute(missing_homeroom_query)
    result = cursor.fetchall()
    for student in result:
        line_to_write = ','.join(student)
        print line_to_write


    missing_writer = open(full_path_to_missing_homeroom_file,'w')
    missing_writer.close()
    return full_path_to_update_file

def write_cnt_upload_file():
    current_time = datetime.datetime.now()
    datetime_stamp = current_time.strftime('%Y%m%d_%H%M%S')
    update_file_name = 'cnt1_update_' + datetime_stamp + '.tab'
    full_path_to_update_file = os.path.join(etl_directory,update_file_name)
    db_host = 'localhost'
    db_user = configuration_values['db_user']
    db_password = configuration_values['db_passwd']
    db_name = configuration_values['db_db']
    conn = MySQLdb.connect (host = db_host,
                        user = db_user,
                        passwd = db_password,
                        db = db_name)
    cnt_update_query = """SELECT Student_Number,Last_Name, First_Name, Mother, Father FROM students WHERE cnt1_lname = '' AND (Enroll_Status='0' OR Enroll_Status='-1') ORDER BY Last_Name, First_Name"""
    print cnt_update_query
    cursor = conn.cursor()
    cursor.execute(cnt_update_query)
    result = cursor.fetchall()
    update_writer = open(full_path_to_update_file,'w')
    update_header = 'Student_Number\tFirst_Name\tLast_Name\tcnt1_lname\tcnt1_fname\r\n'
    update_writer.write(update_header)
    for student in result:
        line_to_write =  student[0] + '\t'
        line_to_write += student[1] + '\t'
        line_to_write += student[2] + '\t'
        if student[3] != '':
            mother_full_name = student[3]
            try:
                mother_last_name, mother_first_name = mother_full_name.split(' ',1)
                line_to_write += mother_first_name + '\t'
                line_to_write += mother_last_name
                update_writer.write(line_to_write + '\r\n')
            except:
                print 'could not split {0}'.format(mother_full_name)
        elif student[4] != '':
            father_full_name = student[3]
            try:
                father_last_name, father_first_name = father_full_name.split(' ',1)
                line_to_write += father_first_name + '\t'
                line_to_write += father_last_name
                update_writer.write(line_to_write + '\r\n')
            except:
                print 'could not split {0}'.format(father_full_name)
    update_writer.close()
    return full_path_to_update_file

def download_table(table_number, table_name, field_list, building_list=['District Office'], search_criteria=''):
    report_string = '*** downloading table number {0}, {1} from {2} building(s)'.format(table_number, table_name, len(building_list))
    print report_string
    field_list_newlines = field_list.replace(',','\n')

    # Clear out partial downloads and anything related to the current table
    for file_name in os.listdir(browser_download_directory):
        if (table_name in file_name) or ('part' in file_name):
            full_path_to_doomed_file = os.path.join(browser_download_directory,file_name)
            os.remove(full_path_to_doomed_file)
            if os.path.exists(full_path_to_doomed_file):
                print '{0} still lives!'.format(full_path_to_doomed_file)
            else:
                print 'Removed file:{0}'.format(full_path_to_doomed_file)

    for building_name in building_list:
        driver = webdriver.Chrome('/home/scott/chromedriver') 
        driver.implicitly_wait(30)
        base_url = config_server_root
        url_of_admin_page = base_url + config_pw_page
        print 'Getting {0}'.format(url_of_admin_page)
        driver.get(url_of_admin_page)
        # Login page
        driver.find_element_by_id("fieldPassword").clear()
        driver.find_element_by_id("fieldPassword").send_keys(config_user_password)
        driver.find_element_by_id("btnEnter").click()
        # Main page
        print 'choosing school:{0}'.format(building_name)
        report_string = report_string + "\nChoosing building {0}".format(building_name)
        driver.find_element_by_id("schoolContext").click()
        select = Select(driver.find_element_by_name("Schoolid"))
        select.select_by_visible_text(building_name)
        print 'pausing 10 seconds'
        time.sleep(10)
        driver.find_element_by_id("navSetupSystem").click()
        print 'pausing 10 seconds'
        time.sleep(10)
        driver.find_element_by_link_text("Direct Database Export (DDE)").click()
        #table_choice_string = table_name + '&nbsp(' + table_number + ')'
        print 'choosing table:{0}'.format(table_number)
        select = Select(driver.find_element_by_name("filenum"))
        select.select_by_value(table_number)
        print 'table {0} selected'.format(table_number)
        if search_criteria:
            print 'this download has the search criteria {0}'.format(search_criteria)
            fieldnum_1 = search_criteria[0]
            comparator1 = search_criteria[1]
            value = search_criteria[2]
            print 'pausing 15 seconds'
            time.sleep(15)
            select = Select(driver.find_element_by_name("fieldnum_1"))
            select.select_by_visible_text(fieldnum_1)
            select = Select(driver.find_element_by_name("comparator1"))
            select.select_by_visible_text(comparator1)
            driver.find_element_by_name("value").clear()
            driver.find_element_by_name("value").send_keys(value)
            print 'pausing 10 seconds'
            time.sleep(10)
            driver.find_element_by_name("search").click()
        else:
            print 'this download has no search criteria'
            print 'pausing 15 seconds'
            time.sleep(15)
            print 'finding element by name searchselectall'
            driver.find_element_by_name("searchselectall").click()
        print 'clicking Export Records'        
        driver.find_element_by_link_text("Export Records").click()
        driver.find_element_by_id("tt").clear()
        driver.find_element_by_id("tt").send_keys(field_list_newlines)
        select = Select(driver.find_element_by_name("fielddelim"))
        select.select_by_visible_text("Other:")
        driver.find_element_by_name("custfielddelim").clear()
        driver.find_element_by_name("custfielddelim").send_keys("^")
        select = Select(driver.find_element_by_name("recdelim"))
        select.select_by_visible_text("Other:")
        driver.find_element_by_name("custrecdelim").clear()
        driver.find_element_by_name("custrecdelim").send_keys("|")
        print 'downloading table "{0}"'.format(table_name)
        driver.find_element_by_id("btnSubmit").click()
        print 'pausing 15 seconds for sluggish download starts'
        time.sleep(15)
        while os.path.exists(browser_partial_download):
            print '{0} exists. Waiting.'.format(browser_partial_download)
            time.sleep(30)
        print '{0} does not exist. Moving on.'.format(browser_partial_download)

        print 'pausing 15 seconds for the file system to settle'
        time.sleep(15)
        new_download_name = table_name + '.download'
        new_download_path = os.path.join(browser_download_directory,new_download_name)
        print 'will rename: {0}'.format(browser_completed_download)
        print 'to: {0}'.format(new_download_path)
        os.rename(browser_completed_download,new_download_path)
        print 'download renamed to:{0}'.format(new_download_path)
        report_string = report_string + '\ndownload renamed to:{0}'.format(new_download_path)

        print 'pausing 10 seconds'
        time.sleep(10)
        print 'quitting web driver'
        driver.quit()
        print 'pausing another 15 seconds for everything to settle'
        time.sleep(15)
        return report_string

def download_students_calculated():
    calculated_field_list = 'Id\nStudent_Number\n*gpa Method=simple\n*gpa Method=weighted\n*gpa Term=s1\n*gpa Term=s2\n*gpa Term=1700\n*gpa Term=1800\n*gpa Term=1900\n*gpa Term=2000\n*gpa Term=2100\n^(*period_info;1;teacher_name)\n^(*period_info;1;course_name)\n^(*period_info;1;course_number)\n^(*period_info;1;section_number)\n^(*period_info;1;current_grade)\n^(*period_info;1;room)\n^(*period_info;2;teacher_name)\n^(*period_info;2;course_name)\n^(*period_info;2;course_number)\n^(*period_info;2;section_number)\n^(*period_info;2;current_grade)\n^(*period_info;2;room)\n^(*period_info;3;teacher_name)\n^(*period_info;3;course_name)\n^(*period_info;3;course_number)\n^(*period_info;3;section_number)\n^(*period_info;3;current_grade)\n^(*period_info;3;room)\n^(*period_info;4;teacher_name)\n^(*period_info;4;course_name)\n^(*period_info;4;course_number)\n^(*period_info;4;section_number)\n^(*period_info;4;current_grade)\n^(*period_info;4;room)\n^(*period_info;5;teacher_name)\n^(*period_info;5;course_name)\n^(*period_info;5;course_number)\n^(*period_info;5;section_number)\n^(*period_info;5;current_grade)\n^(*period_info;5;room)\n^(*period_info;6;teacher_name)\n^(*period_info;6;course_name)\n^(*period_info;6;course_number)\n^(*period_info;6;section_number)\n^(*period_info;6;current_grade)\n^(*period_info;6;room)'
    # Clear out partial downloads and other files that might interfere
    for file_name in os.listdir(browser_download_directory):
        if ('student' in file_name) or ('calculated' in file_name) or ('part' in file_name):
            full_path_to_doomed_file = os.path.join(browser_download_directory,file_name)
            os.remove(full_path_to_doomed_file)
            if os.path.exists(full_path_to_doomed_file):
                print '{0} still lives!'.format(full_path_to_doomed_file)
            else:
                print 'Removed file:{0}'.format(full_path_to_doomed_file)

    driver = webdriver.Chrome('/home/scott/chromedriver') 
    driver.implicitly_wait(30)
    base_url = config_server_root
    url_of_admin_page = base_url + config_pw_page
    print 'Getting {0}'.format(url_of_admin_page)
    driver.get(url_of_admin_page)
    # Login page
    driver.find_element_by_id("fieldPassword").clear()
    driver.find_element_by_id("fieldPassword").send_keys(config_user_password)
    driver.find_element_by_id("btnEnter").click()
    # Main page
    print 'choosing school:{0}'.format('District Office')
    driver.find_element_by_id("schoolContext").click()
    select = Select(driver.find_element_by_name("Schoolid"))
    select.select_by_visible_text('District Office')
    print 'pausing 10 seconds'
    time.sleep(10)
    driver.find_element_by_id("navSetupSystem").click()
    print 'pausing 10 seconds'
    time.sleep(10)
    driver.find_element_by_link_text("Direct Database Export (DDE)").click()
    print 'choosing table:{0}'.format('1')
    select = Select(driver.find_element_by_name("filenum"))
    select.select_by_value('1')
    print 'table {0} selected'.format('1')
    print 'pausing 15 seconds'
    time.sleep(15)
    print 'finding element by name searchselectall'
    driver.find_element_by_name("searchselectall").click()
    print 'clicking Export Records'        
    driver.find_element_by_link_text("Export Records").click()
    driver.find_element_by_id("tt").clear()
    driver.find_element_by_id("tt").send_keys(calculated_field_list)
    select = Select(driver.find_element_by_name("fielddelim"))
    select.select_by_visible_text("Other:")
    driver.find_element_by_name("custfielddelim").clear()
    driver.find_element_by_name("custfielddelim").send_keys("^")
    select = Select(driver.find_element_by_name("recdelim"))
    select.select_by_visible_text("Other:")
    driver.find_element_by_name("custrecdelim").clear()
    driver.find_element_by_name("custrecdelim").send_keys("|")
    driver.find_element_by_name("columntitles").click()
    print 'pausing 15 more seconds'
    time.sleep(15)
    print 'downloading calculated values from the students table'
    driver.find_element_by_id("btnSubmit").click()
    print 'pausing 30 seconds for sluggish download starts'
    time.sleep(30)
    while os.path.exists(browser_partial_download):
        print '{0} exists. Waiting.'.format(browser_partial_download)
        time.sleep(30)
    print '{0} does not exist. Moving on.'.format(browser_partial_download)

    print 'pausing 15 seconds for the file system to settle'
    time.sleep(15)
    new_download_path = os.path.join(browser_download_directory,'students_calculated.download')
    print 'will rename: {0}'.format(browser_completed_download)
    print 'to: {0}'.format(new_download_path)
    os.rename(browser_completed_download,new_download_path)
    print 'download renamed to:{0}'.format(new_download_path)
    print 'pausing 10 seconds'
    time.sleep(10)
    print 'quitting web driver'
    driver.quit()
    print 'pausing another 15 seconds for everything to settle'
    time.sleep(15)
    downloaded_file_reader = open(new_download_path,'r')
    raw_line_at_a_time = downloaded_file_reader.readlines()
    directory_name = os.path.dirname(new_download_path)
    cleaned_file_name = 'students_calculated.clean_data'
    cleaned_file_path = os.path.join(directory_name, cleaned_file_name)
    clean_file_writer = open(cleaned_file_path,'w')
    report_string = '{0} opened for processing'.format(new_download_path)
    line_counter = 0
    for raw_line in raw_line_at_a_time:
        cleaned_line = tools.clean_string_for_sql(raw_line)
        # replacing |s with \n will put individual records on lines by themselves
        split_records = cleaned_line.replace('|', '\n')
        #print split_records
        clean_file_writer.writelines(split_records)
        line_counter = line_counter + 1
    downloaded_file_reader.close()
    clean_file_writer.close()
    db_connection = MySQLdb.connect (host = db_host, user = db_user, passwd = db_password, db = db_name)
    cursor = db_connection.cursor ()
    delete_statement = 'DELETE FROM students_calculated'
    print 'executing delete statement "{0}"'.format(delete_statement)
    cursor.execute(delete_statement)
    try:
        print 're-opening the data file {0}'.format(cleaned_file_path)
        cleaned_file_reader = open(cleaned_file_path, 'r')
        clean_line_at_a_time = cleaned_file_reader.readlines()
    except:
        print 'Strange, I can not open the file "{0}"'.format(cleaned_file_path)
        clean_line_at_a_time = ''
    sql_statement_counter = 0
    for clean_line in clean_line_at_a_time:
        data_list = clean_line.split('^')
        sql_data_string = "('" + "','".join(data_list) + "')"
        sql_string = 'INSERT INTO students_calculated (student_id,student_number,gpa_simple,gpa_weighted,gpa_s1,gpa_s2,gpa_2007,gpa_2008,gpa_2009,gpa_2010,gpa_2011,period_1_teacher,period_1_course_name,period_1_course_number,period_1_section_number,period_1_current_grade,period_1_room,period_2_teacher,period_2_course_name,period_2_course_number,period_2_section_number,period_2_current_grade,period_2_room,period_3_teacher,period_3_course_name,period_3_course_number,period_3_section_number,period_3_current_grade,period_3_room,period_4_teacher,period_4_course_name,period_4_course_number,period_4_section_number,period_4_current_grade,period_4_room,period_5_teacher,period_5_course_name,period_5_course_number,period_5_section_number,period_5_current_grade,period_5_room,period_6_teacher,period_6_course_name,period_6_course_number,period_6_section_number,period_6_current_grade,period_6_room) VALUES ' + sql_data_string
        print sql_string
        cursor = db_connection.cursor ()
        cursor.execute(sql_string)
        db_connection.commit()
        sql_statement_counter = sql_statement_counter + 1
    try:
        cleaned_file_reader.close()
        db_connection.close()
    except:
        print 'Error trying to close the cleaned_file_reader and/or close the connection'

    print 'Executed {0} SQL statements on table students_calculated'
    return sql_statement_counter


def process_downloaded_table(table_name):
    table_file_name = table_name + '.download'
    downloaded_table_full_path = os.path.join(browser_download_directory,table_file_name)
    downloaded_file_reader = open(downloaded_table_full_path,'r')
    raw_line_at_a_time = downloaded_file_reader.readlines()
    directory_name = os.path.dirname(downloaded_table_full_path)
    cleaned_file_name = table_name + '.clean_data'
    cleaned_file_path = os.path.join(directory_name, cleaned_file_name)
    clean_file_writer = open(cleaned_file_path,'w')
    report_string = '{0} opened for processing'.format(downloaded_table_full_path)

    line_counter = 0
    for raw_line in raw_line_at_a_time:
        cleaned_line = tools.clean_string_for_sql(raw_line)
        # replacing |s with \n will put individual records on lines by themselves
        split_records = cleaned_line.replace('|', '\n')
        #print split_records
        clean_file_writer.writelines(split_records)
        line_counter = line_counter + 1

    downloaded_file_reader.close()
    clean_file_writer.close()
    report_string = report_string + '\n{0} cleaned lines written to:{1}'.format(line_counter,cleaned_file_path)
    return report_string

def insert_into_powerschool_mirror(table_name, field_list, delete_and_replace=True):
    dump_table_to_archive(table_name)
    cleaned_file_name = table_name + '.clean_data'
    cleaned_file_path = os.path.join(browser_download_directory,cleaned_file_name)
    db_connection = MySQLdb.connect (host = db_host, user = db_user, passwd = db_password, db = db_name)
    cursor = db_connection.cursor ()
    if delete_and_replace:
        delete_statement = 'DELETE FROM ' + table_name
        print 'executing delete statement "{0}"'.format(delete_statement)
        cursor.execute(delete_statement)
    else:
        print 'existing records will not be deleted from {0}'.format(table_name)
    try:
        print 're-opening the data file {0}'.format(cleaned_file_path)
        cleaned_file_reader = open(cleaned_file_path, 'r')
        clean_line_at_a_time = cleaned_file_reader.readlines()
    except:
        print 'Strange, I can not open the file "{0}"'.format(cleaned_file_path)
        clean_line_at_a_time = ''
    sql_statement_counter = 0
    for clean_line in clean_line_at_a_time:
        clean_line_no_line_feed = clean_line.replace('\n', '') # /n seems to be read in from file, getting included in the last field
        data_list = clean_line_no_line_feed.split('^')
        sql_data_string = "('" + "','".join(data_list) + "')"
        sql_string = 'REPLACE INTO ' + table_name + '(' + field_list + ') VALUES ' + sql_data_string
        print sql_string
        cursor = db_connection.cursor ()
        cursor.execute(sql_string)
        db_connection.commit()
        sql_statement_counter = sql_statement_counter + 1
    try:
        cleaned_file_reader.close()
        db_connection.close()
    except:
        print 'Error trying to close the cleaned_file_reader and/or close the connection'

    print 'Executed {0} SQL statements on table {1}'.format(sql_statement_counter, table_name)
    report_string = '\nExecuted {0} SQL statements on table {1}'.format(sql_statement_counter, table_name)
    return sql_statement_counter

def update_aggstats():
    return_message = ''
    table_number = '46'
    table_name = 'aggstats'
    building_list = ['District Office']
    field_list = 'AdminPVs, Date, Enrollment, Hits, ID, NumSchools, PageViews, ParentHits, ParentLogins, ParentPVs, PG3Hits, PGIHits, PortalPVs, ReportQueueJobs, Server, ServerName, Server_InstanceID, StudentHits, StudentLogins, StudentPVs, TeacherPVs, Time, TotalPVs, TotLogins, Type'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_attendance():
    table_number = '157'
    table_name = 'attendance'
    building_list = ['Lincoln Early Childhood Center','Redner Elementary','Brick Elementary','Lincoln Middle School','Lincoln High School','Lincoln Multi Age','Childs Elementary','Model Elementary School']
    search_criteria = ['Att_Date','>','03/20/2012']
    field_list = 'ADA_Value_Code, ADA_Value_Time, ADM_Value, Attendance_CodeID, Att_Comment, Att_Date, Att_Flags, Att_Interval, Att_Mode_Code, Calendar_DayID, CCID, ID, Lock_Reporting_YN, Lock_Teacher_YN, Parent_AttendanceID, PeriodID, ProgramID, Prog_Crse_Type, SchoolID, StudentID, Total_Minutes, Transaction_Type, YearID'
    return_message = download_table(table_number, table_name, field_list, building_list,search_criteria)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list,False)
    return counter

def update_attendance_code():
    table_number = '156'
    table_name = 'attendance_code'
    building_list = ['District Office']
    field_list = 'Alternate_Code,Assignment_Filter_YN,Att_Code,AttendanceCodeInfo_guid,Calculate_ADA_YN,Calculate_ADM_YN,Course_Credit_Points,Description,ID,Presence_Status_CD,SchoolID,SortOrder,Unused1,YearID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list,False)
    return counter

def update_attendance_taken():
    table_number = '172'
    table_name = 'attendance_taken'
    building_list = ['Lincoln Early Childhood Center','Redner Elementary','Brick Elementary','Lincoln Middle School','Lincoln High School','Lincoln Multi Age','Childs Elementary','Model Elementary School']
    search_criteria = ['Att_Date','>','09/01/2011']
    field_list = 'Att_Date,Att_Interval,Att_Taken_Dt,ID,PeriodID,SectionID'
    return_message = download_table(table_number, table_name, field_list, building_list,search_criteria)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list,False)
    return counter

def update_cc():
    table_number = '4'
    table_name = 'cc'
    building_list = ['Lincoln Early Childhood Center','Redner Elementary','Brick Elementary','Lincoln Middle School','Lincoln High School','Lincoln Multi Age','Childs Elementary','Model Elementary School']
    search_criteria = ['DateEnrolled','>','08/20/2011']
    field_list = 'AB_Course_Cmp_Ext_Crd,AB_Course_Cmp_Fun_Flg,AB_Course_Cmp_Met_Cd,AB_Course_Cmp_Sta_Cd,AB_Course_Eva_Pro_Cd,AsmtScores,Attendance,Attendance_Type_Code,Course_Number,CurrentAbsences,CurrentTardies,Custom,DateEnrolled,DateLeft,Expression,FinalGrades,FirstAttDate,ID,LastAttMod,LastGradeUpdate,Log,OrigSectionID,Period_Obsolete,SchoolID,SectionID,Section_Number,StudentID,StudentSectEnrl_guid,StudYear,TeacherComment,TeacherID,TeacherPrivateNote,TermID,Unused2,Unused3'
    return_message = download_table(table_number, table_name, field_list, building_list,search_criteria)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list,False)
    return counter

def update_courses():
    table_number = '2'
    table_name = 'courses'
    building_list = ['District Office']
    field_list = 'Add_to_GPA,alt_course_number,Code,Corequisites,Course_Name,Course_Number,Credit_Hours,CreditType,CrHrWeight,Custom,Exclude_ADA,ExcludeFromClassRank,ExcludeFromGPA,ExcludeFromHonorRoll,GPA_AddedValue,GradeScaleID,ID,MaxClassSize,MI_Course_ID,MI_Course_Type,MI_Subject_Area_Code,MI_TSDL_Exclude,Multiterm,PowerLink,PowerLinkSpan,Prerequisites,ProgramID,RegAvailable,RegCourseGroup,RegGradeLevels,RegTeachers,Sched_BalancePriority,Sched_BalanceTerms,Sched_BlockStart,Sched_CloseSectionAfterMax,Sched_ConcurrentFlag,Sched_ConsecutivePeriods,Sched_ConsecutiveTerms,Sched_CoursePackage,Sched_CoursePkgContents,Sched_CourseSubjectAreaCode,Sched_Department,Sched_Do_Not_Print,Sched_ExtraDayScheduleTypeCode,Sched_Facilities,Sched_Frequency,Sched_FullCatalogDescription,Sched_GlobalSubstitution1,Sched_GlobalSubstitution2,Sched_GlobalSubstitution3,Sched_LabFlag,Sched_LabFrequency,Sched_LabPeriodsPerMeeting,Sched_LengthInNumberOfTerms,Sched_LoadPriority,Sched_LoadType,Sched_LunchCourse,Sched_MaximumDaysPerCycle,Sched_MaximumEnrollment,Sched_MaximumPeriodsPerDay,Sched_MinimumDaysPerCycle,Sched_MinimumPeriodsPerDay,Sched_MultipleRooms,Sched_PeriodsPerCycle,Sched_PeriodsPerMeeting,Sched_RepeatsAllowed,Sched_Scheduled,Sched_ScheduleTypeCode,Sched_SectionsOffered,Sched_SubstitutionAllowed,Sched_TeacherCount,Sched_UsePreEstablishedTeams,Sched_UseSectionTypes,Sched_ValidDayCombinations,Sched_ValidExtraDayCombinations,Sched_ValidStartPeriods,Sched_Year,SchoolGroup,SchoolID,SectionsToOffer,Status,TargetClassSize,TermsOffered,Vocational'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_graduation_requirements():
    table_number = '37'
    table_name = 'gradreq'
    building_list = ['Lincoln High School']
    field_list = 'AppliesTo,AppliesToData,AppliesToDataLi,AppliesToDisp,Classification,CountInReqTots,CourseDesig,CourseGroup,CourseListCheck,CourseListHTML,CourseListOrder,CourseListT,CourseSource,CreditType,Description,EntryBoxHeight,EntryBoxWidth,FieldComparator,FieldMatchValue,FieldName,FirstItem,Grade_Level,GradReqSetID,How2DispCourses,ID,ItemType,ListBoxHeight,MaxNoOfCourses,MinimumMessage,MinNoOfCourses,MultiTerm,Name,OverallCrHrs,ReqCrHrs,ReqForGrad,ReqTerms,RequestType,SchedPriority,SchoolID,SortOrder,SubjectArea,Subtype,Type'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_graduation_requirements_sets():
    table_number = '57'
    table_name = 'gradreqsets'
    building_list = ['Lincoln High School']
    field_list = 'GradReqSetID,Name,SchoolID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_log():
    table_number = '8'
    table_name = 'log'
    building_list = ['District Office']
    field_list = 'Category,Consequence,Custom,Discipline_ActionDate,Discipline_ActionTaken,Discipline_ActionTakenDetail,Discipline_ActionTakenEndDate,Discipline_AdministratorID,Discipline_AlcoholRelatedFlag,Discipline_DrugRelatedFlag,Discipline_DrugTypeDetail,Discipline_DurationActual,Discipline_DurationAssigned,Discipline_DurationChangeSource,Discipline_DurationNotes,Discipline_FelonyFlag,Discipline_GangRelatedFlag,Discipline_HateCrimeFlag,Discipline_HearingOfficerFlag,Discipline_IncidentContext,Discipline_IncidentDate,Discipline_IncidentLocation,Discipline_IncidentLocDetail,Discipline_IncidentType,Discipline_IncidentTypeCategory,Discipline_IncidentTypeDetail,Discipline_LikelyInjuryFlag,Discipline_MoneyLossValue,Discipline_Offender,Discipline_PoliceInvolvedFlag,Discipline_Reporter,Discipline_ReporterID,Discipline_SchoolRulesVioFlag,Discipline_Sequence,Discipline_VictimType,Discipline_WeaponRelatedFlag,Discipline_WeaponType,Discipline_WeaponTypeNotes,Entry,Entry_Author,Entry_Date,Entry_Time,ID,LogTypeID,SchoolID,StudentID,Student_Number,Subject,Subtype,TeacherID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_period():
    table_number = '138'
    table_name = 'period'
    building_list = ['District Office']
    field_list = 'Abbreviation,ID,Name,Period_Number,SchoolID,Sort_Order,Year_ID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_schedulecatalogs():
    table_number = '109'
    table_name = 'schedulecatalogs'
    building_list = ['District Office']
    field_list = 'Current,Description,ID,Name,SchoolID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_schedulecc():
    table_number = '111'
    table_name = 'schedulecc'
    building_list = ['District Office']
    field_list = 'Bitmap,BuildID,Course_Number,DateEnrolled,DateLeft,Expression,ID,LoadLock,Period,SchoolID,SectionID,SectionType,Section_Number,StudentID,StudYear,TeacherID,TermID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_schedulecoursecatalogs():
    table_number = '107'
    table_name = 'schedulecoursecatalogs'
    building_list = ['District Office']
    field_list = 'Add_to_GPA,Code,Corequisites,CourseCatalogID,Course_Name,Course_Number,CreditType,Credit_Hours,CrHrWeight,Custom,GradeScaleID,ID,MaxClassSize,Multiterm,PowerLink,PowerLinkSpan,Prerequisites,RegAvailable,RegCourseGroup,RegGradeLevels,RegTeachers,Sched_BalancePriority,Sched_BalanceTerms,Sched_BlockStart,Sched_CloseSectionAfterMax,Sched_ConcurrentFlag,Sched_ConsecutivePeriods,Sched_ConsecutiveTerms,Sched_CoursePackage,Sched_CoursePkgContents,Sched_CourseSubjectAreaCode,Sched_Demand,Sched_Department,Sched_Do_Not_Print,Sched_ExtraDayScheduleTypeCode,Sched_Facilities,Sched_Frequency,Sched_FullCatalogDescription,Sched_GlobalSubstitution1,Sched_GlobalSubstitution2,Sched_GlobalSubstitution3,Sched_LabFlag,Sched_LabFrequency,Sched_LabPeriodsPerMeeting,Sched_LengthInNumberOfTerms,Sched_LoadPriority,Sched_LoadType,Sched_LunchCourse,Sched_MaximumDaysPerCycle,Sched_MaximumEnrollment,Sched_MaximumPeriodsPerDay,Sched_MinimumDaysPerCycle,Sched_MinimumPeriodsPerDay,Sched_MinRoomCapacity,Sched_MultipleRooms,Sched_OverlapAllowed,Sched_PeriodsPerCycle,Sched_PeriodsPerMeeting,Sched_PrepCode,Sched_Rank,Sched_RepeatsAllowed,Sched_Scheduled,Sched_ScheduleTypeCode,Sched_SectionsOffered,Sched_SubstitutionAllowed,Sched_TeacherCount,Sched_TotalConflictCourses,Sched_TotalConflictStudents,Sched_UsePreEstablishedTeams,Sched_UseSectionTypes,Sched_ValidDayCombinations,Sched_ValidExtraDayCombinations,Sched_ValidStartPeriods,Sched_Year,SchoolCrseInfo_guid,SchoolGroup,SchoolID,SectionsToOffer,Status,TargetClassSize,TermsOffered,Vocational,YearID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_scheduledepartments():
    table_number = '69'
    table_name = 'scheduledepartments'
    building_list = ['District Office']
    field_list = 'Description,ID,SchoolID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_scheduleperiods():
    table_number = '80'
    table_name = 'scheduleperiods'
    building_list = ['District Office']
    field_list = 'Abbr,BlockStart,BuildID,CorePeriod,Description,EndTime1,EndTime2,ID,PeriodID,PeriodNumber,ScheduleID,ScheduleStudies,SchoolID,Sort,StartTime1,StartTime2,UseForBuild,UseForLunches'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_sections():
    table_number = '3'
    table_name = 'sections'
    building_list = ['District Office']
    field_list = 'Att_Mode_Code,Attendance,Attendance_Type_Code,Bitmap,BlockPeriods_Obsolete,BuildID,CampusID,CCRNArray,Comment,Course_Number,Custom,Days_Obsolete,Dependent_Secs,DistUniqueID,Exclude_ADA,Exclude_State_Rpt_YN,ExcludeFromClassRank,ExcludeFromGPA,ExcludeFromHonorRoll,ExcludeFromStoredGrades,Expression,FastPerList,Grade_Level,GradeProfile,GradeScaleID,House,ID,Instruction_Lang,LastAttUpdate,Log,Max_Load_Status,MaxCut,MaxEnrollment,No_of_students,NoOfTerms,Original_Expression,Parent_Section_ID,Period_Obsolete,PGFlags,PGVersion,ProgramID,Room,RosterModSer,ScheduleSectionID,SchoolID,Section_Number,Section_Type,SectionInfo_guid,SortOrder,Teacher,TeacherDescr,Team,TermID,TrackTeacherAtt,WhereTaught,WhereTaughtDistrict'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_stored_grades():
    table_number = '31'
    table_name = 'storedgrades'
    building_list = ['District Office']
    search_criteria = ['DateStored','>','09/01/2007']
    field_list = 'AB_Course_Cmp_Ext_Crd,AB_Course_Cmp_Fun_Flg,AB_Course_Cmp_Fun_Sch,AB_Course_Cmp_Met_Cd,AB_Course_Cmp_Sta_Cd,AB_Course_Eva_Pro_Cd,AB_Dipl_Exam_Mark,AB_Final_Mark,AB_Lng_Cd,AB_Pri_Del_Met_Cd,Absences,Behavior,Comment,Course_Equiv,Course_Name,Course_Number,Credit_Type,Custom,DateStored,EarnedCrHrs,ExcludeFromClassRank,ExcludeFromGPA,ExcludeFromHonorRoll,GPA_AddedValue,GPA_Custom1,GPA_Custom2,GPA_Points,Grade,Grade_Level,GradeScale_Name,IsEarnedCrHrsFromGB,IsPotentialCrHrsFromGB,Log,Percent,PotentialCrHrs,SchoolID,SchoolName,SectionID,StoreCode,StudentID,Tardies,Teacher_Name,TermID'
    return_message = download_table(table_number, table_name, field_list, building_list,search_criteria)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list,False)
    return counter

def update_students():
    return_message = ''
    table_number = '1'
    table_name = 'students'
    building_list = ['District Office']
    field_list = 'Apartment_Number,Applic_Response_Recvd_Date,Applic_Submitted_Date,area,ATE_skill_cert,Building,BusNumberDropoff,BusNumberPickup,Bus_Route,Bus_Stop,CampusID,City,ClassOf,cnt1_city,cnt1_cphone,cnt1_custody,cnt1_email,cnt1_employer,cnt1_fname,cnt1_hphone,cnt1_lname,cnt1_recvmail,cnt1_rel,cnt1_state,cnt1_street,Cnt1_WPhone,cnt1_zip,cnt2_city,cnt2_cphone,cnt2_custody,cnt2_email,cnt2_employer,cnt2_fname,cnt2_hphone,cnt2_lname,cnt2_recvmail,cnt2_rel,cnt2_state,cnt2_street,Cnt2_WPhone,cnt2_zip,Cumulative_GPA,Cumulative_Pct,CustomRank_GPA,dateOfEntryIntoUSA,DistrictEntryDate,DistrictEntryGradeLevel,DistrictOfResidence,DOB,ecnt1_city,ecnt1_custody,ecnt1_email,ecnt1_fname,ecnt1_hphone,ecnt1_lname,ecnt1_recvmail,ecnt1_state,ecnt1_street,ecnt1_WPhone,ecnt1_zip,ecnt2_city,ecnt2_cphone,ecnt2_custody,ecnt2_email,ecnt2_fname,ecnt2_hphone,ecnt2_lname,ecnt2_recvmail,ecnt2_rel,ecnt2_state,ecnt2_street,ecnt2_WPhone,ecnt2_zip,eecnt1_cphone,eecnt1_rel,Emerg_1_Ptype,Emerg_1_Rel,Emerg_2_Ptype,Emerg_2_Rel,Emerg_3_Phone,Emerg_3_Ptype,Emerg_3_Rel,Emerg_Contact_1,Emerg_Contact_2,Emerg_Contact_3,Emerg_Phone_1,Emerg_Phone_2,EnrollmentCode,EnrollmentType,Enrollment_SchoolID,Enrollment_Transfer_Date_Pend,Enrollment_Transfer_Info,Enroll_Status,EntryCode,EntryDate,ESL_placement,Ethnicity,Exclude_fr_rank,ExitCode,ExitComment,ExitDate,eye_data,Family_Ident,Father,fatherdayphone,Father_Employer,Father_home_phone,Father_StudentCont_guid,FedEthnicity,FedRaceDecline,Fee_Exemption_Status,First_Name,FTEID,Gender,Geocode,Grade_Level,GradReqSet,GradReqSetID,Graduated_Rank,Graduated_SchoolID,Graduated_SchoolName,graduation_year,guardian,guardiandayphone,GuardianEmail,GuardianFax,guardianship,Guardian_FN,Guardian_LN,Guardian_MN,Guardian_StudentCont_guid,hearing_data,height_data,homeless,homeless_code,Home_Phone,Home_Room,House,ID,ILDP,include_time_share,IsSpecialEdEligible,LastFirst,LastMeal,Last_Name,LDAPEnabled,LEP_exit_date,LEP_status,Locker_Combination,Locker_Number,Log,Lot_Number,LPAC_date,LunchStatus,Lunch_ID,Mailing_City,Mailing_Geocode,Mailing_State,Mailing_Street,Mailing_Zip,meis_attendance,meis_fte_in_gen_ed,MembershipShare,Middle_Name,MI_ECDaysPerWeek,MI_ECDaysPerWeek2,MI_ECDeliveryMethod,MI_ECDeliveryMethod2,MI_ECHoursPerDay,MI_ECHoursPerDay2,MI_ECProgramEndDate,MI_ECProgramEndDate2,MI_ECProgramStartDate,MI_ECProgramStartDate2,MI_EI_EligibilityCode,MI_EI_ExitCode,MI_EI_ExitDate,MI_EI_IFSPDate,MI_EI_PartBEligible,MI_EI_PrimarySetting,MI_EI_Service1,MI_EI_Service2,MI_EI_Service3,MI_EI_Service4,MI_ethnAfr,MI_ethnAsi,MI_ethnInd,MI_ethnLat,MI_ethnPac,MI_ethnWhi,MI_Father_Cust_No,MI_FiscalEntityCode,MI_FiscalEntityTypeCode,MI_LEP_CountryOrigin,MI_LEP_Enrollment,MI_LEP_ExitCode,MI_LEP_ExitDate,MI_LEP_LocFundPgm,MI_LEP_PrimaryLanguage,MI_LEP_Pupil_LimEng,MI_LEP_Refugee_ImpPgm,MI_LEP_Title3,MI_LEP_Title3_ImmEd,MI_LunchStatAppFlag,MI_Mother_Cust_No,MI_MultipleBirth,MI_Resident_County_Code,MI_SCMOperISDESANum,MI_Setting,MI_SpEd_AdditionalDisability,MI_SpEd_ExitCode,MI_SpEd_ExitDate,MI_SpEd_FTE52,MI_SpEd_FTE53,MI_SpEd_Hours,MI_SpEd_IEPAnotherDistrict,MI_SpEd_IEPDate,MI_SpEd_IEPDays,MI_SpEd_ParenConsEval,MI_SpEd_PrgmServiceCode1,MI_SpEd_PrgmServiceCode2,MI_SpEd_PrgmServiceCode3,MI_SpEd_PrimaryDisability,MI_SpEd_PrimaryEdSetting,MI_SpEd_ResofIIEP,MI_SpEd_SupportServices1,MI_SpEd_SupportServices2,MI_SpEd_SupportServices3,MI_SpEd_SupportServices4,MI_SpEd_SupportServices5,MI_SRSD_10_30_DayRule,MI_SRSD_AdminUnit,MI_SRSD_BirthCity,MI_SRSD_Early_Middle_College,MI_SRSD_PrgmElig_504,MI_SRSD_PrgmElig_EarlyIntervention,MI_SRSD_PrgmElig_LEP,MI_SRSD_PrgmElig_SpEd,MI_SRSD_PrgmElig_Title1,MI_SRSD_StudentUIC,MI_SRSD_StudResLEANum,MI_SRSD_StudResMembership,MI_StdntExplus_ExpelDate,MI_StdntExplus_ExpelFollowup,MI_StdntExplus_ExpelLength,MI_StdntExplus_IncidentDate,MI_StdntExplus_IncidentLocation,MI_StdntExplus_IncidentPrimaryVictim,MI_StdntExplus_IncidentTime,MI_Unaccompanied_Youth,monitor_date,Mother,motherdayphone,Mother_Employer,Mother_home_phone,Mother_StudentCont_guid,Name_Suffix,Next_School,parttimestudent,Person_ID,Phone_ID,PhotoFlag,PL_Language,PO_Box,prevstudentid,SAT,Sched_LoadLock,Sched_LockStudentSchedule,Sched_NextYearBuilding,Sched_NextYearBus,Sched_NextYearGrade,Sched_NextYearHomeRoom,Sched_NextYearHouse,Sched_NextYearTeam,Sched_Priority,Sched_Scheduled,Sched_YearOfGraduation,SchoolEntryDate,SchoolEntryGradeLevel,SchoolID,SDataRN,secondarylanguage,Simple_GPA,Simple_PCT,singleparenthshldflag,Sports_LHS,SSN,State,State_EnrollFlag,State_ExcludeFromReporting,State_StudentNumber,Street,StudentPers_guid,StudentPict_guid,StudentSchlEnrl_guid,Student_AllowWebAccess,student_email,Student_Number,Student_Web_ID,Student_Web_Password,SummerSchoolID,SummerSchoolNote,TeacherGroupID,Team,Track,Tracker,TransferComment,TuitionPayer,Var1,Var2,varicella,Volleyball_7gr_girls,Web_ID,Web_Password,weight_data,Withdrawal_Reason_Code,WM_Address,WM_CreateDate,WM_CreateTime,WM_Password,WM_Status,WM_StatusDate,WM_TA_Date,WM_TA_Flag,WM_Tier,Zip'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter

def update_teachers():
    table_number = '5'
    table_name = 'teachers'
    building_list = ['District Office']
    field_list = 'Access, AdminLDAPEnabled, AllowLoginEnd, AllowLoginStart, Balance1, Balance2, Balance3, Balance4, CanChangeSchool, City, Classpua, DefaultStudScrn, dob, Email_Addr, Ethnicity, FedEthnicity, FedRaceDecline, First_Name, gender, GradebookType, HomePage, Homeroom, Home_Phone, ID, IPAddrRestrict, LastFirst, LastMeal, Last_Name, LoginID, Lunch_ID, Maximum_Load, Middle_Name, MI_ethnAfr, MI_ethnAsi, MI_ethnInd, MI_ethnLat, MI_ethnPac, MI_ethnWhi, MI_REP_PIC, NameAsImported, NoOfCurClasses, NumLogins, Password, PeriodsAvail, Photo, PowerGradePW, PreferredName, PSAccess, REPDtTermEmp, REPEmpStat, REPHighDeg, Sched_ActivityStatusCode, Sched_BuildingCode, Sched_Classroom, Sched_Department, Sched_Gender, Sched_Homeroom, Sched_HouseCode, Sched_IsTeacherFree, Sched_Lunch, Sched_MaximumConsecutive, Sched_MaximumCourses, Sched_MaximumDuty, Sched_MaximumFree, Sched_MaxPers, Sched_MaxPreps, Sched_PrimarySchoolCode, Sched_Scheduled, Sched_Substitute, Sched_TeacherMoreOneSchool, Sched_Team, Sched_TotalCourses, Sched_UseBuilding, Sched_UseHouse, SchoolID, School_Phone, SIF_StatePrid, SSN, StaffPers_guid, StaffStatus, State, Status, Street, supportContact, TeacherLDAPEnabled, TeacherLoginID, TeacherLoginIP, TeacherLoginPW, TeacherNumber, Title, WM_Address, WM_Alias, WM_CreateDate, WM_CreateTime, WM_Exclude, WM_Password, WM_Status, WM_StatusDate, WM_TA_Date, WM_TA_Flag, WM_Tier, Zip'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = insert_into_powerschool_mirror(table_name,field_list)
    return counter



if __name__ == "__main__":
    #unused_string = update_students()
    #unused_string = update_teachers()
    #unused_string = update_graduation_requirements()
    #unused_string = update_graduation_requirements_sets()
    #dump_table_to_archive('students')
    write_cnt_upload_file()
