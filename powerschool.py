# this code requires at config file
# specify the path here
config_file_path = r'/home/orwig/Dropbox/lincoln_ubuntubot/ubuntubot.cfg'

from selenium import selenium
from selenium import webdriver
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException
import configmanager
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
        #profile = webdriver.firefox.firefox_profile.FirefoxProfile(profile_directory='/home/orwig/selenium_code/firefox_profile')
        driver = webdriver.Chrome('/home/orwig/selenium_code/chromedriver') 
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

def update_powerschool_mirror(table_name, field_list, delete_and_replace=True):
    cleaned_file_name = table_name + '.clean_data'
    cleaned_file_path = os.path.join(browser_download_directory,cleaned_file_name)
    db_connection = MySQLdb.connect (host = db_host, user = db_user, passwd = db_password, db = db_name)
    cursor = db_connection.cursor ()
    if delete_and_replace:
        delete_statement = 'DELETE FROM ' + table_name
        print 'Executing delete statement "{0}"'.format(delete_statement)
        cursor.execute(delete_statement)
    else:
        print 'Existing records will not be deleted from {0}'.format(table_name)
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
    counter = update_powerschool_mirror(table_name,field_list)
    return counter

def update_attendance():
    table_number = '157'
    table_name = 'attendance'
    building_list = ['Lincoln Early Childhood Center','Redner Elementary','Brick Elementary','Lincoln Middle School','Lincoln High School','Lincoln Multi Age','Childs Elementary','Model Elementary School']
    search_criteria = ['Att_Date','>','03/20/2012']
    field_list = 'ADA_Value_Code, ADA_Value_Time, ADM_Value, Attendance_CodeID, Att_Comment, Att_Date, Att_Flags, Att_Interval, Att_Mode_Code, Calendar_DayID, CCID, ID, Lock_Reporting_YN, Lock_Teacher_YN, Parent_AttendanceID, PeriodID, ProgramID, Prog_Crse_Type, SchoolID, StudentID, Total_Minutes, Transaction_Type, YearID'
    return_message = download_table(table_number, table_name, field_list, building_list,search_criteria)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list,False)
    return counter

def update_attendance_code():
    table_number = '156'
    table_name = 'attendance_code'
    building_list = ['District Office']
    field_list = 'Alternate_Code,Assignment_Filter_YN,Att_Code,AttendanceCodeInfo_guid,Calculate_ADA_YN,Calculate_ADM_YN,Course_Credit_Points,Description,ID,Presence_Status_CD,SchoolID,SortOrder,Unused1,YearID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list,False)
    return counter

def update_attendance_taken():
    table_number = '172'
    table_name = 'attendance_taken'
    building_list = ['Lincoln Early Childhood Center','Redner Elementary','Brick Elementary','Lincoln Middle School','Lincoln High School','Lincoln Multi Age','Childs Elementary','Model Elementary School']
    search_criteria = ['Att_Date','>','09/01/2011']
    field_list = 'Att_Date,Att_Interval,Att_Taken_Dt,ID,PeriodID,SectionID'
    return_message = download_table(table_number, table_name, field_list, building_list,search_criteria)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list,False)
    return counter

def update_cc():
    table_number = '4'
    table_name = 'cc'
    building_list = ['Lincoln Early Childhood Center','Redner Elementary','Brick Elementary','Lincoln Middle School','Lincoln High School','Lincoln Multi Age','Childs Elementary','Model Elementary School']
    search_criteria = ['DateEnrolled','>','08/20/2011']
    field_list = 'AB_Course_Cmp_Ext_Crd,AB_Course_Cmp_Fun_Flg,AB_Course_Cmp_Met_Cd,AB_Course_Cmp_Sta_Cd,AB_Course_Eva_Pro_Cd,AsmtScores,Attendance,Attendance_Type_Code,Course_Number,CurrentAbsences,CurrentTardies,Custom,DateEnrolled,DateLeft,Expression,FinalGrades,FirstAttDate,ID,LastAttMod,LastGradeUpdate,Log,OrigSectionID,Period_Obsolete,SchoolID,SectionID,Section_Number,StudentID,StudentSectEnrl_guid,StudYear,TeacherComment,TeacherID,TeacherPrivateNote,TermID,Unused2,Unused3'
    return_message = download_table(table_number, table_name, field_list, building_list,search_criteria)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list,False)
    return counter

