import configmanager
import datetime
import MySQLdb
import os
import smtplib
import string

settings = configmanager.readconfig()
db_user = settings['db_user']
db_passwd = settings['db_passwd']
db_db = settings ['db_db']


destination_directory = r'/home/orwig/etl'
update_file_name = 'erc_update.sql'
path_to_update_file = os.path.join(destination_directory,update_file_name)

today = datetime.date.today()
dateStamp = today.strftime("%A, %B %d %Y")


# establish connection to be used throughout this script
db=MySQLdb.connect(user=db_user,passwd=db_passwd,db=db_db)
log_string = 'db set to {0}'.format(db)
print log_string

marking_periods = [
   ['mp1', '2011-09-06', '2012-01-20'],
   ['mp2','2012-01-21','2012-03-30'],
   ['mp3','2012-04-01','2012-06-06'],
   ['mp4','2012-06-30','2012-07-30'],
   ['kmp1','2011-09-06', '2012-01-20'],
   ['kmp2','2012-01-21','2012-03-30'],
   ['kmp3','2012-04-01','2012-06-06'],
]

# open file with fileWriter object to be used throughout this script
file_writer = open(path_to_update_file, 'w')

sql_select_students = """SELECT Student_Number, First_Name, Last_Name, Grade_Level, SchoolID, Home_Room FROM students WHERE SchoolID<>'400' AND SchoolID<>'500' AND SchoolID<>'800' AND SchoolID<>'900' AND Enroll_Status = '0' ORDER BY SchoolID, Home_Room, Last_Name"""
sql_select_clause = 'SELECT students.Student_Number, COUNT(*) AS Count FROM attendance,attendance_code,students'
sql_where_clause_generic = """WHERE attendance.StudentID=students.ID AND attendance.Attendance_CodeID=attendance_code.ID AND attendance.SchoolID<>'400' AND attendance.SchoolID<>'500'"""
sql_where_clause_kindergarten = """AND students.Grade_Level='0'"""
sql_where_clause_grade = """AND (students.Grade_Level='1' OR students.Grade_Level='2' OR students.Grade_Level='3' OR students.Grade_Level='4' OR students.Grade_Level='5')"""
sql_attendance_code_clause_absences = """AND (attendance_code.Att_Code='A' OR attendance_code.Att_Code='U' OR attendance_code.Att_Code='I' OR attendance_code.Att_Code='X' OR attendance_code.Att_Code='S')"""
sql_attendance_code_clause_tardies = """AND attendance_code.Att_Code='T'"""
sql_group_by_clause = 'GROUP BY attendance.StudentID ORDER BY students.Student_Number'

def query_database(sql_query):
   log_string = 'Ready to run query: {0}'.format(sql_query)
   print log_string
   #email_body = email_body + '\n' + log_string
   print 'About to create cursor'
   cursor = db.cursor()
   print 'About to do execute cursor'
   cursor.execute(sql_query)
   print 'About to fetchall() for absences'
   sql_result = cursor.fetchall()
   log_string = 'sql_result contains {0} records'.format(len(sql_result))
   print log_string
   return sql_result

def write_sql_lines(field_to_update, result_set):
   for record in result_set:
      lineToWrite  = 'UPDATE reportcards_student SET '
      lineToWrite  += field_to_update + '="' + str(record[1]) + '"'
      lineToWrite  += ' WHERE student_number="' + record[0] + '";'
      file_writer.write(lineToWrite + '\n')
      print lineToWrite

print 'Update file open for writing at {0}'.format(path_to_update_file)
file_writer.write('USE reportcards;\n')

# start section to update actual students in the system
updated_students = query_database(sql_select_students)

try:
   count = len(updated_students)
   log_string = 'Found {0} students to update or insert'.format(count)
   print log_string
   file_writer.write('-- ' + log_string + '\n')
except:
   log_string = 'Could not calculate the number of students for some reason'
   print log_string
   file_writer.write('-- ' + log_string + '\n')   
for record in updated_students:
   sqlLine = """INSERT INTO reportcards_student (student_number, name_first, name_last, grade, building, home_room) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}', '{5}')  ON DUPLICATE KEY UPDATE grade='{6}', building='{7}', home_room='{8}';""".format(record[0], record[1], record[2], record[3], record[4], record[5], record[3], record[4], record[5])
   file_writer.write(sqlLine + '\n')

