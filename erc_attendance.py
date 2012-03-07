import configmanager
import os
import MySQLdb
import string

settings = configmanager.readconfig()
db_user = settings['db_user']
db_passwd = settings['db_passwd']
db_db = settings ['db_db']

startDateString = '2009-08-30'
endDateString = '2009-11-01'
tardyFieldName = 'attendance_mp1_tardies'
absenseFieldName = 'attendance_mp1_absences'
print 'Will search for incidents between {0} and {1}'.format(startDateString, endDateString)

directoryForSqlScript = r'/home/orwig/etl'
sqlScriptName = 'erc_attendance_update.sql'
sqlScriptFullPath = os.path.join(directoryForSqlScript, sqlScriptName)
print 'Will write SQl script to {0}'.format(sqlScriptFullPath)

tardySQLQuery = """SELECT students.Student_Number, COUNT(StudentID) FROM attendance, attendance_code, students WHERE attendance.Attendance_CodeID = attendance_code.ID AND attendance.StudentID = students.ID AND attendance.SchoolID<>'400' AND attendance.SchoolID<>'500' AND attendance.Att_Date > '""" + startDateString + """' AND attendance.Att_Date < '""" + endDateString + """' AND attendance_code.Description = 'Tardy' GROUP BY StudentID"""
absenceSQLQuery = """SELECT students.Student_Number, ROUND(COUNT(StudentID)/2,1) FROM attendance, attendance_code, students WHERE attendance.Attendance_CodeID = attendance_code.ID AND attendance.StudentID = students.ID  AND attendance.SchoolID<>'400' AND attendance.SchoolID<>'500' AND attendance.Att_Date > '""" + startDateString + """' AND attendance.Att_Date < '""" + endDateString + """' AND attendance_code.Presence_Status_CD='Absent' GROUP BY StudentID"""
print tardySQLQuery
print absenceSQLQuery

sqlScriptWriter = open(sqlScriptFullPath, 'w')
sqlScriptWriter.write('USE reportcards;\n')

db=MySQLdb.connect(user=db_user,passwd=db_passwd,db=db_db)

# First we do the tardies
cursor = db.cursor()
cursor.execute(tardySQLQuery)
result = cursor.fetchall()
try:
    count = len(result)
    print 'Found {0} students with tardies'.format(count)
except:
    print 'Could not calculate the number of students with tardies for some reason'
for record in result:
    sqlLine = """UPDATE reportcards_student SET {0} = '{1}' WHERE student_number = '{2}';""".format(tardyFieldName, record[1], record[0])
    sqlScriptWriter.write(sqlLine + '\n')
    
# Then we do absences
cursor = db.cursor()
cursor.execute(absenceSQLQuery)
result = cursor.fetchall()
try:
    count = len(result)
    print 'Found {0} students with absences'.format(count)
except:
    print 'Could not calculate the number of students with tardies for some reason'
for record in result:
    sqlLine = """UPDATE reportcards_student SET {0} = '{1}' WHERE student_number = '{2}';""".format(absenseFieldName, record[1], record[0])
    sqlScriptWriter.write(sqlLine + '\n')
    
sqlScriptWriter.close()
