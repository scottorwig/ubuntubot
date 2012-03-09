# this code requires at config file
# specify the path here
config_file_path = r'/home/orwig/Dropbox/lincoln_ubuntubot/ubuntubot.cfg'

from selenium import selenium
from selenium import webdriver
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException
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
browser_download_directory = config.get('vlad', 'download_directory')
browser_partial_download = os.path.join(browser_download_directory,'student.export.text.part')

whitelist = string.letters + string.digits + ' ' + '/' + '?' + '\\' + '\t' + '.' + '!' + '@' + '#' + '$' + '%' + '&' + '*' + '(' + ')' + '_' + '-' + '=' + '+' + ':' + ';' + '|' + '[' + ']' + '{' + '}' + '<' + '>' + '~' + '^' + '`'
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

# instantiate a browser and log into PowerSchool
#sel = selenium('localhost', '4444', '*firefox', config_server_root)
#sel.start()
#sel.open(config_pw_page)
#sel.type("password", config_user_password)
#sel.click("id=btnEnter")
#sel.wait_for_page_to_load("30000")


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



#def download_table(table_name, fieldDelimiter, recordDelimiter):
    # clear the download directory
    # We need to keep track of which table is already selected each time
    # we return to the DDE selection page.
    # If Selenium makes a choice that is already selected then
    # there is no page reload and Selenium will time out waiting for one
    # We'll use this variable to track table state ourselves. PowerSchool defaults to 1 (students)

    #chosenTableNumber = '1'

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


def download_table(table_number, table_name, field_list, delete_all=False, buildings='all'):
    field_list_newlines = field_list.replace(',','\n')

    # Clear out partial downloads and anything related to the current table
    for file_name in os.listdir(browser_download_directory):
        if (table_name in file_name) or ('part' in file_name):
            os.remove(file_name)

    profile = webdriver.firefox.firefox_profile.FirefoxProfile(profile_directory='/home/orwig/.mozilla/firefox/sri96odi.SeleniumProfile')
    driver = webdriver.Firefox(firefox_profile=profile)
    driver.implicitly_wait(30)
    base_url = config_server_root
    url_of_admin_page = base_url + config_pw_page
    print 'About to get {0}'.format(url_of_admin_page)
    driver.get(url_of_admin_page)
    driver.find_element_by_id("fieldPassword").clear()
    driver.find_element_by_id("fieldPassword").send_keys(config_user_password)
    driver.find_element_by_id("btnEnter").click()
    driver.find_element_by_id("navSetupSystem").click()
    driver.find_element_by_link_text("Direct Database Export (DDE)").click()
    driver.find_element_by_name("searchselectall").click()
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
    driver.find_element_by_id("btnSubmit").click()

    while os.path.exists(browser_partial_download):
        print '{0} exists. Waiting.'.format(browser_partial_download)
        time.sleep(30)

    print 'About to wait 60 seconds'
    time.sleep(60)
    driver.quit()