null_fixer_code = """

-- NULL values cause errors when creating the RTF report cards
-- This part of the script will change any NULLs to simple empty strings
UPDATE reportcards_student SET idint='' WHERE idint IS NULL;
UPDATE reportcards_student SET student_number='' WHERE student_number IS NULL;
UPDATE reportcards_student SET name_first=' ' WHERE name_first IS NULL;
UPDATE reportcards_student SET name_last=' ' WHERE name_last IS NULL;
UPDATE reportcards_student SET grade='' WHERE grade IS NULL;
UPDATE reportcards_student SET building='' WHERE building IS NULL;
UPDATE reportcards_student SET home_room='' WHERE home_room IS NULL;
UPDATE reportcards_student SET done_mp1='' WHERE done_mp1 IS NULL;
UPDATE reportcards_student SET done_mp2='' WHERE done_mp2 IS NULL;
UPDATE reportcards_student SET done_mp3='' WHERE done_mp3 IS NULL;
UPDATE reportcards_student SET done_mp4='' WHERE done_mp4 IS NULL;
UPDATE reportcards_student SET retained='' WHERE retained IS NULL;
UPDATE reportcards_student SET parent_attended_conference_mp1='' WHERE parent_attended_conference_mp1 IS NULL;
UPDATE reportcards_student SET parent_attended_conference_mp3='' WHERE parent_attended_conference_mp3 IS NULL;
UPDATE reportcards_student SET attendance_mp1_absencesdecimal='' WHERE attendance_mp1_absencesdecimal IS NULL;
UPDATE reportcards_student SET attendance_mp1_tardiesdecimal='' WHERE attendance_mp1_tardiesdecimal IS NULL;
UPDATE reportcards_student SET attendance_mp2_absencesdecimal='' WHERE attendance_mp2_absencesdecimal IS NULL;
UPDATE reportcards_student SET attendance_mp2_tardiesdecimal='' WHERE attendance_mp2_tardiesdecimal IS NULL;
UPDATE reportcards_student SET attendance_mp3_absencesdecimal='' WHERE attendance_mp3_absencesdecimal IS NULL;
UPDATE reportcards_student SET attendance_mp3_tardiesdecimal='' WHERE attendance_mp3_tardiesdecimal IS NULL;
UPDATE reportcards_student SET attendance_mp4_absencesdecimal='' WHERE attendance_mp4_absencesdecimal IS NULL;
UPDATE reportcards_student SET attendance_mp4_tardiesdecimal='' WHERE attendance_mp4_tardiesdecimal IS NULL;
UPDATE reportcards_student SET responsibility_marking1_1='' WHERE responsibility_marking1_1 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_2='' WHERE responsibility_marking1_2 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_3='' WHERE responsibility_marking1_3 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_4='' WHERE responsibility_marking1_4 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_5='' WHERE responsibility_marking1_5 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_6='' WHERE responsibility_marking1_6 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_7='' WHERE responsibility_marking1_7 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_8='' WHERE responsibility_marking1_8 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_9='' WHERE responsibility_marking1_9 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_10='' WHERE responsibility_marking1_10 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_11='' WHERE responsibility_marking1_11 IS NULL;
UPDATE reportcards_student SET responsibility_marking1_12='' WHERE responsibility_marking1_12 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_1='' WHERE responsibility_marking2_1 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_2='' WHERE responsibility_marking2_2 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_3='' WHERE responsibility_marking2_3 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_4='' WHERE responsibility_marking2_4 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_5='' WHERE responsibility_marking2_5 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_6='' WHERE responsibility_marking2_6 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_7='' WHERE responsibility_marking2_7 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_8='' WHERE responsibility_marking2_8 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_9='' WHERE responsibility_marking2_9 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_10='' WHERE responsibility_marking2_10 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_11='' WHERE responsibility_marking2_11 IS NULL;
UPDATE reportcards_student SET responsibility_marking2_12='' WHERE responsibility_marking2_12 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_1='' WHERE responsibility_marking3_1 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_2='' WHERE responsibility_marking3_2 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_3='' WHERE responsibility_marking3_3 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_4='' WHERE responsibility_marking3_4 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_5='' WHERE responsibility_marking3_5 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_6='' WHERE responsibility_marking3_6 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_7='' WHERE responsibility_marking3_7 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_8='' WHERE responsibility_marking3_8 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_9='' WHERE responsibility_marking3_9 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_10='' WHERE responsibility_marking3_10 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_11='' WHERE responsibility_marking3_11 IS NULL;
UPDATE reportcards_student SET responsibility_marking3_12='' WHERE responsibility_marking3_12 IS NULL;
UPDATE reportcards_student SET responsibility_marking4_1='' WHERE responsibility_marking4_1 IS NULL;
UPDATE reportcards_student SET responsibility_marking4_2='' WHERE responsibility_marking4_2 IS NULL;
UPDATE reportcards_student SET responsibility_marking4_3='' WHERE responsibility_marking4_3 IS NULL;
UPDATE reportcards_student SET responsibility_marking4_4='' WHERE responsibility_marking4_4 IS NULL;
UPDATE reportcards_student SET responsibility_marking4_5='' WHERE responsibility_marking4_5 IS NULL;
UPDATE reportcards_student SET responsibility_marking4_6='' WHERE responsibility_marking4_6 IS NULL;
UPDATE reportcards_student SET responsibility_marking4_7='' WHERE responsibility_marking4_7 IS NULL;
UPDATE reportcards_student SET responsibility_marking4_8='' WHERE responsibility_marking4_8 IS NULL;
UPDATE reportcards_student SET reading_marking1_gradelevelstatus='' WHERE reading_marking1_gradelevelstatus IS NULL;
UPDATE reportcards_student SET reading_marking1_overallgrade='' WHERE reading_marking1_overallgrade IS NULL;
UPDATE reportcards_student SET reading_marking1_overalleffort='' WHERE reading_marking1_overalleffort IS NULL;
UPDATE reportcards_student SET reading_marking1_1='' WHERE reading_marking1_1 IS NULL;
UPDATE reportcards_student SET reading_marking1_2='' WHERE reading_marking1_2 IS NULL;
UPDATE reportcards_student SET reading_marking1_3='' WHERE reading_marking1_3 IS NULL;
UPDATE reportcards_student SET reading_marking1_4='' WHERE reading_marking1_4 IS NULL;
UPDATE reportcards_student SET reading_marking1_5='' WHERE reading_marking1_5 IS NULL;
UPDATE reportcards_student SET reading_marking1_6='' WHERE reading_marking1_6 IS NULL;
UPDATE reportcards_student SET reading_marking1_7='' WHERE reading_marking1_7 IS NULL;
UPDATE reportcards_student SET reading_marking1_8='' WHERE reading_marking1_8 IS NULL;
UPDATE reportcards_student SET reading_marking2_gradelevelstatus='' WHERE reading_marking2_gradelevelstatus IS NULL;
UPDATE reportcards_student SET reading_marking2_overallgrade='' WHERE reading_marking2_overallgrade IS NULL;
UPDATE reportcards_student SET reading_marking2_overalleffort='' WHERE reading_marking2_overalleffort IS NULL;
UPDATE reportcards_student SET reading_marking2_1='' WHERE reading_marking2_1 IS NULL;
UPDATE reportcards_student SET reading_marking2_2='' WHERE reading_marking2_2 IS NULL;
UPDATE reportcards_student SET reading_marking2_3='' WHERE reading_marking2_3 IS NULL;
UPDATE reportcards_student SET reading_marking2_4='' WHERE reading_marking2_4 IS NULL;
UPDATE reportcards_student SET reading_marking2_5='' WHERE reading_marking2_5 IS NULL;
UPDATE reportcards_student SET reading_marking2_6='' WHERE reading_marking2_6 IS NULL;
UPDATE reportcards_student SET reading_marking2_7='' WHERE reading_marking2_7 IS NULL;
UPDATE reportcards_student SET reading_marking2_8='' WHERE reading_marking2_8 IS NULL;
UPDATE reportcards_student SET reading_marking3_gradelevelstatus='' WHERE reading_marking3_gradelevelstatus IS NULL;
UPDATE reportcards_student SET reading_marking3_overallgrade='' WHERE reading_marking3_overallgrade IS NULL;
UPDATE reportcards_student SET reading_marking3_overalleffort='' WHERE reading_marking3_overalleffort IS NULL;
UPDATE reportcards_student SET reading_marking3_1='' WHERE reading_marking3_1 IS NULL;
UPDATE reportcards_student SET reading_marking3_2='' WHERE reading_marking3_2 IS NULL;
UPDATE reportcards_student SET reading_marking3_3='' WHERE reading_marking3_3 IS NULL;
UPDATE reportcards_student SET reading_marking3_4='' WHERE reading_marking3_4 IS NULL;
UPDATE reportcards_student SET reading_marking3_5='' WHERE reading_marking3_5 IS NULL;
UPDATE reportcards_student SET reading_marking3_6='' WHERE reading_marking3_6 IS NULL;
UPDATE reportcards_student SET reading_marking3_7='' WHERE reading_marking3_7 IS NULL;
UPDATE reportcards_student SET reading_marking3_8='' WHERE reading_marking3_8 IS NULL;
UPDATE reportcards_student SET reading_marking4_gradelevelstatus='' WHERE reading_marking4_gradelevelstatus IS NULL;
UPDATE reportcards_student SET reading_marking4_overallgrade='' WHERE reading_marking4_overallgrade IS NULL;
UPDATE reportcards_student SET reading_marking4_overalleffort='' WHERE reading_marking4_overalleffort IS NULL;
UPDATE reportcards_student SET reading_marking4_1='' WHERE reading_marking4_1 IS NULL;
UPDATE reportcards_student SET reading_marking4_2='' WHERE reading_marking4_2 IS NULL;
UPDATE reportcards_student SET reading_marking4_3='' WHERE reading_marking4_3 IS NULL;
UPDATE reportcards_student SET reading_marking4_4='' WHERE reading_marking4_4 IS NULL;
UPDATE reportcards_student SET reading_marking4_5='' WHERE reading_marking4_5 IS NULL;
UPDATE reportcards_student SET writing_marking1_overallgrade='' WHERE writing_marking1_overallgrade IS NULL;
UPDATE reportcards_student SET writing_marking1_overalleffort='' WHERE writing_marking1_overalleffort IS NULL;
UPDATE reportcards_student SET writing_marking1_1='' WHERE writing_marking1_1 IS NULL;
UPDATE reportcards_student SET writing_marking1_2='' WHERE writing_marking1_2 IS NULL;
UPDATE reportcards_student SET writing_marking1_3='' WHERE writing_marking1_3 IS NULL;
UPDATE reportcards_student SET writing_marking1_4='' WHERE writing_marking1_4 IS NULL;
UPDATE reportcards_student SET writing_marking1_5='' WHERE writing_marking1_5 IS NULL;
UPDATE reportcards_student SET writing_marking1_6='' WHERE writing_marking1_6 IS NULL;
UPDATE reportcards_student SET writing_marking1_7='' WHERE writing_marking1_7 IS NULL;
UPDATE reportcards_student SET writing_marking2_overallgrade='' WHERE writing_marking2_overallgrade IS NULL;
UPDATE reportcards_student SET writing_marking2_overalleffort='' WHERE writing_marking2_overalleffort IS NULL;
UPDATE reportcards_student SET writing_marking2_1='' WHERE writing_marking2_1 IS NULL;
UPDATE reportcards_student SET writing_marking2_2='' WHERE writing_marking2_2 IS NULL;
UPDATE reportcards_student SET writing_marking2_3='' WHERE writing_marking2_3 IS NULL;
UPDATE reportcards_student SET writing_marking2_4='' WHERE writing_marking2_4 IS NULL;
UPDATE reportcards_student SET writing_marking2_5='' WHERE writing_marking2_5 IS NULL;
UPDATE reportcards_student SET writing_marking2_6='' WHERE writing_marking2_6 IS NULL;
UPDATE reportcards_student SET writing_marking2_7='' WHERE writing_marking2_7 IS NULL;
UPDATE reportcards_student SET writing_marking3_overallgrade='' WHERE writing_marking3_overallgrade IS NULL;
UPDATE reportcards_student SET writing_marking3_overalleffort='' WHERE writing_marking3_overalleffort IS NULL;
UPDATE reportcards_student SET writing_marking3_1='' WHERE writing_marking3_1 IS NULL;
UPDATE reportcards_student SET writing_marking3_2='' WHERE writing_marking3_2 IS NULL;
UPDATE reportcards_student SET writing_marking3_3='' WHERE writing_marking3_3 IS NULL;
UPDATE reportcards_student SET writing_marking3_4='' WHERE writing_marking3_4 IS NULL;
UPDATE reportcards_student SET writing_marking3_5='' WHERE writing_marking3_5 IS NULL;
UPDATE reportcards_student SET writing_marking3_6='' WHERE writing_marking3_6 IS NULL;
UPDATE reportcards_student SET writing_marking3_7='' WHERE writing_marking3_7 IS NULL;
UPDATE reportcards_student SET writing_marking4_overallgrade='' WHERE writing_marking4_overallgrade IS NULL;
UPDATE reportcards_student SET writing_marking4_overalleffort='' WHERE writing_marking4_overalleffort IS NULL;
UPDATE reportcards_student SET writing_marking4_1='' WHERE writing_marking4_1 IS NULL;
UPDATE reportcards_student SET writing_marking4_2='' WHERE writing_marking4_2 IS NULL;
UPDATE reportcards_student SET writing_marking4_3='' WHERE writing_marking4_3 IS NULL;
UPDATE reportcards_student SET writing_marking4_4='' WHERE writing_marking4_4 IS NULL;
UPDATE reportcards_student SET writing_marking4_5='' WHERE writing_marking4_5 IS NULL;
UPDATE reportcards_student SET speaking_marking1_1='' WHERE speaking_marking1_1 IS NULL;
UPDATE reportcards_student SET speaking_marking1_2='' WHERE speaking_marking1_2 IS NULL;
UPDATE reportcards_student SET speaking_marking2_1='' WHERE speaking_marking2_1 IS NULL;
UPDATE reportcards_student SET speaking_marking2_2='' WHERE speaking_marking2_2 IS NULL;
UPDATE reportcards_student SET speaking_marking3_1='' WHERE speaking_marking3_1 IS NULL;
UPDATE reportcards_student SET speaking_marking3_2='' WHERE speaking_marking3_2 IS NULL;
UPDATE reportcards_student SET math_marking1_gradelevelstatus='' WHERE math_marking1_gradelevelstatus IS NULL;
UPDATE reportcards_student SET math_marking1_overallgrade='' WHERE math_marking1_overallgrade IS NULL;
UPDATE reportcards_student SET math_marking1_overalleffort='' WHERE math_marking1_overalleffort IS NULL;
UPDATE reportcards_student SET math_marking1_1='' WHERE math_marking1_1 IS NULL;
UPDATE reportcards_student SET math_marking1_2='' WHERE math_marking1_2 IS NULL;
UPDATE reportcards_student SET math_marking1_3='' WHERE math_marking1_3 IS NULL;
UPDATE reportcards_student SET math_marking1_4='' WHERE math_marking1_4 IS NULL;
UPDATE reportcards_student SET math_marking1_5='' WHERE math_marking1_5 IS NULL;
UPDATE reportcards_student SET math_marking1_6='' WHERE math_marking1_6 IS NULL;
UPDATE reportcards_student SET math_marking1_7='' WHERE math_marking1_7 IS NULL;
UPDATE reportcards_student SET math_marking1_8='' WHERE math_marking1_8 IS NULL;
UPDATE reportcards_student SET math_marking1_9='' WHERE math_marking1_9 IS NULL;
UPDATE reportcards_student SET math_marking1_10='' WHERE math_marking1_10 IS NULL;
UPDATE reportcards_student SET math_marking1_11='' WHERE math_marking1_11 IS NULL;
UPDATE reportcards_student SET math_marking2_gradelevelstatus='' WHERE math_marking2_gradelevelstatus IS NULL;
UPDATE reportcards_student SET math_marking2_overallgrade='' WHERE math_marking2_overallgrade IS NULL;
UPDATE reportcards_student SET math_marking2_overalleffort='' WHERE math_marking2_overalleffort IS NULL;
UPDATE reportcards_student SET math_marking2_1='' WHERE math_marking2_1 IS NULL;
UPDATE reportcards_student SET math_marking2_2='' WHERE math_marking2_2 IS NULL;
UPDATE reportcards_student SET math_marking2_3='' WHERE math_marking2_3 IS NULL;
UPDATE reportcards_student SET math_marking2_4='' WHERE math_marking2_4 IS NULL;
UPDATE reportcards_student SET math_marking2_5='' WHERE math_marking2_5 IS NULL;
UPDATE reportcards_student SET math_marking2_6='' WHERE math_marking2_6 IS NULL;
UPDATE reportcards_student SET math_marking2_7='' WHERE math_marking2_7 IS NULL;
UPDATE reportcards_student SET math_marking2_8='' WHERE math_marking2_8 IS NULL;
UPDATE reportcards_student SET math_marking2_9='' WHERE math_marking2_9 IS NULL;
UPDATE reportcards_student SET math_marking2_10='' WHERE math_marking2_10 IS NULL;
UPDATE reportcards_student SET math_marking2_11='' WHERE math_marking2_11 IS NULL;
UPDATE reportcards_student SET math_marking3_gradelevelstatus='' WHERE math_marking3_gradelevelstatus IS NULL;
UPDATE reportcards_student SET math_marking3_overallgrade='' WHERE math_marking3_overallgrade IS NULL;
UPDATE reportcards_student SET math_marking3_overalleffort='' WHERE math_marking3_overalleffort IS NULL;
UPDATE reportcards_student SET math_marking3_1='' WHERE math_marking3_1 IS NULL;
UPDATE reportcards_student SET math_marking3_2='' WHERE math_marking3_2 IS NULL;
UPDATE reportcards_student SET math_marking3_3='' WHERE math_marking3_3 IS NULL;
UPDATE reportcards_student SET math_marking3_4='' WHERE math_marking3_4 IS NULL;
UPDATE reportcards_student SET math_marking3_5='' WHERE math_marking3_5 IS NULL;
UPDATE reportcards_student SET math_marking3_6='' WHERE math_marking3_6 IS NULL;
UPDATE reportcards_student SET math_marking3_7='' WHERE math_marking3_7 IS NULL;
UPDATE reportcards_student SET math_marking3_8='' WHERE math_marking3_8 IS NULL;
UPDATE reportcards_student SET math_marking3_9='' WHERE math_marking3_9 IS NULL;
UPDATE reportcards_student SET math_marking3_10='' WHERE math_marking3_10 IS NULL;
UPDATE reportcards_student SET math_marking3_11='' WHERE math_marking3_11 IS NULL;
UPDATE reportcards_student SET math_marking4_gradelevelstatus='' WHERE math_marking4_gradelevelstatus IS NULL;
UPDATE reportcards_student SET math_marking4_overallgrade='' WHERE math_marking4_overallgrade IS NULL;
UPDATE reportcards_student SET math_marking4_overalleffort='' WHERE math_marking4_overalleffort IS NULL;
UPDATE reportcards_student SET math_marking4_1='' WHERE math_marking4_1 IS NULL;
UPDATE reportcards_student SET math_marking4_2='' WHERE math_marking4_2 IS NULL;
UPDATE reportcards_student SET math_marking4_3='' WHERE math_marking4_3 IS NULL;
UPDATE reportcards_student SET math_marking4_4='' WHERE math_marking4_4 IS NULL;
UPDATE reportcards_student SET math_marking4_5='' WHERE math_marking4_5 IS NULL;
UPDATE reportcards_student SET math_marking4_6='' WHERE math_marking4_6 IS NULL;
UPDATE reportcards_student SET math_marking4_7='' WHERE math_marking4_7 IS NULL;
UPDATE reportcards_student SET math_marking4_8='' WHERE math_marking4_8 IS NULL;
UPDATE reportcards_student SET math_marking4_9='' WHERE math_marking4_9 IS NULL;
UPDATE reportcards_student SET math_marking4_10='' WHERE math_marking4_10 IS NULL;
UPDATE reportcards_student SET math_marking4_11='' WHERE math_marking4_11 IS NULL;
UPDATE reportcards_student SET science_marking1_overallgrade='' WHERE science_marking1_overallgrade IS NULL;
UPDATE reportcards_student SET science_marking1_overalleffort='' WHERE science_marking1_overalleffort IS NULL;
UPDATE reportcards_student SET science_marking2_overallgrade='' WHERE science_marking2_overallgrade IS NULL;
UPDATE reportcards_student SET science_marking2_overalleffort='' WHERE science_marking2_overalleffort IS NULL;
UPDATE reportcards_student SET science_marking3_overallgrade='' WHERE science_marking3_overallgrade IS NULL;
UPDATE reportcards_student SET science_marking3_overalleffort='' WHERE science_marking3_overalleffort IS NULL;
UPDATE reportcards_student SET science_marking4_overallgrade='' WHERE science_marking4_overallgrade IS NULL;
UPDATE reportcards_student SET science_marking4_overalleffort='' WHERE science_marking4_overalleffort IS NULL;
UPDATE reportcards_student SET socialstudies_marking1_overallgrade='' WHERE socialstudies_marking1_overallgrade IS NULL;
UPDATE reportcards_student SET socialstudies_marking1_overalleffort='' WHERE socialstudies_marking1_overalleffort IS NULL;
UPDATE reportcards_student SET socialstudies_marking2_overallgrade='' WHERE socialstudies_marking2_overallgrade IS NULL;
UPDATE reportcards_student SET socialstudies_marking2_overalleffort='' WHERE socialstudies_marking2_overalleffort IS NULL;
UPDATE reportcards_student SET socialstudies_marking3_overallgrade='' WHERE socialstudies_marking3_overallgrade IS NULL;
UPDATE reportcards_student SET socialstudies_marking3_overalleffort='' WHERE socialstudies_marking3_overalleffort IS NULL;
UPDATE reportcards_student SET socialstudies_marking4_overallgrade='' WHERE socialstudies_marking4_overallgrade IS NULL;
UPDATE reportcards_student SET socialstudies_marking4_overalleffort='' WHERE socialstudies_marking4_overalleffort IS NULL;
UPDATE reportcards_student SET art_marking1_1='' WHERE art_marking1_1 IS NULL;
UPDATE reportcards_student SET art_marking1_2='' WHERE art_marking1_2 IS NULL;
UPDATE reportcards_student SET art_marking1_3='' WHERE art_marking1_3 IS NULL;
UPDATE reportcards_student SET art_marking1_4='' WHERE art_marking1_4 IS NULL;
UPDATE reportcards_student SET art_marking2_1='' WHERE art_marking2_1 IS NULL;
UPDATE reportcards_student SET art_marking2_2='' WHERE art_marking2_2 IS NULL;
UPDATE reportcards_student SET art_marking2_3='' WHERE art_marking2_3 IS NULL;
UPDATE reportcards_student SET art_marking2_4='' WHERE art_marking2_4 IS NULL;
UPDATE reportcards_student SET art_marking3_1='' WHERE art_marking3_1 IS NULL;
UPDATE reportcards_student SET art_marking3_2='' WHERE art_marking3_2 IS NULL;
UPDATE reportcards_student SET art_marking3_3='' WHERE art_marking3_3 IS NULL;
UPDATE reportcards_student SET art_marking3_4='' WHERE art_marking3_4 IS NULL;
UPDATE reportcards_student SET art_marking4_1='' WHERE art_marking4_1 IS NULL;
UPDATE reportcards_student SET art_marking4_2='' WHERE art_marking4_2 IS NULL;
UPDATE reportcards_student SET art_marking4_3='' WHERE art_marking4_3 IS NULL;
UPDATE reportcards_student SET art_marking4_4='' WHERE art_marking4_4 IS NULL;
UPDATE reportcards_student SET physed_marking1_1='' WHERE physed_marking1_1 IS NULL;
UPDATE reportcards_student SET physed_marking1_2='' WHERE physed_marking1_2 IS NULL;
UPDATE reportcards_student SET physed_marking1_3='' WHERE physed_marking1_3 IS NULL;
UPDATE reportcards_student SET physed_marking1_4='' WHERE physed_marking1_4 IS NULL;
UPDATE reportcards_student SET physed_marking2_1='' WHERE physed_marking2_1 IS NULL;
UPDATE reportcards_student SET physed_marking2_2='' WHERE physed_marking2_2 IS NULL;
UPDATE reportcards_student SET physed_marking2_3='' WHERE physed_marking2_3 IS NULL;
UPDATE reportcards_student SET physed_marking2_4='' WHERE physed_marking2_4 IS NULL;
UPDATE reportcards_student SET physed_marking3_1='' WHERE physed_marking3_1 IS NULL;
UPDATE reportcards_student SET physed_marking3_2='' WHERE physed_marking3_2 IS NULL;
UPDATE reportcards_student SET physed_marking3_3='' WHERE physed_marking3_3 IS NULL;
UPDATE reportcards_student SET physed_marking3_4='' WHERE physed_marking3_4 IS NULL;
UPDATE reportcards_student SET physed_marking4_1='' WHERE physed_marking4_1 IS NULL;
UPDATE reportcards_student SET physed_marking4_2='' WHERE physed_marking4_2 IS NULL;
UPDATE reportcards_student SET physed_marking4_3='' WHERE physed_marking4_3 IS NULL;
UPDATE reportcards_student SET physed_marking4_4='' WHERE physed_marking4_4 IS NULL;
UPDATE reportcards_student SET tech_marking1_1='' WHERE tech_marking1_1 IS NULL;
UPDATE reportcards_student SET tech_marking1_2='' WHERE tech_marking1_2 IS NULL;
UPDATE reportcards_student SET tech_marking1_3='' WHERE tech_marking1_3 IS NULL;
UPDATE reportcards_student SET tech_marking1_4='' WHERE tech_marking1_4 IS NULL;
UPDATE reportcards_student SET tech_marking2_1='' WHERE tech_marking2_1 IS NULL;
UPDATE reportcards_student SET tech_marking2_2='' WHERE tech_marking2_2 IS NULL;
UPDATE reportcards_student SET tech_marking2_3='' WHERE tech_marking2_3 IS NULL;
UPDATE reportcards_student SET tech_marking2_4='' WHERE tech_marking2_4 IS NULL;
UPDATE reportcards_student SET tech_marking3_1='' WHERE tech_marking3_1 IS NULL;
UPDATE reportcards_student SET tech_marking3_2='' WHERE tech_marking3_2 IS NULL;
UPDATE reportcards_student SET tech_marking3_3='' WHERE tech_marking3_3 IS NULL;
UPDATE reportcards_student SET tech_marking3_4='' WHERE tech_marking3_4 IS NULL;
UPDATE reportcards_student SET tech_marking4_1='' WHERE tech_marking4_1 IS NULL;
UPDATE reportcards_student SET tech_marking4_2='' WHERE tech_marking4_2 IS NULL;
UPDATE reportcards_student SET tech_marking4_3='' WHERE tech_marking4_3 IS NULL;
UPDATE reportcards_student SET tech_marking4_4='' WHERE tech_marking4_4 IS NULL;
UPDATE reportcards_student SET music_marking1_1='' WHERE music_marking1_1 IS NULL;
UPDATE reportcards_student SET music_marking1_2='' WHERE music_marking1_2 IS NULL;
UPDATE reportcards_student SET music_marking1_3='' WHERE music_marking1_3 IS NULL;
UPDATE reportcards_student SET music_marking1_4='' WHERE music_marking1_4 IS NULL;
UPDATE reportcards_student SET music_marking2_1='' WHERE music_marking2_1 IS NULL;
UPDATE reportcards_student SET music_marking2_2='' WHERE music_marking2_2 IS NULL;
UPDATE reportcards_student SET music_marking2_3='' WHERE music_marking2_3 IS NULL;
UPDATE reportcards_student SET music_marking2_4='' WHERE music_marking2_4 IS NULL;
UPDATE reportcards_student SET music_marking3_1='' WHERE music_marking3_1 IS NULL;
UPDATE reportcards_student SET music_marking3_2='' WHERE music_marking3_2 IS NULL;
UPDATE reportcards_student SET music_marking3_3='' WHERE music_marking3_3 IS NULL;
UPDATE reportcards_student SET music_marking3_4='' WHERE music_marking3_4 IS NULL;
UPDATE reportcards_student SET music_marking4_1='' WHERE music_marking4_1 IS NULL;
UPDATE reportcards_student SET music_marking4_2='' WHERE music_marking4_2 IS NULL;
UPDATE reportcards_student SET music_marking4_3='' WHERE music_marking4_3 IS NULL;
UPDATE reportcards_student SET music_marking4_4='' WHERE music_marking4_4 IS NULL;
UPDATE reportcards_student SET media_marking1_1='' WHERE media_marking1_1 IS NULL;
UPDATE reportcards_student SET media_marking1_2='' WHERE media_marking1_2 IS NULL;
UPDATE reportcards_student SET media_marking1_3='' WHERE media_marking1_3 IS NULL;
UPDATE reportcards_student SET media_marking1_4='' WHERE media_marking1_4 IS NULL;
UPDATE reportcards_student SET media_marking2_1='' WHERE media_marking2_1 IS NULL;
UPDATE reportcards_student SET media_marking2_2='' WHERE media_marking2_2 IS NULL;
UPDATE reportcards_student SET media_marking2_3='' WHERE media_marking2_3 IS NULL;
UPDATE reportcards_student SET media_marking2_4='' WHERE media_marking2_4 IS NULL;
UPDATE reportcards_student SET media_marking3_1='' WHERE media_marking3_1 IS NULL;
UPDATE reportcards_student SET media_marking3_2='' WHERE media_marking3_2 IS NULL;
UPDATE reportcards_student SET media_marking3_3='' WHERE media_marking3_3 IS NULL;
UPDATE reportcards_student SET media_marking3_4='' WHERE media_marking3_4 IS NULL;
UPDATE reportcards_student SET media_marking4_1='' WHERE media_marking4_1 IS NULL;
UPDATE reportcards_student SET media_marking4_2='' WHERE media_marking4_2 IS NULL;
UPDATE reportcards_student SET media_marking4_3='' WHERE media_marking4_3 IS NULL;
UPDATE reportcards_student SET media_marking4_4='' WHERE media_marking4_4 IS NULL;
UPDATE reportcards_student SET comment_marking1='' WHERE comment_marking1 IS NULL;
UPDATE reportcards_student SET comment_marking2='' WHERE comment_marking2 IS NULL;
UPDATE reportcards_student SET comment_marking3='' WHERE comment_marking3 IS NULL;
UPDATE reportcards_student SET comment_marking4='' WHERE comment_marking4 IS NULL;
"""
file_writer.write(null_fixer_code)


