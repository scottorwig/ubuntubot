# this code requires at config file
# specify the path here
config_file_path = r'/home/orwig/Dropbox/lincoln_ubuntubot/ubuntubot.cfg'

import ConfigParser
import datetime
import MySQLdb
import os
import string
import time

config = ConfigParser.ConfigParser()
config.read([config_file_path])

destination_directory = config.get('follett', 'destination_directory')
file_name_base = 'follett_'


building_codes = [
    ['100','Model Media Center'],
    ['200','Redner Elem. Media Center'],
    ['300','Brick Media Center'], 
    ['400','Lincoln Middle School Library'], 
    ['500','Lincoln High Sch. Media Center'], 
    ['600','Bessie Hoffman Media Center'], 
    ['700','Childs Elementary School']
]

class Patron:
    """Class to store patron data in a list"""
    def __init__(self, Barcode, AlternateID, LastName, FirstName, MiddleName, CardExpirationDate, GradYear, BirthDate, Gender, Type, Status, Location1, Location2, UserField1, UserField2, AddressLine1, AddressLine2, City, State, Zip, Address1Email, Address1Phone1, Address1Phone2):
        self.Barcode = Barcode
        self.AlternateID = AlternateID
        self.LastName = LastName
        self.FirstName = FirstName
        self.MiddleName = MiddleName
        self.CardExpirationDate = CardExpirationDate
        self.GradYear = GradYear
        self.BirthDate = BirthDate
        self.Gender = Gender
        self.Type = Type
        self.Status = Status
        self.Location1 = Location1
        self.Location2 = Location2
        self.UserField1 = UserField1
        self.UserField2 = UserField2
        self.AddressLine1 = AddressLine1
        self.AddressLine2 = AddressLine2
        self.City = City
        self.State = State
        self.Zip = Zip
        self.Address1Email = Address1Email
        self.Address1Phone1 = Address1Phone1
        self.Address1Phone2 = Address1Phone2

