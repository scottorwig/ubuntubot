/*
SQLyog Community v10.2 
MySQL - 5.5.24-0ubuntu0.12.04.1 : Database - powerschoolmirror
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`powerschoolmirror` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci */;

USE `powerschoolmirror`;

/*Table structure for table `aggstats` */

DROP TABLE IF EXISTS `aggstats`;

CREATE TABLE `aggstats` (
  `AdminPVs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Enrollment` int(10) unsigned DEFAULT NULL,
  `Hits` int(10) unsigned DEFAULT NULL,
  `ID` int(10) unsigned DEFAULT NULL,
  `NumSchools` int(10) unsigned DEFAULT NULL,
  `PageViews` int(10) unsigned DEFAULT NULL,
  `ParentHits` int(10) unsigned DEFAULT NULL,
  `ParentLogins` int(10) unsigned DEFAULT NULL,
  `ParentPVs` int(10) unsigned DEFAULT NULL,
  `PG3Hits` int(10) unsigned DEFAULT NULL,
  `PGIHits` int(10) unsigned DEFAULT NULL,
  `PortalPVs` int(10) unsigned DEFAULT NULL,
  `ReportQueueJobs` int(10) unsigned DEFAULT NULL,
  `Server` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `ServerName` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Server_InstanceID` int(10) unsigned DEFAULT NULL,
  `StudentHits` int(10) unsigned DEFAULT NULL,
  `StudentLogins` int(10) unsigned DEFAULT NULL,
  `StudentPVs` int(10) unsigned DEFAULT NULL,
  `TeacherPVs` int(10) unsigned DEFAULT NULL,
  `Time` varchar(30) COLLATE latin1_general_ci DEFAULT '',
  `TotalPVs` int(10) unsigned DEFAULT NULL,
  `TotLogins` int(10) unsigned DEFAULT NULL,
  `Type` varchar(50) COLLATE latin1_general_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `att_code_code_entity` */

DROP TABLE IF EXISTS `att_code_code_entity`;

CREATE TABLE `att_code_code_entity` (
  `Attendance_CodeID` int(11) DEFAULT NULL,
  `Code_EntityID` int(11) DEFAULT NULL,
  `ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `attendance` */

DROP TABLE IF EXISTS `attendance`;

CREATE TABLE `attendance` (
  `ADA_Value_Code` varchar(10) COLLATE latin1_general_ci DEFAULT '',
  `ADA_Value_Time` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `ADM_Value` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Attendance_CodeID` int(11) DEFAULT NULL,
  `Att_Comment` varchar(500) COLLATE latin1_general_ci DEFAULT '',
  `Att_Date` date DEFAULT NULL,
  `Att_Flags` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Att_Interval` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Att_Mode_Code` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Calendar_DayID` int(11) DEFAULT NULL,
  `CCID` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `ID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Lock_Reporting_YN` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Lock_Teacher_YN` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Parent_AttendanceID` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `PeriodID` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `ProgramID` int(11) DEFAULT NULL,
  `Prog_Crse_Type` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `SchoolID` int(11) DEFAULT NULL,
  `StudentID` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Total_Minutes` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Transaction_Type` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `YearID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`Att_Date`),
  KEY `NewIndex2` (`PeriodID`),
  KEY `NewIndex3` (`SchoolID`),
  KEY `NewIndex4` (`Attendance_CodeID`),
  KEY `NewIndex5` (`StudentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `attendance_code` */

DROP TABLE IF EXISTS `attendance_code`;

CREATE TABLE `attendance_code` (
  `Alternate_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Assignment_Filter_YN` tinyint(4) DEFAULT '0',
  `AttendanceCodeInfo_guid` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Att_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Calculate_ADA_YN` tinyint(4) DEFAULT '0',
  `Calculate_ADM_YN` tinyint(4) DEFAULT '0',
  `Course_Credit_Points` int(11) DEFAULT NULL,
  `Description` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) NOT NULL,
  `Presence_Status_CD` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SortOrder` int(11) DEFAULT NULL,
  `Unused1` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`Att_Code`),
  KEY `NewIndex2` (`SchoolID`),
  KEY `NewIndex3` (`YearID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `attendance_conversion` */

DROP TABLE IF EXISTS `attendance_conversion`;

CREATE TABLE `attendance_conversion` (
  `ID` int(11) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Year_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `attendance_conversion_items` */

DROP TABLE IF EXISTS `attendance_conversion_items`;

CREATE TABLE `attendance_conversion_items` (
  `Attendance_Conversion_ID` int(11) DEFAULT NULL,
  `Attendance_Value` varchar(5) COLLATE latin1_general_ci DEFAULT NULL,
  `Comment` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Conversion_Mode_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FTEID` int(11) DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Input_Value` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `unused` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `attendance_taken` */

DROP TABLE IF EXISTS `attendance_taken`;

CREATE TABLE `attendance_taken` (
  `Att_Date` date DEFAULT NULL,
  `Att_Interval` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Att_Taken_Dt` date DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `PeriodID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `awsched_constraint` */

DROP TABLE IF EXISTS `awsched_constraint`;

CREATE TABLE `awsched_constraint` (
  `Bitmap` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Classroom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ConstraintFlagField1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Constraint_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Expression` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Section_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Section_Number2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Section_Type` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `StudentID2` int(11) DEFAULT NULL,
  `TeacherID` int(11) DEFAULT NULL,
  `TeacherID2` int(11) DEFAULT NULL,
  `TermID` int(11) DEFAULT NULL,
  `Unused1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `awsched_preference` */

DROP TABLE IF EXISTS `awsched_preference`;

CREATE TABLE `awsched_preference` (
  `DPCycle` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `LoadMin` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LoadPct` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LoadUseMax` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MaxSubsAtaTime` int(11) DEFAULT NULL,
  `MaxSubstPerStud` int(11) DEFAULT NULL,
  `PPD` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RndSeed` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Sterms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `UseGlobalSubstitution` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `UseStudentCrsSubstitution` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Use_Bldg` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Use_House` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `batches` */

DROP TABLE IF EXISTS `batches`;

CREATE TABLE `batches` (
  `BatchType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Cash` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `BatchDate` date DEFAULT NULL,
  `EndTime` time DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `IPAddress` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NumTransactions` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `StartTime` time DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `bell_schedule` */

DROP TABLE IF EXISTS `bell_schedule`;

CREATE TABLE `bell_schedule` (
  `Attendance_Conversion_ID` int(11) DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Year_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `bell_schedule_items` */

DROP TABLE IF EXISTS `bell_schedule_items`;

CREATE TABLE `bell_schedule_items` (
  `ADA_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Bell_Schedule_ID` int(11) DEFAULT NULL,
  `Daily_Attendance_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Daily_Time_In_Default` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Daily_Time_Out_Default` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `End_Time` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) NOT NULL,
  `Minutes_Attended` int(11) DEFAULT NULL,
  `Period_ID` int(11) DEFAULT NULL,
  `Start_Time` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `bulletinitems` */

DROP TABLE IF EXISTS `bulletinitems`;

CREATE TABLE `bulletinitems` (
  `Audience` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Body` varchar(3000) COLLATE latin1_general_ci DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SortOrder` int(11) DEFAULT NULL,
  `StartDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `calendar_day` */

DROP TABLE IF EXISTS `calendar_day`;

CREATE TABLE `calendar_day` (
  `A` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `B` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Bell_Schedule_ID` int(11) DEFAULT NULL,
  `C` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Cycle_Day_ID` int(11) DEFAULT NULL,
  `D` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `E` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `F` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `InSession` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MembershipValue` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Note` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `ScheduleID` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `CalendarDayType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Type` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Week_Num` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `cc` */

DROP TABLE IF EXISTS `cc`;

CREATE TABLE `cc` (
  `AB_Course_Cmp_Ext_Crd` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Course_Cmp_Fun_Flg` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Course_Cmp_Met_Cd` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Course_Cmp_Sta_Cd` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Course_Eva_Pro_Cd` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AsmtScores` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Attendance` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Attendance_Type_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CCectEnrl_guid` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CurrentAbsences` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CurrentTardies` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `DateEnrolled` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `DateLeft` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Expression` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FinalGrades` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FirstAttDate` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `LastAttMod` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LastGradeUpdate` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Log` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `OrigSectionID` int(11) DEFAULT NULL,
  `Period_Obsolete` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `Section_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `StudentSectEnrl_guid` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StudYear` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherComment` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherID` int(11) DEFAULT NULL,
  `TeacherPrivateNote` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TermID` int(11) DEFAULT NULL,
  `Unused2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Unused3` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `classrank` */

DROP TABLE IF EXISTS `classrank`;

CREATE TABLE `classrank` (
  `DateRanked` date DEFAULT NULL,
  `GPA` double DEFAULT NULL,
  `GPAMethod` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Grade_Level` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Log` varchar(2000) COLLATE latin1_general_ci DEFAULT NULL,
  `OutOf` int(11) DEFAULT NULL,
  `Rank` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SchoolName` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `StoreCode` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `Unused1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `code_entity` */

DROP TABLE IF EXISTS `code_entity`;

CREATE TABLE `code_entity` (
  `CE_Code` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `CE_Entity` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `ComponentID` int(11) DEFAULT NULL,
  `Description` varchar(2000) COLLATE latin1_general_ci DEFAULT NULL,
  `Effective_End_Dt` date DEFAULT NULL,
  `Effective_Start_Dt` date DEFAULT NULL,
  `External_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Internal_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SortOrder` int(11) DEFAULT NULL,
  `Unused1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `course_relationship` */

DROP TABLE IF EXISTS `course_relationship`;

CREATE TABLE `course_relationship` (
  `Course_Number1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Relationship_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Relationship_Type` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `courses` */

DROP TABLE IF EXISTS `courses`;

CREATE TABLE `courses` (
  `Add_to_GPA` tinyint(1) DEFAULT NULL,
  `alt_course_number` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Corequisites` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreditType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Credit_Hours` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CrHrWeight` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ExcludeFromClassRank` tinyint(1) DEFAULT NULL,
  `ExcludeFromGPA` tinyint(1) DEFAULT NULL,
  `ExcludeFromHonorRoll` tinyint(1) DEFAULT NULL,
  `Exclude_ADA` tinyint(1) DEFAULT NULL,
  `GPA_AddedValue` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GradeScaleID` int(11) DEFAULT NULL,
  `ID` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MaxClassSize` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_Course_ID` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_Course_Type` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_Subject_Area_Code` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_TSDL_Exclude` tinyint(1) DEFAULT NULL,
  `Multiterm` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PowerLink` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PowerLinkSpan` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Prerequisites` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ProgramID` int(11) DEFAULT NULL,
  `RegAvailable` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RegCourseGroup` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RegGradeLevels` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RegTeachers` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_BalancePriority` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_BalanceTerms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_BlockStart` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_CloseSectionAfterMax` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ConcurrentFlag` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ConsecutivePeriods` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ConsecutiveTerms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_CoursePackage` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_CoursePkgContents` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_CourseSubjectAreaCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Department` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Do_Not_Print` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ExtraDayScheduleTypeCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Facilities` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Frequency` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_FullCatalogDescription` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_GlobalSubstitution1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_GlobalSubstitution2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_GlobalSubstitution3` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LabFlag` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LabFrequency` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LabPeriodsPerMeeting` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LengthInNumberOfTerms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LoadPriority` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LoadType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LunchCourse` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaximumDaysPerCycle` int(11) DEFAULT NULL,
  `Sched_MaximumEnrollment` int(11) DEFAULT NULL,
  `Sched_MaximumPeriodsPerDay` int(11) DEFAULT NULL,
  `Sched_MinimumDaysPerCycle` int(11) DEFAULT NULL,
  `Sched_MinimumPeriodsPerDay` int(11) DEFAULT NULL,
  `Sched_MultipleRooms` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_PeriodsPerCycle` int(11) DEFAULT NULL,
  `Sched_PeriodsPerMeeting` int(11) DEFAULT NULL,
  `Sched_RepeatsAllowed` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Scheduled` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ScheduleTypeCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_SectionsOffered` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_SubstitutionAllowed` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_TeacherCount` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_UsePreEstablishedTeams` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_UseSectionTypes` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ValidDayCombinations` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ValidExtraDayCombinations` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ValidStartPeriods` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Year` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolGroup` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SectionsToOffer` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Status` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TargetClassSize` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TermsOffered` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Vocational` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `customtext` */

DROP TABLE IF EXISTS `customtext`;

CREATE TABLE `customtext` (
  `FieldNo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `KeyNo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Value` varchar(3000) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `customvarchars` */

DROP TABLE IF EXISTS `customvarchars`;

CREATE TABLE `customvarchars` (
  `FieldNo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `KeyNo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Value` varchar(3000) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `cycle_day` */

DROP TABLE IF EXISTS `cycle_day`;

CREATE TABLE `cycle_day` (
  `Abbreviation` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Day_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Day_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Letter` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SortOrder` int(11) DEFAULT NULL,
  `Year_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `db_version` */

DROP TABLE IF EXISTS `db_version`;

CREATE TABLE `db_version` (
  `CreatedBy` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreatedDT` datetime DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `MajorVersion` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MinorVersion` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DB_VersionVersion` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `dblog` */

DROP TABLE IF EXISTS `dblog`;

CREATE TABLE `dblog` (
  `Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DBLogDate` date DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `IPAddress` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Server_InstanceID` int(11) DEFAULT NULL,
  `TData` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DBLogTime` time DEFAULT NULL,
  `DBLogType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `derivedperiodinfo` */

DROP TABLE IF EXISTS `derivedperiodinfo`;

CREATE TABLE `derivedperiodinfo` (
  `ID` int(11) NOT NULL,
  `Student_Number` int(11) DEFAULT NULL,
  `GPA` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `storedstandardscores` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `classrankweighted` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `teachercomments` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_name00` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_name01` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_name02` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_name03` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_name04` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_name05` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_name06` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_name07` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_name08` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `section_number00` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `section_number01` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `section_number02` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `section_number03` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `section_number04` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `section_number05` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `section_number06` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `section_number07` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `section_number08` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `room00` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `room01` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `room02` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `room03` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `room04` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `room05` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `room06` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `room07` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `room08` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_citizenship00` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_citizenship01` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_citizenship02` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_citizenship03` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_citizenship04` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_citizenship05` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_citizenship06` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_citizenship07` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_citizenship08` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_comment00` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_comment01` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_comment02` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_comment03` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_comment04` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_comment05` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_comment06` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_comment07` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `teacher_comment08` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S100` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S101` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S102` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S103` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S104` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S105` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S106` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S107` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S108` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S200` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S201` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S202` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S203` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S204` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S205` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S206` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S207` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `current_grade_S208` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `date_loaded` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `facility` */

DROP TABLE IF EXISTS `facility`;

CREATE TABLE `facility` (
  `Description` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `RoomType_guid` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `fee` */

DROP TABLE IF EXISTS `fee`;

CREATE TABLE `fee` (
  `Adjustment` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreationDate` date DEFAULT NULL,
  `Custom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FeeDate` date DEFAULT NULL,
  `FeeDateTime` datetime DEFAULT NULL,
  `Department_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Description` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FeeCharged` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Fee_Amount` double DEFAULT NULL,
  `Fee_Balance` double DEFAULT NULL,
  `Fee_Category_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Fee_Paid` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Fee_Type_ID` int(11) DEFAULT NULL,
  `Fee_Type_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Group_Transaction_ID` int(11) DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Internal_Info_For_Trigger` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Modificationdate` date DEFAULT NULL,
  `OriginalFee` double DEFAULT NULL,
  `Priority` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Pro_Rated` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolFee_ID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `System_User_ID` int(11) DEFAULT NULL,
  `TeacherID` int(11) DEFAULT NULL,
  `TermID` int(11) DEFAULT NULL,
  `FeeTime` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `fee_balance` */

DROP TABLE IF EXISTS `fee_balance`;

CREATE TABLE `fee_balance` (
  `Balance` double DEFAULT NULL,
  `Credit` double DEFAULT NULL,
  `Debit` double DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `TeacherID` int(11) DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `fee_transaction` */

DROP TABLE IF EXISTS `fee_transaction`;

CREATE TABLE `fee_transaction` (
  `Amount` double DEFAULT NULL,
  `Custom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Fee_TransactionDate` date DEFAULT NULL,
  `Fee_TransactionDateTime` datetime DEFAULT NULL,
  `Description` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `FeeID` int(11) DEFAULT NULL,
  `Global_NetEffect` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Global_Starting_Balance` double DEFAULT NULL,
  `Group_Transaction_ID` int(11) DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Internal_Info_For_Trigger` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NetEffect` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Payment_Ref_Nbr` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Payment_Method` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Receipt_Nbr` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Starting_Balance` double DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `System_User_ID` int(11) DEFAULT NULL,
  `TeacherID` int(11) DEFAULT NULL,
  `Fee_TransactionTime` time DEFAULT NULL,
  `Transaction_Type` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `fieldstable` */

DROP TABLE IF EXISTS `fieldstable`;

CREATE TABLE `fieldstable` (
  `ColNo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Cols` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FieldsTableData` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DataIndex` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Datalen` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FieldsTableDefault` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Description` varchar(2000) COLLATE latin1_general_ci DEFAULT NULL,
  `DispName` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `FieldNo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FileNo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FormatString` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FieldsTableHelp` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `HowDisp` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `HTML` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `InputFilter` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `InUse` tinyint(1) DEFAULT NULL,
  `MaxLen` int(11) DEFAULT NULL,
  `MaxVal` int(11) DEFAULT NULL,
  `MinVal` int(11) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Required` tinyint(1) DEFAULT NULL,
  `FieldsTableRows` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SyncStatus` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FieldsTableType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Unused1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `fte` */

DROP TABLE IF EXISTS `fte`;

CREATE TABLE `fte` (
  `Description` varchar(2000) COLLATE latin1_general_ci DEFAULT NULL,
  `Dflt_Att_Mode_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Dflt_Conversion_Mode_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FTE_Value` double DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `gen` */

DROP TABLE IF EXISTS `gen`;

CREATE TABLE `gen` (
  `Cat` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Date1` date DEFAULT NULL,
  `Date2` date DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Log` varchar(10000) COLLATE latin1_general_ci DEFAULT NULL,
  `Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PowerLink` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PowerLinkSpan` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SortOrder` int(11) DEFAULT NULL,
  `spedindicator` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Time1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Time2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Value` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `Value2` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `ValueLi` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `ValueLi2` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `ValueLi3` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `ValueLi4` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `ValueR` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `ValueR2` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `ValueT` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `ValueT2` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `Value_x` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `gradescaleitem` */

DROP TABLE IF EXISTS `gradescaleitem`;

CREATE TABLE `gradescaleitem` (
  `AddedValue` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Alt_Grade_Points` int(11) DEFAULT NULL,
  `CountsInGPA` tinyint(1) DEFAULT NULL,
  `CutoffPercentage` double DEFAULT NULL,
  `CutoffPoints` double DEFAULT NULL,
  `Description` varchar(2000) COLLATE latin1_general_ci DEFAULT NULL,
  `ExcludeFromAFG` tinyint(1) DEFAULT NULL,
  `GradeScaleID` int(11) DEFAULT NULL,
  `Grade_Points` double DEFAULT NULL,
  `GraduationCredit` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Modify_Code` tinyint(1) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `PowerLink` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PowerLinkSpanish` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherScale` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Value` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `gradestats` */

DROP TABLE IF EXISTS `gradestats`;

CREATE TABLE `gradestats` (
  `Student_Number` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `~(*gpa method="LHS_Cumulative_GPA")` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `~(*credit_hours)` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `~(*gpa method="LHS_Cumulative S1" term="S1")` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `~(*gpa method="LHS_Cumulative S2" term="S2")` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`Student_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `gradreq` */

DROP TABLE IF EXISTS `gradreq`;

CREATE TABLE `gradreq` (
  `AppliesTo` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `AppliesToData` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `AppliesToDataLi` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `AppliesToDisp` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Classification` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `CountInReqTots` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `CourseDesig` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `CourseGroup` varchar(40) COLLATE latin1_general_ci DEFAULT '',
  `CourseListCheck` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `CourseListHTML` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `CourseListOrder` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `CourseListT` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `CourseSource` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `CreditType` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Description` varchar(200) COLLATE latin1_general_ci DEFAULT '',
  `EntryBoxHeight` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `EntryBoxWidth` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `FieldComparator` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `FieldMatchValue` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `FieldName` varchar(40) COLLATE latin1_general_ci DEFAULT '',
  `FirstItem` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Grade_Level` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `GradReqSetID` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `How2DispCourses` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `ID` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `ItemType` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `ListBoxHeight` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MaxNoOfCourses` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MinimumMessage` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MinNoOfCourses` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MultiTerm` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Name` varchar(40) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `OverallCrHrs` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `ReqCrHrs` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `ReqForGrad` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `ReqTerms` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `RequestType` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `SchedPriority` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `SchoolID` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `SortOrder` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `SubjectArea` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Subtype` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Type` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  PRIMARY KEY (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `gradreqsets` */

DROP TABLE IF EXISTS `gradreqsets`;

CREATE TABLE `gradreqsets` (
  `GradReqSetID` int(11) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `SchoolID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `honorroll` */

DROP TABLE IF EXISTS `honorroll`;

CREATE TABLE `honorroll` (
  `DateStored` date DEFAULT NULL,
  `GPA` double DEFAULT NULL,
  `Grade_Level` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Level` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Log` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `Message` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `Method` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SchoolName` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `StoreCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `log` */

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `Category` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Consequence` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(3000) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_ActionDate` date DEFAULT NULL,
  `Discipline_ActionTaken` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_ActionTakenDetail` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_ActionTakenEndDate` date DEFAULT NULL,
  `Discipline_AdministratorID` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_AlcoholRelatedFlag` tinyint(4) DEFAULT NULL,
  `Discipline_DrugRelatedFlag` tinyint(4) DEFAULT NULL,
  `Discipline_DrugTypeDetail` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_DurationActual` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_DurationAssigned` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_DurationChangeSource` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_DurationNotes` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_FelonyFlag` tinyint(4) DEFAULT NULL,
  `Discipline_GangRelatedFlag` tinyint(4) DEFAULT NULL,
  `Discipline_HateCrimeFlag` tinyint(4) DEFAULT NULL,
  `Discipline_HearingOfficerFlag` tinyint(4) DEFAULT NULL,
  `Discipline_IncidentContext` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_IncidentDate` date DEFAULT NULL,
  `Discipline_IncidentLocation` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_IncidentLocDetail` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_IncidentType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_IncidentTypeCategory` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_IncidentTypeDetail` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_LikelyInjuryFlag` tinyint(4) DEFAULT NULL,
  `Discipline_MoneyLossValue` double DEFAULT NULL,
  `Discipline_Offender` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_PoliceInvolvedFlag` tinyint(4) DEFAULT NULL,
  `Discipline_Reporter` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_ReporterID` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_SchoolRulesVioFlag` tinyint(4) DEFAULT NULL,
  `Discipline_Sequence` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_VictimType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_WeaponRelatedFlag` tinyint(4) DEFAULT NULL,
  `Discipline_WeaponType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Discipline_WeaponTypeNotes` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Entry` varchar(4000) COLLATE latin1_general_ci DEFAULT NULL,
  `Entry_Author` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Entry_Date` date DEFAULT NULL,
  `Entry_Time` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `LogTypeID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `Student_Number` int(11) DEFAULT NULL,
  `Subject` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Subtype` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherID` int(11) DEFAULT NULL,
  KEY `NewIndex1` (`Consequence`),
  KEY `NewIndex2` (`Discipline_ActionDate`),
  KEY `NewIndex3` (`ID`),
  KEY `NewIndex4` (`Student_Number`),
  KEY `NewIndex5` (`SchoolID`),
  KEY `NewIndex6` (`StudentID`),
  KEY `NewIndex7` (`Subject`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `logins` */

DROP TABLE IF EXISTS `logins`;

CREATE TABLE `logins` (
  `Hits` int(11) DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `IPAddr` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LoginDate` date DEFAULT NULL,
  `LoginTicks` int(11) DEFAULT NULL,
  `LoginTime` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `LogoutDate` date DEFAULT NULL,
  `LogoutStatus` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LogoutTime` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `MinutesOnline` int(11) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `PageViews` int(11) DEFAULT NULL,
  `Platform` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `PSID` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PW` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `Unused1` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `UserAgent` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `UserType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `meta_update` */

DROP TABLE IF EXISTS `meta_update`;

CREATE TABLE `meta_update` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time_start` datetime DEFAULT NULL,
  `time_end` datetime DEFAULT NULL,
  `inserted_aggstats` int(11) DEFAULT NULL,
  `inserted_attendance` int(11) DEFAULT NULL,
  `inserted_attendance_code` int(11) DEFAULT NULL,
  `inserted_attendance_taken` int(11) DEFAULT NULL,
  `inserted_cc` int(11) DEFAULT NULL,
  `inserted_courses` int(11) DEFAULT NULL,
  `inserted_graduation_requirements` int(11) DEFAULT NULL,
  `inserted_log` int(11) DEFAULT NULL,
  `inserted_period` int(11) DEFAULT NULL,
  `inserted_schedulecatalogs` int(11) DEFAULT NULL,
  `inserted_schedulecc` int(11) DEFAULT NULL,
  `inserted_schedulecoursecatalogs` int(11) DEFAULT NULL,
  `inserted_scheduledepartments` int(11) DEFAULT NULL,
  `inserted_scheduleperiods` int(11) DEFAULT NULL,
  `inserted_sections` int(11) DEFAULT NULL,
  `inserted_stored_grades` int(11) DEFAULT NULL,
  `inserted_students` int(11) DEFAULT NULL,
  `inserted_students_calculated` int(11) DEFAULT NULL,
  `inserted_teachers` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `mimetypes` */

DROP TABLE IF EXISTS `mimetypes`;

CREATE TABLE `mimetypes` (
  `Mime` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Suffix` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `pages` */

DROP TABLE IF EXISTS `pages`;

CREATE TABLE `pages` (
  `PagesDirectory` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Filename` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `ModDate` date DEFAULT NULL,
  `ModifyCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ModSecs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ModTime` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Path` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `PagesSecurity` varchar(100) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `period` */

DROP TABLE IF EXISTS `period`;

CREATE TABLE `period` (
  `Abbreviation` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) NOT NULL,
  `Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Period_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Sort_Order` int(11) DEFAULT NULL,
  `Year_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`SchoolID`),
  KEY `NewIndex2` (`Year_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `person` */

DROP TABLE IF EXISTS `person`;

CREATE TABLE `person` (
  `ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `pgassignments` */

DROP TABLE IF EXISTS `pgassignments`;

CREATE TABLE `pgassignments` (
  `Abbreviation` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AssignmentID` int(11) DEFAULT NULL,
  `DateDue` date DEFAULT NULL,
  `Description` varchar(3000) COLLATE latin1_general_ci DEFAULT NULL,
  `GradebookType` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `IncludeInFinalGrades` tinyint(1) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `PGCategoriesID` int(11) DEFAULT NULL,
  `PointsPossible` int(11) DEFAULT NULL,
  `PublishDaysBeforeDue` int(11) DEFAULT NULL,
  `PublishOnSpecificDate` date DEFAULT NULL,
  `PublishScores` tinyint(1) DEFAULT NULL,
  `PublishState` tinyint(1) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `Type` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Weight` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `pgcategories` */

DROP TABLE IF EXISTS `pgcategories`;

CREATE TABLE `pgcategories` (
  `Abbreviation` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DefaultPtsPoss` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Description` varchar(3000) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `Unused1` varchar(100) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `pgcommentbank` */

DROP TABLE IF EXISTS `pgcommentbank`;

CREATE TABLE `pgcommentbank` (
  `Category` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Comment` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Unused1` varchar(100) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `pgfinalgrades` */

DROP TABLE IF EXISTS `pgfinalgrades`;

CREATE TABLE `pgfinalgrades` (
  `Citizenship` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PGFinalGradesComment` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `FinalGradeName` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Grade` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GradebookType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `LastGradeUpdate` date DEFAULT NULL,
  `OverrideFG` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Percent` double DEFAULT NULL,
  `Points` double DEFAULT NULL,
  `PointsPossible` double DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `VarCredit` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `pgnotification` */

DROP TABLE IF EXISTS `pgnotification`;

CREATE TABLE `pgnotification` (
  `Category` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Identifier` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Ntf_Value` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `TeacherID` int(11) DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `phonelog` */

DROP TABLE IF EXISTS `phonelog`;

CREATE TABLE `phonelog` (
  `PhoneLogDate` date DEFAULT NULL,
  `Duration` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `EntryType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `LogType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `OptionsChosen` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `StartTicks` int(11) DEFAULT NULL,
  `StartTime` time DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `prefs` */

DROP TABLE IF EXISTS `prefs`;

CREATE TABLE `prefs` (
  `ID` int(11) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `Value` int(11) DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `reenrollments` */

DROP TABLE IF EXISTS `reenrollments`;

CREATE TABLE `reenrollments` (
  `Custom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DistrictOfResidence` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `EnrollmentCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `EnrollmentType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `EntryCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `EntryComment` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `EntryDate` date DEFAULT NULL,
  `ExitCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ExitComment` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `ExitDate` date DEFAULT NULL,
  `FTEID` int(11) DEFAULT NULL,
  `FullTimeEquiv_obsolete` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Grade_Level` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `LunchStatus` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MembershipShare` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `StudentSchlEnrl_guid` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Track` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TuitionPayer` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ReEnrollmentsType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Withdrawal_Reason_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `registreq` */

DROP TABLE IF EXISTS `registreq`;

CREATE TABLE `registreq` (
  `AppliesTo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AppliesToData` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AppliesToDataLi` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AppliesToDisp` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Classification` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CountInReqTots` int(11) DEFAULT NULL,
  `CourseDesig` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CourseGroup` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CourseList` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CourseListCheck` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CourseListHTML` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CourseListOrder` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CourseSource` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreditType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Description` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `EntryBoxHeight` double DEFAULT NULL,
  `EntryBoxWidth` double DEFAULT NULL,
  `FieldComparator` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FieldMatchValue` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FieldName` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FirstItem` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Grade_Level` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `How2DispCourses` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `ItemType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ListBoxHeight` double DEFAULT NULL,
  `MaxNoOfCourses` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MinimumMessage` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MinNoOfCourses` int(11) DEFAULT NULL,
  `MultiTerm` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `OverallCrHrs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ReqCrHrs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ReqForGrad` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ReqTerms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RequestType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchedPriority` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SubType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SortOrder` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SubjectArea` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RegistReqType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `relationship` */

DROP TABLE IF EXISTS `relationship`;

CREATE TABLE `relationship` (
  `ID` int(11) DEFAULT NULL,
  `Person_ID` int(11) DEFAULT NULL,
  `ReciprocalRelationship_ID` int(11) DEFAULT NULL,
  `RelatedPerson_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `repobatchsetups` */

DROP TABLE IF EXISTS `repobatchsetups`;

CREATE TABLE `repobatchsetups` (
  `RepoBatchSetupsChecksum` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreationDate` date DEFAULT NULL,
  `CreationTime` time DEFAULT NULL,
  `CreationTimestamp` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Current_Selection_BLOB` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Destination` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RepoBatchSetupsEndDate` date DEFAULT NULL,
  `RepoBatchSetupsEndTime` time DEFAULT NULL,
  `External_FileName` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `External_FileSize` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FileName` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Internal_ID` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `InternationalCharsOption` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MergerAction` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Priority` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ReportID` int(11) DEFAULT NULL,
  `ReportSetupID` int(11) DEFAULT NULL,
  `Report_Output` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Resulting_error_code` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `Resulting_error_message` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Server_InstanceID` int(11) DEFAULT NULL,
  `Setups` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SpecificDate` date DEFAULT NULL,
  `SpecificTime` time DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `StartTime` time DEFAULT NULL,
  `StartTimestamp` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RepoBatchSetupsStatus` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TableToUse_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RepoBatchSetupsType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `UserVariablesAsText` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `User_Environment_BLOB` varchar(2000) COLLATE latin1_general_ci DEFAULT NULL,
  `Use_Current_Selection` tinyint(1) DEFAULT NULL,
  `WhenToExecute` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `zWhatToDoWithResult` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `repolookuptables` */

DROP TABLE IF EXISTS `repolookuptables`;

CREATE TABLE `repolookuptables` (
  `Internal_ID` int(11) DEFAULT NULL,
  `ReportSetupID` int(11) DEFAULT NULL,
  `Table_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `repolookuptablescontentsitems` */

DROP TABLE IF EXISTS `repolookuptablescontentsitems`;

CREATE TABLE `repolookuptablescontentsitems` (
  `Field_Index` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Internal_ID` int(11) DEFAULT NULL,
  `LookupTableID` int(11) DEFAULT NULL,
  `LookupTableRecordID` int(11) DEFAULT NULL,
  `Value` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `repolookuptablesdefitems` */

DROP TABLE IF EXISTS `repolookuptablesdefitems`;

CREATE TABLE `repolookuptablesdefitems` (
  `Description` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Field_Index` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Internal_ID` int(11) DEFAULT NULL,
  `Item_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LookupTableID` int(11) DEFAULT NULL,
  `max_nbr_of_chars` int(11) DEFAULT NULL,
  `Value_Type` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `reports` */

DROP TABLE IF EXISTS `reports`;

CREATE TABLE `reports` (
  `Body` varchar(2000) COLLATE latin1_general_ci DEFAULT NULL,
  `ColumnTitles` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Footing` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `Heading` varchar(1000) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `MasterFile` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NumCols` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `TeacherAccess` tinyint(1) DEFAULT NULL,
  `ReportsType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `unused5` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `unused6` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `reposetups` */

DROP TABLE IF EXISTS `reposetups`;

CREATE TABLE `reposetups` (
  `columns_display_headers` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `columns_export_headers` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `columns_generate_total_line` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `columns_multi_order` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `columns_nbr_items_per_line` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `columns_nbr_lines_per_page` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `columns_nbr_of_break_level` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `comments_to_user` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `contact_email` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `contact_job_title` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `contact_name` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `contact_phone` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `contact_url` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `CreationBy` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `CreationDate` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `DateOfImport` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Description` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_email_dest_address` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_email_msg` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_email_send_as_attac` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_email_subject` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_file_path` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_ftp_password` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_ftp_path` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_ftp_server_name` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_ftp_user_name` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_type` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `destination_web_MIME_type` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Disable_Curr_School_Only_Over` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Disable_Destination_Over` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Disable_Int_Char_Option_Over` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Disable_Nbr_of_Items_per_Line` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Disable_Nbr_of_Lines_per_Page` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Disable_Use_Current_Sel_Over` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Dont_Reset_Page_Number` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `DoubleQuoteSurrounded` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `DoubleQuote_RemoveWhenEmpty` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `due_date` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `encoding_type` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `FieldDelimiter` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `FileFormat` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `FileNameMaxLength` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `FileNameTemplate` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `FileNameTemplate_` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `FixedLength_TotalWidthInChars` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `footer_display` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `footer_export` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `footer_repeat_at_breaks` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `footer_text` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `For_current_school` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `general_owner_info` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `header_display` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `header_Export` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `header_repeat_at_breaks` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `header_text` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Include_in_List` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Internal_ID` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `International_Chars_Option` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `List_of_Values` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `LoadedFrom_DateStamp` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `LoadedFrom_FileName` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `LoadedFrom_FilePathOnly` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Management_ReportVersion` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Merger_User_Vars_Action` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `ModificationBy` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `ModificationDate` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `ModificationTime` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Att_Codes` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Att_Codes_Categ` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Att_Codes_Categ_Opt` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Att_Codes_Options` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Att_Conv` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Att_Modes` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_DateRange` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_DateToScan` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Dest` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Grades` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Grades_Options` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Grades_Script` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Items_per_Line` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_JavaScript_ToInsert` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Lines_per_page` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Misc` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Misc_Options` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Periods` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Periods_Options` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Prcs_Options` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Prcs_Options_Def` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Rep_Segments` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Schools` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Schools_Options` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Schools_Script` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Source` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Starting_Page_Nbr` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Submit_Button_Code` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Teachers` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Teachers_Options` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Teachers_Script` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Update_Script` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_UserVars_Sel_Script` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Weeks` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Param_Weeks_Options` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `programmer_comments` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `RecordDelimiter` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `ReportCategory` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `ReportID` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `ReportName` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `ReportType` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `revision_date` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `send_conf_to_email_address` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `send_error_to_email_address` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `State_ID` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `TableToUse` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `TableToUse_Name` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Template` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Unused1` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `UserModifiable` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Use_Current_Selection` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Use_Parameters_YN` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `validation_expression` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Value_Type` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `XML_FormatVersion` varchar(30) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `room` */

DROP TABLE IF EXISTS `room`;

CREATE TABLE `room` (
  `Building` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Department` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `facilities` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `House` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Occupancy_Maximum` int(11) DEFAULT NULL,
  `RoomInfo_guid` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Room_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `schedulecatalogs` */

DROP TABLE IF EXISTS `schedulecatalogs`;

CREATE TABLE `schedulecatalogs` (
  `Current` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Description` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `schedulecc` */

DROP TABLE IF EXISTS `schedulecc`;

CREATE TABLE `schedulecc` (
  `Bitmap` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `BuildID` int(11) DEFAULT NULL,
  `Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DateEnrolled` date DEFAULT NULL,
  `DateLeft` date DEFAULT NULL,
  `Expression` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `LoadLock` tinyint(1) DEFAULT NULL,
  `Period` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `SectionType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Section_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `StudYear` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherID` int(11) DEFAULT NULL,
  `TermID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `schedulecoursecatalogs` */

DROP TABLE IF EXISTS `schedulecoursecatalogs`;

CREATE TABLE `schedulecoursecatalogs` (
  `Add_to_GPA` tinyint(1) DEFAULT NULL,
  `Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Corequisites` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CourseCatalogID` int(11) DEFAULT NULL,
  `Course_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreditType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Credit_Hours` double DEFAULT NULL,
  `CrHrWeight` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GradeScaleID` int(11) DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `MaxClassSize` int(11) DEFAULT NULL,
  `Multiterm` tinyint(1) DEFAULT NULL,
  `PowerLink` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PowerLinkSpan` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Prerequisites` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RegAvailable` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RegCourseGroup` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RegGradeLevels` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RegTeachers` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_BalancePriority` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_BalanceTerms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_BlockStart` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_CloseSectionAfterMax` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ConcurrentFlag` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ConsecutivePeriods` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ConsecutiveTerms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_CoursePackage` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_CoursePkgContents` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_CourseSubjectAreaCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Demand` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Department` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Do_Not_Print` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ExtraDayScheduleTypeCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Facilities` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Frequency` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_FullCatalogDescription` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_GlobalSubstitution1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_GlobalSubstitution2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_GlobalSubstitution3` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LabFlag` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LabFrequency` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LabPeriodsPerMeeting` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LengthInNumberOfTerms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LoadPriority` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LoadType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_LunchCourse` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaximumDaysPerCycle` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaximumEnrollment` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaximumPeriodsPerDay` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MinimumDaysPerCycle` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MinimumPeriodsPerDay` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MinRoomCapacity` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MultipleRooms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_OverlapAllowed` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_PeriodsPerCycle` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_PeriodsPerMeeting` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_PrepCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Rank` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_RepeatsAllowed` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Scheduled` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ScheduleTypeCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_SectionsOffered` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_SubstitutionAllowed` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_TeacherCount` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_TotalConflictCourses` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_TotalConflictStudents` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_UsePreEstablishedTeams` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_UseSectionTypes` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ValidDayCombinations` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ValidExtraDayCombinations` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ValidStartPeriods` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Year` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolCrseInfo_guid` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolGroup` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SectionsToOffer` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StatusScheduleCourseCatologs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TargetClassSize` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TermsOffered` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Vocational` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `scheduledepartments` */

DROP TABLE IF EXISTS `scheduledepartments`;

CREATE TABLE `scheduledepartments` (
  `Description` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `scheduleperiods` */

DROP TABLE IF EXISTS `scheduleperiods`;

CREATE TABLE `scheduleperiods` (
  `Abbr` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `BlockStart` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `BuildID` int(11) DEFAULT NULL,
  `CorePeriod` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Description` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `EndTime1` time DEFAULT NULL,
  `EndTime2` time DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `PeriodID` int(11) DEFAULT NULL,
  `PeriodNumber` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ScheduleID` int(11) DEFAULT NULL,
  `ScheduleStudies` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `Sort` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StartTime1` time DEFAULT NULL,
  `StartTime2` time DEFAULT NULL,
  `UseForBuild` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `UseForLunches` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `schedulerequests` */

DROP TABLE IF EXISTS `schedulerequests`;

CREATE TABLE `schedulerequests` (
  `AlternateCourseNumber1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AlternateCourseNumber2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AlternateCourseNumber3` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AlternateGroupCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AlternatePriority` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CourseNumber` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreationCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GlobalAlternateCourse` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LoadStatusCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NoGlobalSubstitutionAllowed` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RegistReq_ID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SectionTypeCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `StudentSortField` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StudentYOGSort` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Student_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `unused` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `schedulerooms` */

DROP TABLE IF EXISTS `schedulerooms`;

CREATE TABLE `schedulerooms` (
  `Building` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Department` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DepartmentUseOnly` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Description` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Facilities` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FacilityUseOnly` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Free` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `House` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Maximum` int(11) DEFAULT NULL,
  `RoomNumber` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RoomType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Scheduled` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `UseAsHomeRoom` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `schedulesectionmeeting` */

DROP TABLE IF EXISTS `schedulesectionmeeting`;

CREATE TABLE `schedulesectionmeeting` (
  `BuildID` int(11) DEFAULT NULL,
  `Dayschedulesectionmeeting` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Periodschedulesectionmeeting` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `schedulesections` */

DROP TABLE IF EXISTS `schedulesections`;

CREATE TABLE `schedulesections` (
  `Bitmap` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `BlockPeriods_Obsolete` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `BuildID` int(11) DEFAULT NULL,
  `Building` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CampusID` int(11) DEFAULT NULL,
  `CommentScheduleSections` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreditType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Department` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Dependent_Secs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ExcludeFromClassRank` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ExcludeFromGPA` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ExcludeFromHonorRoll` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Expression` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GradeScaleID` int(11) DEFAULT NULL,
  `Grade_Level` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `House` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `LockedSection` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MaxCut` int(11) DEFAULT NULL,
  `MaxEnrollment` int(11) DEFAULT NULL,
  `Max_Load_Status` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NoAttendance` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `No_of_Students` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Period_Obsolete` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RoomScheduleSections` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SectionType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Section_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Teacher` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Team` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TermID` int(11) DEFAULT NULL,
  `Unused1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WhereTaught` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `scheduleteacherassignments` */

DROP TABLE IF EXISTS `scheduleteacherassignments`;

CREATE TABLE `scheduleteacherassignments` (
  `BuildID` int(11) DEFAULT NULL,
  `CatalogID` int(11) DEFAULT NULL,
  `CourseNumber` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Priority` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RequiredAssignment` tinyint(1) DEFAULT NULL,
  `ScheduleTermCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SectionsAssigned` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `SectionType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherKey` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `scheduleterms` */

DROP TABLE IF EXISTS `scheduleterms`;

CREATE TABLE `scheduleterms` (
  `Abbreviation` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AutoBuildBin` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FirstDay` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `ImportMap` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `IsYearRec` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LastDay` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `NoOfDays` double DEFAULT NULL,
  `Portion` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `TermsInYear` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearlyCreditHrs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `school_course` */

DROP TABLE IF EXISTS `school_course`;

CREATE TABLE `school_course` (
  `Alt_Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Att_Mode_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CourseID` int(11) DEFAULT NULL,
  `Course_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreatedBy` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CreatedDT` date DEFAULT NULL,
  `Exclude_State_Rpt_YN` tinyint(1) DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `ModifiedBy` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ModifiedDT` date DEFAULT NULL,
  `SchoolCrseInfo_guid` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `schools` */

DROP TABLE IF EXISTS `schools`;

CREATE TABLE `schools` (
  `Abbreviation` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ActiveCrsList` varchar(2000) COLLATE latin1_general_ci DEFAULT NULL,
  `Address` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Alternate_School_Number` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `AsstPrincipal` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `AsstPrincipalEmail` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `AsstPrincipalPhone` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `BulletinEmail` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `CountyName` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `CountyNbr` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `DfltNextSchool` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `District_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Fee_Exemption_Status` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `High_Grade` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Hist_High_Grade` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Hist_Low_Grade` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `IsSummerSchool` tinyint(1) DEFAULT NULL,
  `Low_Grade` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Name` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `PortalID` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Principal` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `PrincipalEmail` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `PrincipalPhone` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PSComm_Path` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `ScheduleWhichSchool` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolAddress` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolCity` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolCountry` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolFax` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolGroup` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolInfo_guid` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolPhone` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolState` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolZip` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `School_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SIF_StatePrId` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `SortOrder` int(11) DEFAULT NULL,
  `State_ExcludeFromReporting` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `SysEmailFrom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TchrLogEntrTo` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `View_in_Portal` varchar(20) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `section_meeting` */

DROP TABLE IF EXISTS `section_meeting`;

CREATE TABLE `section_meeting` (
  `Cycle_Day_Letter` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Meeting` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Period_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `Year_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `sections` */

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `Att_Mode_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Attendance` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Attendance_Type_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Bitmap` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `BlockPeriods_Obsolete` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `BuildID` int(11) DEFAULT NULL,
  `CampusID` int(11) DEFAULT NULL,
  `CCRNArray` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Comment` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Days_Obsolete` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Dependent_Secs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DistUniqueID` int(11) DEFAULT NULL,
  `ExcludeFromClassRank` tinyint(1) DEFAULT NULL,
  `ExcludeFromGPA` tinyint(1) DEFAULT NULL,
  `ExcludeFromHonorRoll` tinyint(1) DEFAULT NULL,
  `ExcludeFromStoredGrades` tinyint(1) DEFAULT NULL,
  `Exclude_ADA` tinyint(1) DEFAULT NULL,
  `Exclude_State_Rpt_YN` tinyint(1) DEFAULT NULL,
  `Expression` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FastPerList` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GradeProfile` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GradeScaleID` int(11) DEFAULT NULL,
  `Grade_Level` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `House` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Instruction_Lang` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LastAttUpdate` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Log` varchar(200) COLLATE latin1_general_ci DEFAULT NULL,
  `MaxCut` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MaxEnrollment` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Max_Load_Status` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NoOfTerms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `No_of_students` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Original_Expression` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Parent_Section_ID` int(11) DEFAULT NULL,
  `Period_Obsolete` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PGFlags` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PGVersion` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ProgramID` int(11) DEFAULT NULL,
  `Room` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `RosterModSer` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ScheduleSectionID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SectionInfo_guid` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Section_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Section_Type` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SortOrder` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Teacher` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherDescr` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Team` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TermID` int(11) DEFAULT NULL,
  `TrackTeacherAtt` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WhereTaught` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WhereTaughtDistrict` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `sectionscores` */

DROP TABLE IF EXISTS `sectionscores`;

CREATE TABLE `sectionscores` (
  `Assignment` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CommentSectionScores` varchar(300) COLLATE latin1_general_ci DEFAULT NULL,
  `Exempt` tinyint(1) DEFAULT NULL,
  `Grade` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Percent` double DEFAULT NULL,
  `Score` double DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `Unused1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `sectionscoresassignments` */

DROP TABLE IF EXISTS `sectionscoresassignments`;

CREATE TABLE `sectionscoresassignments` (
  `Assignment` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Comment_Value` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Exempt` tinyint(1) DEFAULT NULL,
  `FDCID` int(11) DEFAULT NULL,
  `Grade` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Percent` double DEFAULT NULL,
  `Score` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `sectionscoresid` */

DROP TABLE IF EXISTS `sectionscoresid`;

CREATE TABLE `sectionscoresid` (
  `ID` int(11) DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `selections` */

DROP TABLE IF EXISTS `selections`;

CREATE TABLE `selections` (
  `BlobIDs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NOfRecs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `TableID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `server_config` */

DROP TABLE IF EXISTS `server_config`;

CREATE TABLE `server_config` (
  `Config_GroupID` int(11) DEFAULT NULL,
  `Config_Value` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Created_By` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Created_TS` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Modified_By` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Modified_TS` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Server_InstanceID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `server_instance` */

DROP TABLE IF EXISTS `server_instance`;

CREATE TABLE `server_instance` (
  `Description` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Host_IP` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Host_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `Server_State` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Server_State_TS` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `User_Supplied_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Version_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `spenrollments` */

DROP TABLE IF EXISTS `spenrollments`;

CREATE TABLE `spenrollments` (
  `Code1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Code2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `Enter_Date` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ExitCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Exit_Date` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GradeLevel` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `ProgramID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SP_Comment` varchar(3000) COLLATE latin1_general_ci DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `storedgrades` */

DROP TABLE IF EXISTS `storedgrades`;

CREATE TABLE `storedgrades` (
  `AB_Course_Cmp_Ext_Crd` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Course_Cmp_Fun_Flg` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Course_Cmp_Fun_Sch` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Course_Cmp_Met_Cd` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Course_Cmp_Sta_Cd` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Course_Eva_Pro_Cd` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Dipl_Exam_Mark` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Final_Mark` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Lng_Cd` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AB_Pri_Del_Met_Cd` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Absences` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Behavior` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Comment` longtext COLLATE latin1_general_ci,
  `Course_Equiv` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Course_Number` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Credit_Type` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `DateStored` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `EarnedCrHrs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ExcludeFromClassRank` tinyint(1) DEFAULT NULL,
  `ExcludeFromGPA` tinyint(1) DEFAULT NULL,
  `ExcludeFromHonorRoll` tinyint(1) DEFAULT NULL,
  `GPA_AddedValue` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GPA_Custom1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GPA_Custom2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GPA_Points` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Grade` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Grade_Level` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `GradeScale_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `IsEarnedCrHrsFromGB` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `IsPotentialCrHrsFromGB` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Log` longtext COLLATE latin1_general_ci,
  `Percent` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PotentialCrHrs` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `SchoolName` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `StoreCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `Tardies` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Teacher_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TermID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `students` */

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `ACT_composite` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ACT_date` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `ACT_english` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ACT_math` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ACT_reading` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ACT_science` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Alert_Discipline` varchar(500) COLLATE latin1_general_ci DEFAULT '',
  `Alert_DisciplineExpires` date DEFAULT NULL,
  `Alert_Guardian` varchar(500) COLLATE latin1_general_ci DEFAULT '',
  `Alert_GuardianExpires` date DEFAULT NULL,
  `Alert_Medical` varchar(500) COLLATE latin1_general_ci DEFAULT '',
  `Alert_MedicalExpires` date DEFAULT NULL,
  `Alert_Other` varchar(500) COLLATE latin1_general_ci DEFAULT '',
  `Alert_OtherExpires` date DEFAULT NULL,
  `allergies` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `AllowWebAccess` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Apartment_Number` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Applic_Response_Recvd_Date` date DEFAULT NULL,
  `Applic_Submitted_Date` date DEFAULT NULL,
  `area` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ATE_skill_cert` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Autosend_howoften` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Balance1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Balance2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Balance3` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Balance4` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Building` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `BusNumberDropoff` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `BusNumberPickup` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Bus_Route` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Bus_Stop` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `CampusID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `City` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ClassOf` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_email` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_employer` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_recvmail` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_WPhone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt1_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_email` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_employer` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_recvmail` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Cnt2_WPhone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt2_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_email` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_employer` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_recvmail` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_wphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt3_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_email` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_employer` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_recvmail` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_wphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt4_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_email` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_employer` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_recvmail` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_wphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `cnt5_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Cumulative_GPA` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Cumulative_Pct` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `CustomRank_GPA` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `dateOfEntryIntoUSA` varchar(30) COLLATE latin1_general_ci DEFAULT '',
  `DistrictEntryDate` date DEFAULT NULL,
  `DistrictEntryGradeLevel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `DistrictOfResidence` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `DOB` date DEFAULT NULL,
  `Doctor_Name` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `Doctor_Phone` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `dpt` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `dtp1` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `dtp2` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `dtp3` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `dtp4` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `dtp5` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `ecnt1_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_email` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_recvmail` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_WPhone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt1_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_email` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_recvmail` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_WPhone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt2_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_email` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_recvmail` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_wphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt3_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_email` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_wphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt4_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_custody` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_email` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_fname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_hphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_lname` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_recvmail` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_state` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_wphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ecnt5_zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `eecnt1_cphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `eecnt1_rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_1_Ptype` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_1_Rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_2_Ptype` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_2_Rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_3_Phone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_3_Ptype` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_3_Rel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_Contact_1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_Contact_2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_Contact_3` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_Phone_1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Emerg_Phone_2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `EnrollmentCode` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `EnrollmentType` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Enrollment_SchoolID` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Enrollment_Transfer_Date_Pend` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Enrollment_Transfer_Info` varchar(300) COLLATE latin1_general_ci DEFAULT '',
  `Enroll_Status` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `EntryCode` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `EntryDate` date DEFAULT NULL,
  `ESL_placement` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Ethnicity` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Exclude_fr_rank` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ExitCode` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ExitComment` varchar(300) COLLATE latin1_general_ci DEFAULT '',
  `ExitDate` date DEFAULT NULL,
  `eye_data` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Family_Ident` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Father` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `fatherdayphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Father_Employer` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Father_home_phone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Father_StudentCont_guid` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `FedEthnicity` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `FedRaceDecline` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Fee_Exemption_Status` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `First_Name` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `FTEID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `FullTimeEquiv_obsolete` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Gender` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Geocode` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `Grade_Level` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `GradReqSet` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `GradReqSetID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Graduated_Rank` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Graduated_SchoolID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Graduated_SchoolName` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `graduation_year` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `guardian` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `guardiandayphone` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `GuardianEmail` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `GuardianFax` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `guardianship` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Guardian_FN` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Guardian_LN` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Guardian_MN` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Guardian_StudentCont_guid` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hearing_data` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `height_data` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hepatitis` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hepatitis1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hepatitis2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hepatitis3` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hepatitis4` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hepatitis_a` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hepatitis_a1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hepatitis_a2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hib` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hib1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hib2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hib3` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `hib4` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `HLN` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Home_Phone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Home_Room` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `homeless` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `homeless_code` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `House` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ID_Immune_Status` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `ILDP` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `include_time_share` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Inf1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Inf2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `IsSpecialEdEligible` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `LastFirst` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `LastMeal` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Last_Name` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `LDAPEnabled` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `LEP_exit_date` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `LEP_status` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Locker_Combination` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Locker_Number` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Log` varchar(3000) COLLATE latin1_general_ci DEFAULT '',
  `Lot_Number` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `LPAC_date` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `LunchStatus` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Lunch_ID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Mailing_Geocode` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `Mailing_City` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Mailing_State` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Mailing_Street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Mailing_Zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `medical_considerations` varchar(300) COLLATE latin1_general_ci DEFAULT '',
  `med_other1` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `med_other2` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `med_other3` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `med_other4` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `med_other5` varchar(100) COLLATE latin1_general_ci DEFAULT '',
  `meis_attendance` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `meis_fte_in_gen_ed` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `MembershipShare` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Middle_Name` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_ECDaysPerWeek` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECDaysPerWeek2` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECDeliveryMethod` varchar(30) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECDeliveryMethod2` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECDeliveryMethod3` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECDeliveryMethod4` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECDeliveryMethod5` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECHoursPerDay` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECHoursPerDay2` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECProgramEndDate` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECProgramEndDate2` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECProgramStartDate` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ECProgramStartDate2` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_EligibilityCode` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_ExitCode` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_ExitDate` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_IFSPDate` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_PartBEligible` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_PrimarySetting` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_Service1` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_Service2` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_Service3` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_EI_Service4` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_ethnAfr` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_ethnAsi` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_ethnInd` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_ethnLat` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_ethnPac` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_ethnWhi` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_Father_Cust_No` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_FiscalEntityCode` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_FiscalEntityTypeCode` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_LEP_CountryOrigin` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_LEP_Enrollment` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_LEP_ExitCode` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_LEP_ExitDate` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_LEP_LocFundPgm` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_LEP_PrimaryLanguage` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_LEP_Pupil_LimEng` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_LEP_Refugee_ImpPgm` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_LEP_Title3` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_LEP_Title3_ImmEd` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_LunchStatAppFlag` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_Mother_Cust_No` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_MultipleBirth` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_Resident_County_Code` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SCMOperISDESANum` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_Setting` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_AdditionalDisability` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_ExitCode` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_ExitDate` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_FTE52` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_FTE53` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_Hours` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_IEPAnotherDistrict` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_IEPDate` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_IEPDays` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_ParenConsEval` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_PrgmServiceCode1` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_PrgmServiceCode2` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_PrgmServiceCode3` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_PrimaryDisability` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_PrimaryEdSetting` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_ResofIIEP` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_SupportServices1` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_SupportServices2` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_SupportServices3` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_SupportServices4` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SpEd_SupportServices5` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_10_30_DayRule` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_AdminUnit` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_BirthCity` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_Early_Middle_College` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_PrgmElig_504` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_PrgmElig_EarlyIntervention` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_PrgmElig_LEP` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_PrgmElig_SpEd` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_PrgmElig_Title1` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_SRSD_StudentUIC` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_SRSD_StudResLEANum` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_SRSD_StudResMembership` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_StdntExplus_ExpelDate` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_StdntExplus_ExpelFollowup` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `MI_StdntExplus_ExpelLength` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_StdntExplus_IncidentDate` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_StdntExplus_IncidentLocation` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_StdntExplus_IncidentPrimaryVictim` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_StdntExplus_IncidentTime` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_StuEnrollEC1` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `MI_Unaccompanied_Youth` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `monitor_date` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Mother` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `motherdayphone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Mother_Employer` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Mother_home_phone` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Mother_StudentCont_guid` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Name_Suffix` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Next_School` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `parttimestudent` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `Person_ID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Phone_ID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `PhotoFlag` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `PL_Language` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `PO_Box` varchar(20) COLLATE latin1_general_ci DEFAULT '',
  `polio` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `polio1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `polio2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `polio3` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `polio4` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `polio5` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `PPV1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `PPV2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `prevstudentid` varchar(40) COLLATE latin1_general_ci DEFAULT '',
  `PVC1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `PVC2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `PVC3` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `PVC4` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `rv` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `rv1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `rv2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `rv3` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `SAT` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_LoadLock` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_LockStudentSchedule` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_NextYearBuilding` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_NextYearBus` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_NextYearGrade` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_NextYearHomeRoom` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_NextYearHouse` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_NextYearTeam` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_Priority` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_Scheduled` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sched_YearOfGraduation` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `SchoolEntryDate` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `SchoolEntryGradeLevel` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `SchoolID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `SDataRN` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `secondarylanguage` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Simple_GPA` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Simple_PCT` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `singleparenthshldflag` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Sports_LHS` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `SSN` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `State` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `State_EnrollFlag` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `State_ExcludeFromReporting` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `State_StudentNumber` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Street` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `StudentPers_guid` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `StudentPict_guid` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `StudentSchlEnrl_guid` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Student_AllowWebAccess` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `student_email` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Student_Number` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Student_Web_ID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Student_Web_Password` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `SummerSchoolID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `SummerSchoolNote` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `tb1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `tb2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `tb3` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Td` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Td1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `td2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `td3` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `td4` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `td5` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `TeacherGroupID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Team` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Track` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Tracker` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `TransferComment` varchar(300) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `TuitionPayer` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Var1` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Var2` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `varicella` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Volleyball_7gr_girls` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `Web_ID` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Web_Password` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `weight_data` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Withdrawal_Reason_Code` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `WM_Address` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `WM_CreateDate` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `WM_CreateTime` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `WM_Password` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `WM_Status` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `WM_StatusDate` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `WM_TA_Date` varchar(50) COLLATE latin1_general_ci DEFAULT '',
  `WM_TA_Flag` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `WM_Tier` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `Zip` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`SchoolID`),
  KEY `NewIndex2` (`Enroll_Status`),
  KEY `NewIndex3` (`Grade_Level`),
  KEY `NewIndex4` (`Student_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `students_calculated` */

DROP TABLE IF EXISTS `students_calculated`;

CREATE TABLE `students_calculated` (
  `student_id` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `student_number` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `gpa_simple` decimal(5,2) DEFAULT NULL,
  `gpa_weighted` decimal(5,2) DEFAULT NULL,
  `gpa_s1` decimal(5,2) DEFAULT NULL,
  `gpa_s2` decimal(5,2) DEFAULT NULL,
  `gpa_2007` decimal(5,2) DEFAULT NULL,
  `gpa_2008` decimal(5,2) DEFAULT NULL,
  `gpa_2009` decimal(5,2) DEFAULT NULL,
  `gpa_2010` decimal(5,2) DEFAULT NULL,
  `gpa_2011` decimal(5,2) DEFAULT NULL,
  `gpa_2012` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `studenttest` */

DROP TABLE IF EXISTS `studenttest`;

CREATE TABLE `studenttest` (
  `Grade_Level` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `TermID` int(11) DEFAULT NULL,
  `TestID` int(11) DEFAULT NULL,
  `Test_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `teachers` */

DROP TABLE IF EXISTS `teachers`;

CREATE TABLE `teachers` (
  `Access` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AdminLDAPEnabled` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AllowLoginEnd` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `AllowLoginStart` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `Balance1` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Balance2` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Balance3` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Balance4` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `CanChangeSchool` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `City` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Classpua` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Custom` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `DefaultStudScrn` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `dob` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Email_Addr` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Ethnicity` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FedEthnicity` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FedRaceDecline` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `First_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `gender` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GradebookType` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `GroupTeachers` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `HomePage` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Homeroom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Home_Phone` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `ID` int(11) NOT NULL,
  `IPAddrRestrict` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LastFirst` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LastMeal` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Last_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `LogTeachers` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Log` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  `LoginID` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Lunch_ID` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `Maximum_Load` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Middle_Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_ethnAfr` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_ethnAsi` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_ethnInd` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_ethnLat` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_ethnPac` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `MI_ethnWhi` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `mi_rep_pic` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NameAsImported` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NoOfCurClasses` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NumLogins` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Password` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PeriodsAvail` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Photo` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PowerGradePW` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PreferredName` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `PSAccess` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `REPDtTermEmp` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `REPEmpStat` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `REPHighDeg` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_ActivityStatusCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_BuildingCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Classroom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Department` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Gender` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Homeroom` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_HouseCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_IsTeacherFree` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Lunch` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaximumConsecutive` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaximumCourses` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaximumDuty` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaximumFree` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaxPers` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_MaxPreps` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_PrimarySchoolCode` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Scheduled` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Substitute` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_TeacherMoreOneSchool` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_Team` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_TotalCourses` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_UseBuilding` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Sched_UseHouse` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `School_Phone` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SIF_StatePrid` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SSN` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StaffPers_guid` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `StaffStatus` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `State` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Status` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Street` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `supportContact` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherLDAPEnabled` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherLoginID` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherLoginIP` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherLoginPW` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TeacherNumber` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Title` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WM_Address` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WM_Alias` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WM_CreateDate` date DEFAULT NULL,
  `WM_CreateTime` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WM_Exclude` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WM_Password` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WM_Status` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `WM_StatusDate` date DEFAULT NULL,
  `WM_TA_Date` date DEFAULT NULL,
  `WM_TA_Flag` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `WM_Tier` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Zip` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NewIndex1` (`Ethnicity`),
  KEY `NewIndex2` (`gender`),
  KEY `NewIndex3` (`SchoolID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*Table structure for table `terms` */

DROP TABLE IF EXISTS `terms`;

CREATE TABLE `terms` (
  `Abbreviation` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Attendance_Calculation_Code` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `AutoBuildBin` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Days_Per_Cycle` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `FirstDay` date DEFAULT NULL,
  `ID` int(11) DEFAULT NULL,
  `ImportMap` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `IsYearRec` tinyint(1) DEFAULT NULL,
  `LastDay` date DEFAULT NULL,
  `Name` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `NoOfDays` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Periods_Per_Day` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `Portion` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `SchoolID` int(11) DEFAULT NULL,
  `STerms` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TermInfo_guid` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `TermsInYear` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `YearID` int(11) DEFAULT NULL,
  `YearlyCreditHrs` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
