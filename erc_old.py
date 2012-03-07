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

sql_scripts_directory = r'/home/orwig/etl'
attendance_script_name = 'erc_attendance_update.sql'
attendance_script_path = os.path.join(sql_scripts_directory, attendance_script_name)
print 'Will write attendance script to {0}'.format(attendance_script_path)

student_script_name = 'erc_students_update.sql'
student_script_path = os.path.join(sql_scripts_directory, student_script_name)
print 'Will write student script to {0}'.format(student_script_path)

def write_student_file():
    # It is vital that the 'student_number' field have a 'unique' key attached
    # Otherwise the MySQL will allow the student to added again, creating multiple entries for each student
    # student_number, name_first, name_last, grade, building, home_room
    
    print 'Will write SQl script to {0}'.format(student_script_path)

    sqlQuery = """SELECT Student_Number, First_Name, Last_Name, Grade_Level, SchoolID, Home_Room FROM students WHERE SchoolID<>'400' AND SchoolID<>'500' AND SchoolID<>'800' AND SchoolID<>'900' AND Enroll_Status = '0' ORDER BY SchoolID, Home_Room, Last_Name"""
    print sqlQuery

    sqlScriptWriter = open(student_script_path, 'w')
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

def write_attendance_file():
    tardySQLQuery = """SELECT students.Student_Number, COUNT(StudentID) FROM attendance, attendance_code, students WHERE attendance.Attendance_CodeID = attendance_code.ID AND attendance.StudentID = students.ID AND attendance.SchoolID<>'400' AND attendance.SchoolID<>'500' AND attendance.Att_Date > '""" + startDateString + """' AND attendance.Att_Date < '""" + endDateString + """' AND attendance_code.Description = 'Tardy' GROUP BY StudentID"""
    absenceSQLQuery = """SELECT students.Student_Number, ROUND(COUNT(StudentID)/2,1) FROM attendance, attendance_code, students WHERE attendance.Attendance_CodeID = attendance_code.ID AND attendance.StudentID = students.ID  AND attendance.SchoolID<>'400' AND attendance.SchoolID<>'500' AND attendance.Att_Date > '""" + startDateString + """' AND attendance.Att_Date < '""" + endDateString + """' AND attendance_code.Presence_Status_CD='Absent' GROUP BY StudentID"""
    print tardySQLQuery
    print absenceSQLQuery

    sqlScriptWriter = open(attendance_script_path, 'w')
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
    

if __name__ == "__main__":
    write_student_file()
    write_attendance_file()
    
