import configmanager
import os
import MySQLdb
import string

settings = configmanager.readconfig()
db_user = settings['db_user']
db_passwd = settings['db_passwd']
db_db = settings ['db_db']

# It is vital that the 'student_number' field have a 'unique' key attached
# Otherwise the MySQL will allow the student to added again, creating multiple entries for each student
# student_number, name_first, name_last, grade, building, home_room

directoryForSqlScript = r'/home/orwig/etl'
sqlScriptName = 'erc_students_update.sql'
sqlScriptFullPath = os.path.join(directoryForSqlScript, sqlScriptName)
print 'Will write SQl script to {0}'.format(sqlScriptFullPath)

sqlQuery = """SELECT Student_Number, First_Name, Last_Name, Grade_Level, SchoolID, Home_Room FROM students WHERE SchoolID<>'400' AND SchoolID<>'500' AND SchoolID<>'800' AND SchoolID<>'900' AND Enroll_Status = '0' ORDER BY SchoolID, Home_Room, Last_Name"""
print sqlQuery

sqlScriptWriter = open(sqlScriptFullPath, 'w')
sqlScriptWriter.write('USE reportcards;\n')

db=MySQLdb.connect(user=db_user,passwd=db_passwd,db=db_db)

# First we do the tardies
cursor = db.cursor()
cursor.execute(sqlQuery)
result = cursor.fetchall()
try:
    count = len(result)
    print 'Found {0} students to update or insert'.format(count)
except:
    print 'Could not calculate the number of students for some reason'
for record in result:
    sqlLine = """INSERT INTO reportcards_student (student_number, name_first, name_last, grade, building, home_room) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}', '{5}')  ON DUPLICATE KEY UPDATE grade='{6}', building='{7}', home_room='{8}';""".format(record[0], record[1], record[2], record[3], record[4], record[5], record[3], record[4], record[5])
    sqlScriptWriter.write(sqlLine + '\n')

print 'Script written'
sqlScriptWriter.close()