def write_files(MySQLdb, buildingCodes, Patron, datetime):
    db_host = 'localhost'
    db_user = config.get('powerschoolmirror', 'user')
    db_password = config.get('powerschoolmirror', 'password')
    db_name = config.get('powerschoolmirror', 'database')
    conn = MySQLdb.connect (host = db_host,
                        user = db_user,
                        passwd = db_password,
                        db = db_name)


    for building in building_codes:
        patronList = []
        print 'Working on ' + building[0]
        building_name_no_spaces = building[1].replace(' ','_')
        building_name_no_dots = building_name_no_spaces.replace('.','_')
        file_name = file_name_base + building_name_no_dots + '.txt'
        file_path = os.path.join(destination_directory,file_name)
        file_writer = open(file_path, 'w')
        
        # get students
        studentSqlQuery = """SELECT CONCAT('P ',Student_Number) AS Barcode, Student_Number AS AlternateID, Last_Name, First_Name, Middle_Name, '20120630' AS CardExpirationDate, Sched_YearOfGraduation, CONCAT(MID(DOB,1,4),MID(DOB,6,2),MID(DOB,9,2)) AS Birthdate, Gender, 'S' AS PatronType, "A" AS PatronStatus, Home_Room AS Location1, '' AS Location2, '' AS UserField1, '' AS UserField2, Street AS Address1Line1, '' AS Address1Line2, City, State, Zip, cnt1_email AS Address1Email, Mother_home_phone AS Address1Phone1, ecnt1_hphone AS Address1Phone2 FROM students WHERE Enroll_Status = '0' AND SchoolID = '""" + building[0] + """' ORDER BY SchoolID"""
        print studentSqlQuery
        cursor = conn.cursor()
        cursor.execute(studentSqlQuery)
        result = cursor.fetchall()
        
        for record in result:
            additionalPatron = Patron(record[0] ,record[1] ,record[2] ,record[3] ,record[4] ,record[5] ,record[6] ,record[7] ,record[8] ,record[9] ,record[10] ,record[11] ,record[12] ,record[13] ,record[14] ,record[15] ,record[16] ,record[17] ,record[18] ,record[19] ,record[20] ,record[21] ,record[22])
            patronList.append(additionalPatron)
            
        # get teachers
        teacherSqlQuery = """SELECT CONCAT('P ',TeacherNumber) AS Barcode, TeacherNumber AS AlternateID, Last_Name, First_Name, Middle_Name, '' AS CardExpirationDate, '' AS GradYear, '' AS Birthdate, Gender, 'F' AS PatronType, "A" AS PatronStatus, '' AS Location1, '' AS Location2, '' AS UserField1, '' AS UserField2, Street AS Address1Line1, '' AS Address1Line2, City, State, Zip, Email_Addr AS Address1Email, School_Phone AS Address1Phone1, Home_Phone AS Address1Phone2 FROM teachers WHERE SchoolID = '""" + building[0] + """' ORDER BY SchoolID"""
        print teacherSqlQuery
        cursor = conn.cursor()
        cursor.execute(teacherSqlQuery)
        result = cursor.fetchall()
        
        for record in result:
            additionalPatron = Patron(record[0] ,record[1] ,record[2] ,record[3] ,record[4] ,record[5] ,record[6] ,record[7] ,record[8] ,record[9] ,record[10] ,record[11] ,record[12] ,record[13] ,record[14] ,record[15] ,record[16] ,record[17] ,record[18] ,record[19] ,record[20] ,record[21] ,record[22])
            patronList.append(additionalPatron)
            
        print 'Creating file ' + file_path
        todayDate = datetime.date.today()
        todayDateString = todayDate.strftime('%Y%m%d')
        topLine  = '"' + building[1] + '",'
        topLine += '"Patron Maintenance","4.00",'
        topLine += todayDateString  + ','
        topLine += str(len(patronList)) + ','
        topLine += '01,""'
        file_writer.write(topLine + '\r\n')
        for currentPatron in patronList:
            lineToWrite   = '"' + currentPatron.Barcode + '",'
            lineToWrite  += '"' + currentPatron.AlternateID + '",'
            lineToWrite  += '"' + currentPatron.LastName + '",'
            lineToWrite  += '"' + currentPatron.FirstName + '",'
            lineToWrite  += '"' + currentPatron.MiddleName + '",'
            lineToWrite  += '' + currentPatron.CardExpirationDate + ','
            lineToWrite  += '' + currentPatron.GradYear + ','
            lineToWrite  += '' + currentPatron.BirthDate + ','
            lineToWrite  += '"' + currentPatron.Gender + '",'
            lineToWrite  += '"' + currentPatron.Type + '",'
            lineToWrite  += '"' + currentPatron.Status + '",'
            lineToWrite  += '"' + currentPatron.Location1 + '",'
            lineToWrite  += '"' + currentPatron.Location2 + '",'
            lineToWrite  += '"' + currentPatron.UserField1 + '",'
            lineToWrite  += '"' + currentPatron.UserField2 + '",'
            lineToWrite  += '"' + currentPatron.AddressLine1 + '",'
            lineToWrite  += '"' + currentPatron.AddressLine2 + '",'
            lineToWrite  += '"' + currentPatron.City + '",'
            lineToWrite  += '"' + currentPatron.State + '",'
            lineToWrite  += '"' + currentPatron.Zip + '",'
            lineToWrite  += '"' + currentPatron.Address1Email + '",'
            lineToWrite  += '"' + currentPatron.Address1Phone1 + '",'
            lineToWrite  += '"' + currentPatron.Address1Phone2 + '",'
            # add 8 additional empty fields for Address 2
            lineToWrite += '"","","","","","","","",'
            file_writer.write(lineToWrite + '\r\n')   
        file_writer.close()


write_files(MySQLdb, building_codes, Patron, datetime)
