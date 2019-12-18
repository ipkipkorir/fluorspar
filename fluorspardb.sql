/*drop database if exists*/
DROP DATABASE IF EXISTS fluorspardb;

/*create database*/
CREATE DATABASE fluorspardb;

/*display all databases*/
SHOW databases;

/*use fluorspardb*/
USE fluorspardb;

/*create tables*/
/****************/
/*create table parent*/
CREATE TABLE parent (
	firstName VARCHAR(10) NOT NULL,
	lastName VARCHAR(10) NOT NULL,
	otherName VARCHAR(10) NULL,
	parentId INT(4),
	nationalId INT(8) NULL UNIQUE,
	phoneNo INT(11) NULL UNIQUE,
	emailAddress VARCHAR(130) NULL,

	PRIMARY KEY(parentId)
);

/*create table class*/
CREATE TABLE class (
	classId INT(3),
	className VARCHAR(10) NOT NULL UNIQUE,
	description text(150) NULL,

	PRIMARY KEY(classId)
);

/*create table student*/
CREATE TABLE student ( 
	firstName VARCHAR(10) NOT NULL,
	lastName VARCHAR(10) NOT NULL,
	otherName VARCHAR(10) NULL,
	birthDate date NOT NULL,
	studentId INT(5) NOT NULL,
	classId INT(3),
	parentId INT(4),

	PRIMARY KEY(studentId),
	CONSTRAINT studentClassFk FOREIGN KEY(classId) REFERENCES class(classId) ON DELETE CASCADE,
	CONSTRAINT studentParentFk FOREIGN KEY(parentId) REFERENCES parent(parentId) ON DELETE CASCADE
	);

/*create table category*/
CREATE TABLE category (
	categoryId INT(3),
	categoryName VARCHAR(40) NOT NULL,
	description text(150) NULL,

	PRIMARY KEY(categoryId)
);

/*create table subject*/
CREATE TABLE subject (
	subjectId INT(3),
	subjectName VARCHAR(40),
	categoryId INT(3),

	PRIMARY KEY (subjectId),
	CONSTRAINT subjectCategoryFk FOREIGN KEY(categoryId) REFERENCES category(categoryId) ON DELETE CASCADE
);

/*create table receipt*/
CREATE TABLE receipt (
	receiptId INT(5),
	issueDate date NOT NULL,
	paymentMethod VARCHAR(20) NOT NULL,
	amount INT(6) NOT NULL,
	studentId INT(5) NOT NULL,
	parentId INT(4) NOT NULL,

	PRIMARY KEY(receiptId),
	CONSTRAINT studentReceiptFk FOREIGN KEY(studentId) REFERENCES student(studentId) ON DELETE CASCADE,
	CONSTRAINT parentReceiptFk FOREIGN KEY(parentId) REFERENCES parent(parentId) ON DELETE CASCADE
);

/*create table studentSubject*/
CREATE TABLE studentSubject (
	studentId INT(5) NOT NULL,
	subjectId INT(3) NOT NULL,

	PRIMARY KEY(studentId, subjectId),
	CONSTRAINT studentSubjectFk1 FOREIGN KEY(studentId) REFERENCES student(studentId) ON DELETE CASCADE,
	CONSTRAINT studentSubjectFk2 FOREIGN KEY(subjectId) REFERENCES subject(subjectId) ON DELETE CASCADE
);

/*create table department*/
CREATE TABLE department(
	departmentName VARCHAR(50) NOT NULL,
	departmentId INT(3),
	description TEXT(150) NULL,

	PRIMARY KEY(departmentId)
);

/*create table employee*/
CREATE TABLE employee (
	firstName VARCHAR(12) NOT NULL,
	lastName VARCHAR(12) NOT NULL,
	otherName VARCHAR(12) NULL,
	employeeId INT(7) NOT NULL,
	startDate date NOT NULL,
	departmentId INT(3),
	nationalId INT(8) NOT NULL UNIQUE,
	jobTitle VARCHAR(150),
	salary INT(6) NOT NULL,

	PRIMARY KEY(employeeId),
	CONSTRAINT employeeFk FOREIGN KEY(departmentId) REFERENCES department(departmentId) ON DELETE CASCADE
);