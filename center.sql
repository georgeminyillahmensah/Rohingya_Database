create database Rohingya_Rehabilitation_Center;

use Rohingya_Rehabilitation_Center;

create table Person(
	personID varchar(10) primary key,
    fname varchar(40),
    lname varchar(40),
    gender enum("Male","Female","Others"),
    dateOfBirth date
);

create table Department(
	departmentID int primary key auto_increment,
    departmentName varchar(50) default "HealthCare and Safety"
);

create table Address(
	addressID int primary key auto_increment,
    country varchar(50),
    district varchar(50),
    region varchar(50),
    city varchar(50),
    street varchar(50),
    landmark varchar(50)
);

create table Branch(
	branchID int primary key auto_increment,
    branchLocationID int,
    branchName varchar(50) default "Main Branch",
    foreign key(branchLocationID)  references Address(addressID)
);
 
create table Program (
	programID int auto_increment primary key,
    departmentOfferingID int,
    programName varchar(100),
    foreign key (departmentOfferingID)  references Department(departmentID)
);

create table Room (
	roomID int primary key auto_increment,
    capacity int,
    victimTypesContained varchar(30),
    num_victimsAccommodated int,
    check(num_victimsAccommodated <= capacity)
);

create table Staff(
	staffID varchar(10) primary key,
    departmentID int,
    branchBasedID int,
    email varchar(100) , 
    Primary_Tel_Num varchar (15),
    foreign key(staffID)  references Person(personID),
    foreign key(departmentID)  references Department(departmentID),
    foreign key(branchBasedID)  references Branch(branchID),
    check ( email like "%__@__%")
);

create table Refugee (
	refugeeID varchar(10) primary key,
    roomID int,
    homeCountry varchar(40),
    countryIssue varchar(100),
    foreign key(refugeeID)  references Person(personID),
	foreign key(roomID) references Room(roomID)
);

create table Patient (
	patientID varchar(10) primary key,
    roomID int,
    illnessStatus varchar (30),
    pastHospitalName varchar (80),
    foreign key(patientID)  references Person(personID),
	foreign key(roomID) references Room(roomID)
);

create table Visitor (
	visitorID varchar(10) primary key,
    patientVisitedID varchar(10),
    dateVisited date,
    arrivalTime time,
    departureTime time,
    foreign key(patientVisitedID)  references Patient (patientID),
    foreign key(visitorID)  references Person (personID)
);

--  WEAK ENTITIES

create table Staff_Program (
	staffID varchar(10),
    programID int,
    foreign key(staffID) references Staff(staffID),
    foreign key(programID) references Program(programID)
);

create table Refugee_Program (
	RefugeeID varchar(10),
    programID int,
    foreign key(RefugeeID) references Refugee(RefugeeID),
    foreign key(programID) references Program(programID)
);

create table Patient_Program (
	PatientID varchar(10),
    programID int,
    foreign key(PatientID) references Patient(PatientID),
    foreign key(programID) references Program(programID)
);

create table Patient_Visitor (
	patientID varchar(10),
    visitorID varchar(10),
    foreign key(patientID) references Patient(patientID),
    foreign key(visitorID) references Visitor(visitorID)
);

create table healthRecord (
	patientID varchar(10),
    diagnosedOf varchar(50),
    bloodGroup char(2),
    foreign key(patientID) references Patient(patientID)
);

-- TABLES POPULATION

-- INSERTION INTO THE PERSON TABLE FOR THE DIFFERENT PERSON GROUP

-- INSERTION A PERSON STAFF
insert into Person values
("S001","Rancho","Shamaldass","Male","1992-03-10"),
("S002","Chanchad","Samar","Male","1989-01-08"),
("S003","Rohit","Anjali","Female","1995-11-14"),
("S004","Mustapha","Amar","Male","1992-03-10"),
("S005","Veer","Zaara","Female","1993-12-20");

-- INSERTION A PERSON VISITOR
insert into Person values
("V001","Aman","Sharma","Male","1999-03-13"),
("V002","George","Rhea","Female","1990-11-08"),
("V003","Salman","Khan","Male","1983-11-14"),
("V004","Sharukh","Khan","Male","1982-03-10"),
("V005","Sana","Dharma","Female","1995-02-20");

-- INSERTION A PERSON PATIENT
insert into Person values
("P001","Aman","Sharman","Male","1970-12-10"),
("P002","Kajol","Salman","Female","1986-11-28"),
("P003","Dave","Kaali","Male","1985-11-14"),
("P004","Sana","Kubur","Female","1970-03-02"),
("P005","Pryanka","Kadr","Female","1983-09-30");


-- INSERTION A PERSON REFUGEE
insert into Person values
("R001","Khna","Jamaldeen","Male","1984-03-04"),
("R002","Sara","Timothy","Female","1970-01-07"),
("R003","Karl","Desmond","Male","1995-11-14"),
("R004","Path","Conor","Female","1984-03-17"),
("R005","Veer","Singh","Male","1973-10-19");


-- INSERTION INTO DEPARTMENT TABLE
insert into department(departmentName) values
("HealthCare and Safety"),
("Human Resources"),
("Chaplaincy"),
("Security Service"),
("Accommodation and Housing"),
("Therapy and Emotional Control Unit");


