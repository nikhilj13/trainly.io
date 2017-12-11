/*
used mySQL to generate the DDL
*/
DROP DATABASE IF EXISTS TRAINLYIO;
CREATE DATABASE TRAINLYIO;
USE TRAINLYIO;
 
CREATE TABLE Student(
StudentID int(11) NOT NULL AUTO_INCREMENT,
StudentEmail VARCHAR(255),
Fname VARCHAR(255),
Lname VARCHAR(255),
Password VARCHAR(255),
ProfilePic VARCHAR(255),
Street VARCHAR(255),
City VARCHAR(255),
Country VARCHAR(255),
PostalCode VARCHAR(5),
PRIMARY KEY (StudentID)
);

ALTER TABLE Student AUTO_INCREMENT=101;
 
CREATE TABLE StudentPhone(
StudentID int(11),
Phone VARCHAR(255),
PRIMARY KEY(StudentID, Phone)
);
 
CREATE TABLE Faculty (
FacultyID int(11) PRIMARY KEY,
FacultyEmail VARCHAR(255),
Fname VARCHAR(255),
Lname VARCHAR(255),
Password VARCHAR(255),
ProfilePic VARCHAR(255),
Street VARCHAR(255),
City VARCHAR(255),
Country VARCHAR(255),
PostalCode VARCHAR(5),
Affiliation VARCHAR(255),
Title VARCHAR(255),
Website VARCHAR(255),
ValidatedBy int(11),
ValidatedDate DATE,
ValidatedTime TIME);
 
 
CREATE TABLE Admin (
AdminID int(11),
AdminEmail VARCHAR(255),
Fname VARCHAR(255),
Lname VARCHAR(255),
Password VARCHAR(255),
ProfilePic VARCHAR(255),
Street VARCHAR(255),
City VARCHAR(255),
Country VARCHAR(255),
PostalCode VARCHAR(5),
PermittedBy int(11),
PermittedDate DATE,
PermittedTime TIME,
PRIMARY KEY(AdminID)
);
 
 
CREATE TABLE Course (
 	CourseID VARCHAR(255),
 	Name VARCHAR(255),
 	Description VARCHAR(255),
 	Cost FLOAT,
 	Icon VARCHAR(255),
 	PrimaryTopic VARCHAR(255) NOT NULL,
 	PRIMARY KEY(CourseID)
);
CREATE TABLE Secondary_Topic (
 	CourseID VARCHAR(255),
 	SecondaryTopic VARCHAR(255),
 	PRIMARY KEY(CourseID, SecondaryTopic)	
);
CREATE TABLE Enrolled (
 	StudentID int(11),
 	CourseID VARCHAR(255),
 	CourseCompletionDate DATE,
 	CourseCompletionTime TIME,
 	Comment VARCHAR(255),
 	Rating INT,
 	CONSTRAINT rating_chk CHECK(Rating>0 AND Rating<=5),
 	PaymentDate DATE,
 	PaymentTime TIME,
	PaymentCode VARCHAR(6),
 	PRIMARY KEY(StudentID, CourseID)
);
CREATE TABLE Creates (
 	FacultyID int(11),
 	CourseID VARCHAR(255),
	CreationDate DATE,
 	PRIMARY KEY(FacultyID, CourseID)
);
CREATE TABLE Interested (
 	StudentID int(11),
 	CourseID VARCHAR(255),
 	PRIMARY KEY(StudentID, CourseID)
);
 
CREATE TABLE Download (
 	MaterialName VARCHAR(255),
	CourseID VARCHAR(255),
 	Path VARCHAR(255),
 	Size FLOAT,
 	Type VARCHAR(255),
 	PRIMARY KEY(CourseID, MaterialName)
);
CREATE TABLE Link (
 	Url VARCHAR(255),
 	MaterialName VARCHAR(255),
CourseID VARCHAR(255),
 	PRIMARY KEY(MaterialName, CourseID)
);
CREATE TABLE Url_Type (
 	Url VARCHAR(255),
 	Tag VARCHAR(255),
 	PRIMARY KEY(Url)
);
CREATE TABLE Post (
 	MaterialName VARCHAR(255),
CourseID VARCHAR(255),
 	Text VARCHAR(255),
 	PRIMARY KEY(CourseID, MaterialName)
);
CREATE TABLE Course_Material (
MaterialName VARCHAR(255),
CourseID VARCHAR(255),	
 	CourseOrder INT,
PRIMARY KEY(MaterialName, CourseID, CourseOrder)
);
 
