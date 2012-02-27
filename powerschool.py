# this code requires at config file
# specify the path here
config_file_path = r'/home/orwig/Dropbox/lincoln_ubuntubot/ubuntubot.cfg'

from selenium import selenium
import ConfigParser
import logging
import os
import re
import string
import time
import unittest

config = ConfigParser.ConfigParser()
config.read([config_file_path])

config_server_root = config.get('powerschool', 'server_root')
config_pw_page = config.get('powerschool', 'pw_page')
config_user_password = config.get('powerschool', 'username_password')

whitelist = string.letters + string.digits + ' ' + '/' + '?' + '\\' + '\t' + '.' + '!' + '@' + '#' + '$' + '%' + '&' + '*' + '(' + ')' + '_' + '-' + '=' + '+' + ':' + ';' + '|' + '[' + ']' + '{' + '}' + '<' + '>' + '~' + '^' + '`'
date_finder = re.compile('([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4})')

# instantiate a browser and log into PowerSchool
sel = selenium('localhost', '4444', '*firefox', config_server_root)
sel.start()
sel.open(pw_page)
sel.type("password", username_password)
sel.click("//img[@alt='Enter']")
sel.wait_for_page_to_load("30000")

def dde():
    sel.click("id=navSetupSystem")
    sel.wait_for_page_to_load("30000")

def select_building(building_number):


def process_downloaded_table(downloaded_table_full_path, record_delimiter, email_body):
    downloaded_file_reader = open(downloaded_table_full_path,'r')
    raw_line_at_a_time = downloaded_file_reader.readlines()
    directory_name = os.path.dirname(downloaded_table_full_path)
    cleaned_file_name = 'cleaned_' + os.path.basename(downloaded_table_full_path)
    cleaned_file_path = os.path.join(directory_name, cleaned_file_name)
    clean_file_writer = open(cleaned_file_path,'w')

    line_counter = 0
    log_string = 'The file {0} appears to have {1} lines.'.format(downloaded_table_full_path, len(raw_line_at_a_time))
    for raw_line in raw_line_at_a_time:
        #print raw_line
        line_removed_line_breaks = raw_line.replace('\n', '')
        line_removed_carriage_returns = line_removed_line_breaks.replace('\r', '')
        line_removed_line_feeds = line_removed_carriage_returns.replace('\n','')
        line_removed_form_feeds = line_removed_line_feeds.replace('\f', '')
        line_characters_from_whitelist = characters_from_whitelist_only(line_removed_form_feeds)
        line_iso_date = date_finder.sub(convert_english_date_to_iso_date,line_characters_from_whitelist)
        line_blank_dates_converted = line_iso_date.replace('0/0/0','0000-00-00')
        # replacing |s with \n will put individual records on lines by themselves
        split_records = line_blank_dates_converted.replace(record_delimiter, '\n')
        #print split_records
        clean_file_writer.writelines(split_records)
        line_counter = line_counter + 1

    downloaded_file_reader.close()
    clean_file_writer.close()
    return cleaned_file_path, line_counter

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