def download_students():
    table_number = 1
    table_name = 'students'
    field_list = 'Apartment_Number,Applic_Response_Recvd_Date,Applic_Submitted_Date,area,ATE_skill_cert,Building,BusNumberDropoff,BusNumberPickup,Bus_Route,Bus_Stop,CampusID,City,ClassOf,cnt1_city,cnt1_cphone,cnt1_custody,cnt1_email,cnt1_employer,cnt1_fname,cnt1_hphone,cnt1_lname,cnt1_recvmail,cnt1_rel,cnt1_state,cnt1_street,Cnt1_WPhone,cnt1_zip,cnt2_city,cnt2_cphone,cnt2_custody,cnt2_email,cnt2_employer,cnt2_fname,cnt2_hphone,cnt2_lname,cnt2_recvmail,cnt2_rel,cnt2_state,cnt2_street,Cnt2_WPhone,cnt2_zip,Cumulative_GPA,Cumulative_Pct,CustomRank_GPA,dateOfEntryIntoUSA,DistrictEntryDate,DistrictEntryGradeLevel,DistrictOfResidence,DOB,ecnt1_city,ecnt1_custody,ecnt1_email,ecnt1_fname,ecnt1_hphone,ecnt1_lname,ecnt1_recvmail,ecnt1_state,ecnt1_street,ecnt1_WPhone,ecnt1_zip,ecnt2_city,ecnt2_cphone,ecnt2_custody,ecnt2_email,ecnt2_fname,ecnt2_hphone,ecnt2_lname,ecnt2_recvmail,ecnt2_rel,ecnt2_state,ecnt2_street,ecnt2_WPhone,ecnt2_zip,eecnt1_cphone,eecnt1_rel,Emerg_1_Ptype,Emerg_1_Rel,Emerg_2_Ptype,Emerg_2_Rel,Emerg_3_Phone,Emerg_3_Ptype,Emerg_3_Rel,Emerg_Contact_1,Emerg_Contact_2,Emerg_Contact_3,Emerg_Phone_1,Emerg_Phone_2,EnrollmentCode,EnrollmentType,Enrollment_SchoolID,Enrollment_Transfer_Date_Pend,Enrollment_Transfer_Info,Enroll_Status,EntryCode,EntryDate,ESL_placement,Ethnicity,Exclude_fr_rank,ExitCode,ExitComment,ExitDate,eye_data,Family_Ident,Father,fatherdayphone,Father_Employer,Father_home_phone,Father_StudentCont_guid,FedEthnicity,FedRaceDecline,Fee_Exemption_Status,First_Name,FTEID,Gender,Geocode,Grade_Level,GradReqSet,GradReqSetID,Graduated_Rank,Graduated_SchoolID,Graduated_SchoolName,graduation_year,guardian,guardiandayphone,GuardianEmail,GuardianFax,guardianship,Guardian_FN,Guardian_LN,Guardian_MN,Guardian_StudentCont_guid,hearing_data,height_data,homeless,homeless_code,Home_Phone,Home_Room,House,ID,ILDP,include_time_share,IsSpecialEdEligible,LastFirst,LastMeal,Last_Name,LDAPEnabled,LEP_exit_date,LEP_status,Locker_Combination,Locker_Number,Log,Lot_Number,LPAC_date,LunchStatus,Lunch_ID,Mailing_City,Mailing_Geocode,Mailing_State,Mailing_Street,Mailing_Zip,meis_attendance,meis_fte_in_gen_ed,MembershipShare,Middle_Name,MI_ECDaysPerWeek,MI_ECDaysPerWeek2,MI_ECDeliveryMethod,MI_ECDeliveryMethod2,MI_ECHoursPerDay,MI_ECHoursPerDay2,MI_ECProgramEndDate,MI_ECProgramEndDate2,MI_ECProgramStartDate,MI_ECProgramStartDate2,MI_EI_EligibilityCode,MI_EI_ExitCode,MI_EI_ExitDate,MI_EI_IFSPDate,MI_EI_PartBEligible,MI_EI_PrimarySetting,MI_EI_Service1,MI_EI_Service2,MI_EI_Service3,MI_EI_Service4,MI_ethnAfr,MI_ethnAsi,MI_ethnInd,MI_ethnLat,MI_ethnPac,MI_ethnWhi,MI_Father_Cust_No,MI_FiscalEntityCode,MI_FiscalEntityTypeCode,MI_LEP_CountryOrigin,MI_LEP_Enrollment,MI_LEP_ExitCode,MI_LEP_ExitDate,MI_LEP_LocFundPgm,MI_LEP_PrimaryLanguage,MI_LEP_Pupil_LimEng,MI_LEP_Refugee_ImpPgm,MI_LEP_Title3,MI_LEP_Title3_ImmEd,MI_LunchStatAppFlag,MI_Mother_Cust_No,MI_MultipleBirth,MI_Resident_County_Code,MI_SCMOperISDESANum,MI_Setting,MI_SpEd_AdditionalDisability,MI_SpEd_ExitCode,MI_SpEd_ExitDate,MI_SpEd_FTE52,MI_SpEd_FTE53,MI_SpEd_Hours,MI_SpEd_IEPAnotherDistrict,MI_SpEd_IEPDate,MI_SpEd_IEPDays,MI_SpEd_ParenConsEval,MI_SpEd_PrgmServiceCode1,MI_SpEd_PrgmServiceCode2,MI_SpEd_PrgmServiceCode3,MI_SpEd_PrimaryDisability,MI_SpEd_PrimaryEdSetting,MI_SpEd_ResofIIEP,MI_SpEd_SupportServices1,MI_SpEd_SupportServices2,MI_SpEd_SupportServices3,MI_SpEd_SupportServices4,MI_SpEd_SupportServices5,MI_SRSD_10_30_DayRule,MI_SRSD_AdminUnit,MI_SRSD_BirthCity,MI_SRSD_Early_Middle_College,MI_SRSD_PrgmElig_504,MI_SRSD_PrgmElig_EarlyIntervention,MI_SRSD_PrgmElig_LEP,MI_SRSD_PrgmElig_SpEd,MI_SRSD_PrgmElig_Title1,MI_SRSD_StudentUIC,MI_SRSD_StudResLEANum,MI_SRSD_StudResMembership,MI_StdntExplus_ExpelDate,MI_StdntExplus_ExpelFollowup,MI_StdntExplus_ExpelLength,MI_StdntExplus_IncidentDate,MI_StdntExplus_IncidentLocation,MI_StdntExplus_IncidentPrimaryVictim,MI_StdntExplus_IncidentTime,MI_Unaccompanied_Youth,monitor_date,Mother,motherdayphone,Mother_Employer,Mother_home_phone,Mother_StudentCont_guid,Name_Suffix,Next_School,parttimestudent,Person_ID,Phone_ID,PhotoFlag,PL_Language,PO_Box,prevstudentid,SAT,Sched_LoadLock,Sched_LockStudentSchedule,Sched_NextYearBuilding,Sched_NextYearBus,Sched_NextYearGrade,Sched_NextYearHomeRoom,Sched_NextYearHouse,Sched_NextYearTeam,Sched_Priority,Sched_Scheduled,Sched_YearOfGraduation,SchoolEntryDate,SchoolEntryGradeLevel,SchoolID,SDataRN,secondarylanguage,Simple_GPA,Simple_PCT,singleparenthshldflag,Sports_LHS,SSN,State,State_EnrollFlag,State_ExcludeFromReporting,State_StudentNumber,Street,StudentPers_guid,StudentPict_guid,StudentSchlEnrl_guid,Student_AllowWebAccess,student_email,Student_Number,Student_Web_ID,Student_Web_Password,SummerSchoolID,SummerSchoolNote,TeacherGroupID,Team,Track,Tracker,TransferComment,TuitionPayer,Var1,Var2,varicella,Volleyball_7gr_girls,Web_ID,Web_Password,weight_data,Withdrawal_Reason_Code,WM_Address,WM_CreateDate,WM_CreateTime,WM_Password,WM_Status,WM_StatusDate,WM_TA_Date,WM_TA_Flag,WM_Tier,Zip'
    download_table(1, 'students', field_list)

if __name__ == "__main__":
    download_students()