CREATE TABLE Belongs_To (
 	CourseID VARCHAR(255),
 	QuestionID VARCHAR(255),
 	MaterialName VARCHAR(255),
 	PRIMARY KEY(CourseID,QuestionID,MaterialName)
);
 
CREATE TABLE Completes_Material (
 	CourseID VARCHAR(255),
 	StudentID int(11),
 	MaterialName VARCHAR(255),
 	Date DATE,
 	Time TIME,
 	PRIMARY KEY(CourseID, StudentID, MaterialName)
);
CREATE TABLE Course_Question(
QuestionID VARCHAR(255),
CourseID VARCHAR(255),
CourseQuestion VARCHAR(255),
PRIMARY KEY (QuestionID, CourseID)
);
 
CREATE TABLE Likes (
QuestionID VARCHAR(255),
CourseID VARCHAR(255),
Rating INT,
CONSTRAINT like_ratingchk CHECK(Rating>0 AND Rating<=5),
StudentID int(11),
PRIMARY KEY (QuestionID, CourseID, StudentID)
);
 
CREATE TABLE VisibleTo (
QuestionID VARCHAR(255),
CourseID VARCHAR(255),
FacultyID int(11),
MakeVisible BOOLEAN,
Answer VARCHAR(255),
PRIMARY KEY (QuestionID, CourseID, FacultyID)
);
 
ALTER TABLE Faculty
ADD FOREIGN KEY(FacultyID) REFERENCES Student(StudentID);
 
ALTER TABLE StudentPhone
ADD FOREIGN KEY(StudentID) REFERENCES Student(StudentID);
 
ALTER TABLE Admin
ADD FOREIGN KEY(AdminID) REFERENCES Student(StudentID),
ADD FOREIGN KEY(PermittedBy) REFERENCES Admin(AdminID);
 
ALTER TABLE Secondary_Topic
ADD FOREIGN KEY(CourseID) REFERENCES Course(CourseID);
 
ALTER TABLE Enrolled
ADD FOREIGN KEY(CourseID) REFERENCES Course(CourseID),
ADD FOREIGN KEY(StudentID) REFERENCES Student(StudentID);
 
ALTER TABLE Interested
ADD FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
ADD FOREIGN KEY(CourseID) REFERENCES Course(CourseID);
 
ALTER TABLE Creates
ADD FOREIGN KEY(FacultyID) REFERENCES Faculty(FacultyID),
ADD FOREIGN KEY(CourseID) REFERENCES Course(CourseID);
 
ALTER TABLE VisibleTo  
ADD FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
ADD FOREIGN KEY (QuestionID) REFERENCES Course_Question(QuestionID),
ADD FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID);
 
ALTER TABLE LIKES               
ADD FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
ADD FOREIGN KEY (QuestionID) REFERENCES Course_Question(QuestionID),
ADD FOREIGN KEY (StudentID) REFERENCES Student(StudentID);
ALTER TABLE Course_Material
ADD FOREIGN KEY(CourseID) REFERENCES Course(CourseID);
 
ALTER TABLE Belongs_To
ADD FOREIGN KEY(CourseID) REFERENCES Course(CourseID),
ADD FOREIGN KEY(QuestionID) REFERENCES Course_Question(QuestionID),
ADD FOREIGN KEY(MaterialName) REFERENCES Course_Material(MaterialName);
 
ALTER TABLE Download
ADD FOREIGN KEY(MaterialName) REFERENCES Course_Material(MaterialName),
ADD FOREIGN KEY(CourseID) REFERENCES Course_Material(CourseID);
 
ALTER TABLE Link
ADD FOREIGN KEY(MaterialName) REFERENCES Course_Material(MaterialName),
ADD FOREIGN KEY(CourseID) REFERENCES Course_Material(CourseID),
ADD FOREIGN KEY(Url) REFERENCES Url_Type(Url);
 
ALTER TABLE Post
ADD FOREIGN KEY(MaterialName) REFERENCES Course_Material(MaterialName),
ADD FOREIGN KEY(CourseID) REFERENCES Course_Material(CourseID);
 
ALTER TABLE Completes_Material
ADD FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
ADD FOREIGN KEY(MaterialName) REFERENCES Course_Material(MaterialName);
 
 