def update_courses():
    table_number = '2'
    table_name = 'courses'
    building_list = ['District Office']
    field_list = 'Add_to_GPA,alt_course_number,Code,Corequisites,Course_Name,Course_Number,Credit_Hours,CreditType,CrHrWeight,Custom,Exclude_ADA,ExcludeFromClassRank,ExcludeFromGPA,ExcludeFromHonorRoll,GPA_AddedValue,GradeScaleID,ID,MaxClassSize,MI_Course_ID,MI_Course_Type,MI_Subject_Area_Code,MI_TSDL_Exclude,Multiterm,PowerLink,PowerLinkSpan,Prerequisites,ProgramID,RegAvailable,RegCourseGroup,RegGradeLevels,RegTeachers,Sched_BalancePriority,Sched_BalanceTerms,Sched_BlockStart,Sched_CloseSectionAfterMax,Sched_ConcurrentFlag,Sched_ConsecutivePeriods,Sched_ConsecutiveTerms,Sched_CoursePackage,Sched_CoursePkgContents,Sched_CourseSubjectAreaCode,Sched_Department,Sched_Do_Not_Print,Sched_ExtraDayScheduleTypeCode,Sched_Facilities,Sched_Frequency,Sched_FullCatalogDescription,Sched_GlobalSubstitution1,Sched_GlobalSubstitution2,Sched_GlobalSubstitution3,Sched_LabFlag,Sched_LabFrequency,Sched_LabPeriodsPerMeeting,Sched_LengthInNumberOfTerms,Sched_LoadPriority,Sched_LoadType,Sched_LunchCourse,Sched_MaximumDaysPerCycle,Sched_MaximumEnrollment,Sched_MaximumPeriodsPerDay,Sched_MinimumDaysPerCycle,Sched_MinimumPeriodsPerDay,Sched_MultipleRooms,Sched_PeriodsPerCycle,Sched_PeriodsPerMeeting,Sched_RepeatsAllowed,Sched_Scheduled,Sched_ScheduleTypeCode,Sched_SectionsOffered,Sched_SubstitutionAllowed,Sched_TeacherCount,Sched_UsePreEstablishedTeams,Sched_UseSectionTypes,Sched_ValidDayCombinations,Sched_ValidExtraDayCombinations,Sched_ValidStartPeriods,Sched_Year,SchoolGroup,SchoolID,SectionsToOffer,Status,TargetClassSize,TermsOffered,Vocational'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list)
    return counter

def update_graduation_requirements():
    table_number = '37'
    table_name = 'gradreq'
    building_list = ['Lincoln High School']
    field_list = 'AppliesTo,AppliesToData,AppliesToDataLi,AppliesToDisp,Classification,CountInReqTots,CourseDesig,CourseGroup,CourseListCheck,CourseListHTML,CourseListOrder,CourseListT,CourseSource,CreditType,Description,EntryBoxHeight,EntryBoxWidth,FieldComparator,FieldMatchValue,FieldName,FirstItem,Grade_Level,GradReqSetID,How2DispCourses,ID,ItemType,ListBoxHeight,MaxNoOfCourses,MinimumMessage,MinNoOfCourses,MultiTerm,Name,OverallCrHrs,ReqCrHrs,ReqForGrad,ReqTerms,RequestType,SchedPriority,SchoolID,SortOrder,SubjectArea,Subtype,Type'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list)
    return counter

def update_graduation_requirements_sets():
    table_number = '57'
    table_name = 'gradreqsets'
    building_list = ['Lincoln High School']
    field_list = 'GradReqSetID,Name,SchoolID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list)
    return counter