file_writer.write('\n\n-- eliminate existing attendance data in case some have been filled in error\n')
file_writer.write("""UPDATE reportcards_student SET attendance_mp1_tardies='0';\n""")
file_writer.write("""UPDATE reportcards_student SET attendance_mp1_absences='0';\n""")
file_writer.write("""UPDATE reportcards_student SET attendance_mp2_tardies='0';\n""")
file_writer.write("""UPDATE reportcards_student SET attendance_mp2_absences='0';\n""")
file_writer.write("""UPDATE reportcards_student SET attendance_mp3_tardies='0';\n""")
file_writer.write("""UPDATE reportcards_student SET attendance_mp3_absences='0';\n""")
file_writer.write("""UPDATE reportcards_student SET attendance_mp4_tardies='0';\n""")
file_writer.write("""UPDATE reportcards_student SET attendance_mp4_absences='0';\n\n""")

for period in marking_periods:
   absence_field = 'attendance_' + period[0] + '_absences'
   tardy_field = 'attendance_' + period[0] + '_tardies'
   log_string = '----- STARTING QUERY PROCES FOR {0} ----- '.format(period[0])
   print log_string
   file_writer.write(log_string + '\n')
   where_clause_date = """AND attendance.Att_Date>'{0}' AND attendance.Att_Date<'{1}'""".format(period[1],period[2])
   print 'where_clause_date is {0}'.format(where_clause_date)
   if period[0][0] == 'k':
      sql_where_clause_grade = sql_where_clause_kindergarten
      absence_field = 'attendance_' + period[0][1:] + '_absences'
      tardy_field = 'attendance_' + period[0][1:] + '_tardies'
   print 'sql_where_clause_grade is {0}'.format(sql_where_clause_grade)
   absence_query = '{0} {1} {2} {3} {4} {5}'.format(sql_select_clause,sql_where_clause_generic,sql_where_clause_grade,sql_attendance_code_clause_absences,where_clause_date,sql_group_by_clause)
   tardy_query = '{0} {1} {2} {3} {4} {5}'.format(sql_select_clause,sql_where_clause_generic,sql_where_clause_grade,sql_attendance_code_clause_tardies,where_clause_date,sql_group_by_clause)
   file_writer.write('-- absence_query=' + absence_query + '\n')
   file_writer.write('-- tardy_query=' + tardy_query + '\n')
   # absences    
   absence_result = query_database(absence_query)
   log_string = '{0} records in absence_result'.format(len(absence_result))
   print log_string
   file_writer.write('-- ' + log_string + '\n')
   file_writer.write('----- {0} QUERY: {1}/n'.format(absence_field, absence_query))
   file_writer.write('UPDATING field {0} of {1} records\n'.format(absence_field, len(absence_result)))
   write_sql_lines(absence_field, absence_result)
   # tardies
   tardy_result = query_database(tardy_query)
   log_string = '{0} records in tardy_result'.format(len(tardy_result))
   print log_string
   file_writer.write('-- ' + log_string + '\n')
   file_writer.write('----- {0} QUERY: {1}/n'.format(tardy_field, absence_query))
   file_writer.write('UPDATING field {0} of {1} records\n'.format(tardy_field, len(absence_result)))
   write_sql_lines(tardy_field, tardy_result)

file_writer.close()