-- INSERTION INTO PROGRAM TABLE
insert into Program (departmentOfferingID, programName) values
(6, "Therapy For Mental Stability"),
(1, "Fitness and Muscle Educatiion"),
(3, "Gidance and Spirituality"),
(2, "Leadership and the Act of Leading"),
(4, "Self Defense and Protection"),
(2, "Design Thinking"),
(2, "Entreprenuership");

-- INSERTION INTO ADDRESS TABLE
insert into Address (country, district, region, city, street, landmark) values
("Myanmar", "Kyaukse", "Ayeyarwady","Yangon", "Kyaukse Highway", "Kyaukse Mall"),
("Myanmar", "Mandalay", "Bago","Naypyidaw", "Mandalay Course", "Naypyidaw Main road"),
("Myanmar", "Meiktila", "Magway","Mawlamyine", "Meiktila Highway", "Meiktila Cemetary"),
("Myanmar", "Myingyan", "Mandalay","Mogok", "Myingyan 203", "Myingyan Park"),
("Myanmar", "Yamethin", "Sagaing","Minbu", "Yamethin Highway", "Minbu Statue");

-- INSERTION INTO BRANCH TABLE
insert into Branch(branchLocationID, branchName) values
(1, "Main Branch"),
(4, "Rohingya-Mandalay-Branch"),
(2, "Rohingya-Bago-Branch"),
(3, "Rohingya-Magway-Branch"),
(5, "Rohingya-Yamethin-Branch");

-- INSERTION INTO ROOM TABLE
insert into Room (capacity, victimTypesContained, num_victimsAccommodated) values
(10, "Patients", 8),
(30, "Refugees", 29),
(25, "Refugees", 25),
(16, "Refugees", 16),
(4, "Patients", 4);

--  INSERTION INTO STAFF TABLE
insert into Staff (staffID, departmentID, branchBasedID, email, Primary_Tel_Num) values
("S001", 1, 1, "ranchoshamaldass001@rohingya.com", "+766 201514922"),
("S002", 2, 2, "chanchadsamar@rohingya.com", "+766 5549413110"),
("S003", 3, 3, "rohitanjali@rohingya.com", "+766 245742865"),
("S004", 4, 4, "mustaphaamar@rohingya.com", "+766 5496360216"),
("S005", 6, 5, "veerzaara@rohingya.com", "+766 541700790");

--  INSERTION INTO REFUGEE TABLE
insert into Refugee(refugeeID, roomID, homeCountry, countryIssue) values
("R001", 2, "Yemen", "Civil War"),
("R002", 2, "Yemen", "Civil War"),
("R003", 3, "Syria", "Civil War"),
("R004", 4, "India-Mumbai", "Famine"),
("R005", 4, "Haiti", "Ntural Disasters");

--  INSERTION INTO PATIENT TABLE
insert into Patient(patientID, roomID, illnessStatus, pastHospitalName) values
("P001", 1, "critical condition" ,"New Yangon General Hospital"),
("P002", 1, "mild condition" ,"Insein General Hospital"),
("P003", 5, "mild condition"  ,"East Yangon General Hospital"),
("P004", 5, "critical condition"  ,"500-bed Specialty Hospital"),
("P005", 1, "critical condition"  ,"Defence Services Orthopaedic Hospital");

-- INSERT INTO THE VICTIM TABLE

insert into Visitor(visitorID, patientVisitedID, dateVisited, arrivalTime, departureTime) values
("V001", "P001", "2017-02-22", "16:30:51", "17:10:11"),
("V002", "P005", "2018-04-10", "16:35:45", "17:12:23"),
("V003", "P002", "2020-12-23", "16:40:02", "17:09:43"),
("V004", "P003", "2020-05-20", "16:32:33", "17:15:42"),
("V005", "P004", "2019-09-14", "16:37:52", "17:20:35");

-- INSERTION INTO THE STAFF PROGRAM 
insert into Staff_Program(staffID, programID) values
("S001", 1),
("S002", 4),
("S003", 3),
("S004", 5),
("S005", 1),
("S001", 2),
("S002", 3);

-- INSERTION INTO THE REFUGEE PROGRAM 
insert into Refugee_Program(refugeeID, programID) values
("R001", 6), ("R001", 7), ("R001", 5), ("R002", 6),
("R002", 7), ("R002", 5), ("R003", 6), ("R003", 7),
("R003", 5), ("R004", 6), ("R004", 7), ("R004", 5),
("R004", 4), ("R005", 6), ("R005", 7), ("R005", 5),
("R005", 4), ("R001", 4), ("R002", 4), ("R003", 4);

-- INSERTION INTO THE PATIENT PROGRAM 
insert into Patient_Program(patientID, programID) values
("P001", 1), ("P001", 2), 
("P002", 1), ("P002", 2), 
("P003", 1), ("P004", 2), 
("P004", 1), ("P005", 1),
("P001", 2);

-- INSERTION INTO THE PATIENT PROGRAM 
insert into Patient_Visitor(patientID, visitorID) values
("P001", "V003"),
("P002", "V005"),
("P004", "V003"),
("P005", "V001"),
("P003", "V002");

-- INSERTION INTO THE PATIENT PROGRAM 
insert into healthRecord values
("P001", "Stroke", "A"),
("P002", "schemic Heart Disease", "B"),
("P003", "Chronic obstructive pulmonary disease", "AB"),
("P004", "Trachea, bronchus, and lung cancers", "AB"),
("P005", "Alzheimer’s disease", "O");