def update_log():
    table_number = '8'
    table_name = 'log'
    building_list = ['District Office']
    field_list = 'Category,Consequence,Custom,Discipline_ActionDate,Discipline_ActionTaken,Discipline_ActionTakenDetail,Discipline_ActionTakenEndDate,Discipline_AdministratorID,Discipline_AlcoholRelatedFlag,Discipline_DrugRelatedFlag,Discipline_DrugTypeDetail,Discipline_DurationActual,Discipline_DurationAssigned,Discipline_DurationChangeSource,Discipline_DurationNotes,Discipline_FelonyFlag,Discipline_GangRelatedFlag,Discipline_HateCrimeFlag,Discipline_HearingOfficerFlag,Discipline_IncidentContext,Discipline_IncidentDate,Discipline_IncidentLocation,Discipline_IncidentLocDetail,Discipline_IncidentType,Discipline_IncidentTypeCategory,Discipline_IncidentTypeDetail,Discipline_LikelyInjuryFlag,Discipline_MoneyLossValue,Discipline_Offender,Discipline_PoliceInvolvedFlag,Discipline_Reporter,Discipline_ReporterID,Discipline_SchoolRulesVioFlag,Discipline_Sequence,Discipline_VictimType,Discipline_WeaponRelatedFlag,Discipline_WeaponType,Discipline_WeaponTypeNotes,Entry,Entry_Author,Entry_Date,Entry_Time,ID,LogTypeID,SchoolID,StudentID,Student_Number,Subject,Subtype,TeacherID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list)
    return counter

def update_period():
    table_number = '138'
    table_name = 'period'
    building_list = ['District Office']
    field_list = 'Abbreviation,ID,Name,Period_Number,SchoolID,Sort_Order,Year_ID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list)
    return counter

def update_sections():
    table_number = '3'
    table_name = 'sections'
    building_list = ['District Office']
    field_list = 'Att_Mode_Code,Attendance,Attendance_Type_Code,Bitmap,BlockPeriods_Obsolete,BuildID,CampusID,CCRNArray,Comment,Course_Number,Custom,Days_Obsolete,Dependent_Secs,DistUniqueID,Exclude_ADA,Exclude_State_Rpt_YN,ExcludeFromClassRank,ExcludeFromGPA,ExcludeFromHonorRoll,ExcludeFromStoredGrades,Expression,FastPerList,Grade_Level,GradeProfile,GradeScaleID,House,ID,Instruction_Lang,LastAttUpdate,Log,Max_Load_Status,MaxCut,MaxEnrollment,No_of_students,NoOfTerms,Original_Expression,Parent_Section_ID,Period_Obsolete,PGFlags,PGVersion,ProgramID,Room,RosterModSer,ScheduleSectionID,SchoolID,Section_Number,Section_Type,SectionInfo_guid,SortOrder,Teacher,TeacherDescr,Team,TermID,TrackTeacherAtt,WhereTaught,WhereTaughtDistrict'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list)
    return counter

def update_stored_grades():
    table_number = '33'
    table_name = 'storedgrades'
    building_list = ['District Office']
    search_criteria = ['DateStored','>','09/01/2011']
    field_list = 'Att_Mode_Code,Attendance,Attendance_Type_Code,Bitmap,BlockPeriods_Obsolete,BuildID,CampusID,CCRNArray,Comment,Course_Number,Custom,Days_Obsolete,Dependent_Secs,DistUniqueID,Exclude_ADA,Exclude_State_Rpt_YN,ExcludeFromClassRank,ExcludeFromGPA,ExcludeFromHonorRoll,ExcludeFromStoredGrades,Expression,FastPerList,Grade_Level,GradeProfile,GradeScaleID,House,ID,Instruction_Lang,LastAttUpdate,Log,Max_Load_Status,MaxCut,MaxEnrollment,No_of_students,NoOfTerms,Original_Expression,Parent_Section_ID,Period_Obsolete,PGFlags,PGVersion,ProgramID,Room,RosterModSer,ScheduleSectionID,SchoolID,Section_Number,Section_Type,SectionInfo_guid,SortOrder,Teacher,TeacherDescr,Team,TermID,TrackTeacherAtt,WhereTaught,WhereTaughtDistrict'
    return_message = download_table(table_number, table_name, field_list, building_list,search_criteria)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list)
    return counter