def download_table(table_name, fieldDelimiter, recordDelimiter):
    # clear the download directory
    # We need to keep track of which table is already selected each time
    # we return to the DDE selection page.
    # If Selenium makes a choice that is already selected then
    # there is no page reload and Selenium will time out waiting for one
    # We'll use this variable to track table state ourselves. PowerSchool defaults to 1 (students)

    chosenTableNumber = '1'

    #if fileNameSplit[1] == '.table':
        


            #buildingsList = []
            #for field in fieldAtATime:

            #fieldsReader.close()
            #fieldSeparateLines = '\n'.join(fieldList)
            #print 'Created this field list for the PowerSchool interface:\n{0}'.format(fieldSeparateLines)
            #fieldCommaString = ','.join(fieldList)
            #print 'Created this string for use in SQL statements:\n{0}'.format(fieldCommaString)
            #print 'districtAtOnce = {0}'.format(districtAtOnce)
            #print 'deleteAndReplace = {0}'.format(deleteAndReplace)
            #print 'searchAllRecords = {0}'.format(searchAllRecords)

            ## This part will run once at the district level, or once for each building if done at the building level
            ## If done at the district level we'll just put 'District Office' in the list
            #sel.open("/admin/home.html")
            #print 'Length of buildingList is {0}'.format(len(buildingsList))
            #if len(buildingsList) == 0:
                #buildingsList = ['District Office']
                #print 'buildingsList was of zero length, so it was set to {0}'.format(buildingsList)
            #for buildingName in buildingsList:
                #sel.click("link=exact:School:")
                #sel.wait_for_page_to_load("30000")
                #buildingLabel = 'label=' + buildingName
                #print 'About to execute "sel.select("Schoolid", {0})"'.format(buildingLabel)
                #sel.select("Schoolid", buildingLabel)
                ##sel.wait_for_page_to_load("30000")
                #print 'About to execute "sel.click("attSubmitButton")"'
                #sel.click("attSubmitButton")
                #time.sleep(10)
                #print 'Navigating to DDE'
                #sel.click("link=System")
                #sel.wait_for_page_to_load("30000")
                #sel.click("link=Direct Database Export (DDE)")
                #sel.wait_for_page_to_load("30000")
                #if chosenTableNumber != tableNumber:
                    #print 'By dead rekoning, it appears table {0} is selected. Selecting {1} instead'.format(chosenTableNumber, tableNumber) 
                    #tableSelectorValue = 'value=' + str(tableNumber)
                    #sel.select("filenum", tableSelectorValue)
                    #sel.wait_for_page_to_load("45000")
                    ## we're going to assume our table is now selected so we'll change our state variable
                    #chosenTableNumber = tableNumber
                #sel.click("searchselectall")
                #sel.wait_for_page_to_load("30000")
                ## Check to see if a filter should be applied
                #if filterFieldName:
                    #sel.select('fieldnum_1', filterFieldName)
                    #sel.select('comparator1', filterOperator)
                    #sel.type('value', filterValue)
                    #print 'Ready to apply the filter {0} {1} {2}'.format(filterFieldName,filterOperator,filterValue)
                    #print 'Check to make sure the values are present'
                    #time.sleep(10)
                    #sel.click('search')
                    #print 'Sleeping for 15 seconds to make sure filtering is done'
                    #time.sleep(15)
                #sel.click("link=Export Records")
                #sel.wait_for_page_to_load("30000")
                #time.sleep(10)
                #sel.type("tt", fieldSeparateLines)
                #sel.select("fielddelim", "label=Other:")
                #sel.type("custfielddelim", fieldDelimiter)
                #sel.select("recdelim", "label=Other:")
                #sel.type("custrecdelim", recordDelimiter)
                #sel.click("columntitles")
                #sel.click("attSubmitButton")
                #print 'About to sleep for 15 seconds'
                #time.sleep(15)
                #print 'Done sleeping!'

                ## Check for presence of 'student.export.text.part'
                ## If it's there we keep waiting
                #pathToPartFile = os.path.join(browserDownloadDirectory, 'student.export.text.part')
                #while os.path.exists(pathToPartFile):
                    #print 'Sleeping 30 seconds while {0} exists'.format(pathToPartFile)
                    #time.sleep(30)
                #print 'The student.export.text.part file appears to be gone. Moving on . . .'
                #time.sleep(5)

                #pathToRawDownload = os.path.join(browserDownloadDirectory, 'student.export.text')
                #print 'pathToRawDownload is {0}'.format(pathToRawDownload)
                #renamedFileName = 'raw_export_' + tableName + '_' + buildingName + '.txt'
                #print 'renamedFileName is {0}'.format(renamedFileName)
                #pathToRenamedDownload = os.path.join(browserDownloadDirectory, renamedFileName)
                #print 'pathToRenamedDownload is {0}'.format(pathToRenamedDownload)

                #try:
                    #os.renames(pathToRawDownload, pathToRenamedDownload)
                #except:
                    #print 'Got the error {0}'.format(sys.exc_info()[0])

def download_students():
    table_number = 1

if __name__ == "__main__":
    dde()