def update_students():
    return_message = ''
    table_number = '1'
    table_name = 'students'
    building_list = ['District Office']
    field_list = 'AB_Course_Cmp_Ext_Crd,AB_Course_Cmp_Fun_Flg,AB_Course_Cmp_Fun_Sch,AB_Course_Cmp_Met_Cd,AB_Course_Cmp_Sta_Cd,AB_Course_Eva_Pro_Cd,AB_Dipl_Exam_Mark,AB_Final_Mark,AB_Lng_Cd,AB_Pri_Del_Met_Cd,Absences,Behavior,Comment,Course_Equiv,Course_Name,Course_Number,Credit_Type,Custom,DateStored,EarnedCrHrs,ExcludeFromClassRank,ExcludeFromGPA,ExcludeFromHonorRoll,GPA_AddedValue,GPA_Custom1,GPA_Custom2,GPA_Points,Grade,Grade_Level,GradeScale_Name,IsEarnedCrHrsFromGB,IsPotentialCrHrsFromGB,Log,Percent,PotentialCrHrs,SchoolID,SchoolName,SectionID,StoreCode,StudentID,Tardies,Teacher_Name,TermID'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list)
    return counter

def update_teachers():
    table_number = '5'
    table_name = 'teachers'
    building_list = ['District Office']
    field_list = 'Access, AdminLDAPEnabled, AllowLoginEnd, AllowLoginStart, Balance1, Balance2, Balance3, Balance4, CanChangeSchool, City, Classpua, DefaultStudScrn, dob, Email_Addr, Ethnicity, FedEthnicity, FedRaceDecline, First_Name, gender, GradebookType, HomePage, Homeroom, Home_Phone, ID, IPAddrRestrict, LastFirst, LastMeal, Last_Name, LoginID, Lunch_ID, Maximum_Load, Middle_Name, MI_ethnAfr, MI_ethnAsi, MI_ethnInd, MI_ethnLat, MI_ethnPac, MI_ethnWhi, MI_REP_PIC, NameAsImported, NoOfCurClasses, NumLogins, Password, PeriodsAvail, Photo, PowerGradePW, PreferredName, PSAccess, REPDtTermEmp, REPEmpStat, REPHighDeg, Sched_ActivityStatusCode, Sched_BuildingCode, Sched_Classroom, Sched_Department, Sched_Gender, Sched_Homeroom, Sched_HouseCode, Sched_IsTeacherFree, Sched_Lunch, Sched_MaximumConsecutive, Sched_MaximumCourses, Sched_MaximumDuty, Sched_MaximumFree, Sched_MaxPers, Sched_MaxPreps, Sched_PrimarySchoolCode, Sched_Scheduled, Sched_Substitute, Sched_TeacherMoreOneSchool, Sched_Team, Sched_TotalCourses, Sched_UseBuilding, Sched_UseHouse, SchoolID, School_Phone, SIF_StatePrid, SSN, StaffPers_guid, StaffStatus, State, Status, Street, supportContact, TeacherLDAPEnabled, TeacherLoginID, TeacherLoginIP, TeacherLoginPW, TeacherNumber, Title, WM_Address, WM_Alias, WM_CreateDate, WM_CreateTime, WM_Exclude, WM_Password, WM_Status, WM_StatusDate, WM_TA_Date, WM_TA_Flag, WM_Tier, Zip'
    return_message = download_table(table_number, table_name, field_list, building_list)
    return_message = return_message + '\n' + process_downloaded_table(table_name)
    counter = update_powerschool_mirror(table_name,field_list)
    return counter



if __name__ == "__main__":
    unused_string = update_students()
    unused_string = update_teachers()
    unused_string = update_graduation_requirements()
    unused_string = update_graduation_requirements_sets()
