drop database Rohingya_Rehabilitation_Center_50642023;
create database Rohingya_Rehabilitation_Center_50642023;

use Rohingya_Rehabilitation_Center_50642023;

create table Person(
	personID varchar(10) primary key,
    fname varchar(40),
    lname varchar(40),
    gender enum("Male","Female","Others"),
    personType enum("Staff", "Visitor", "Patient","Refugee"),
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
    foreign key(branchLocationID)  references Address(addressID) on delete cascade
);
 
create table Program (
	programID int auto_increment primary key,
    departmentOfferingID int,
    programName varchar(100),
    foreign key (departmentOfferingID)  references Department(departmentID) on delete cascade
);

create table Room (
	roomID int primary key auto_increment,
    capacity int,
    victimTypesContained varchar(30),
    num_victimsAccommodatd int,
    check(num_victimsAccommodatd <= capacity)
);

create table Staff(
	staffID varchar(10) primary key,
    departmentID int,
    branchBasedID int,
    email varchar(100) , 
    Primary_Tel_Num varchar (15),
    foreign key(staffID)  references Person(personID) on delete cascade,
    foreign key(departmentID)  references Department(departmentID) on delete cascade,
    foreign key(branchBasedID)  references Branch(branchID) on delete cascade,
    check ( email like "%__@__%")
);

create table Refugee (
	refugeeID varchar(10) primary key,
    roomID int,
    homeCountry varchar(40),
    countryIssue varchar(100),
    foreign key(refugeeID)  references Person(personID) on delete cascade,
	foreign key(roomID) references Room(roomID) on delete cascade
);

create table Patient (
	patientID varchar(10) primary key,
    roomID int,
    illnessStatus varchar (30),
    pastHospitalName varchar (80),
    foreign key(patientID)  references Person(personID) on delete cascade,
	foreign key(roomID) references Room(roomID) on delete cascade
);

create table Visitor (
	visitorID varchar(10) primary key,
    patientVisitedID varchar(10),
    dateVisited date,
	arrivalTime	time,
    departureTime time,
    foreign key(patientVisitedID)  references Patient (patientID) on delete cascade,
    foreign key(visitorID)  references Person (personID) on delete cascade
);

--  WEAK ENTITIES

create table Staff_Program (
	staffID varchar(10),
    programID int,
    foreign key(staffID) references Staff(staffID) on delete cascade,
    foreign key(programID) references Program(programID) on delete cascade
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
    foreign key(patientID) references Patient(patientID) on delete cascade,
    foreign key(visitorID) references Visitor(visitorID) on delete cascade
);

create table healthRecord (
	patientID varchar(10),
    diagnosedOf varchar(50),
    bloodGroup char(2),
    foreign key(patientID) references Patient(patientID) on delete cascade
);

-- TABLES POPULATION

-- INSERTION INTO THE PERSON TABLE FOR THE DIFFERENT PERSON GROUP

-- INSERTION OF A PERSON STAFF
insert into Person values
("S001","Rancho","Shamaldass","Male", "Staff","1992-03-10"),
("S002","Chanchad","Samar","Male", "Staff","1989-01-08"),
("S003","Rohit","Anjali","Female", "Staff","1995-11-14"),
("S004","Mustapha","Amar","Male", "Staff","1992-03-10"),
("S005","Veer","Zaara","Female", "Staff","1993-12-20");

-- INSERTION A PERSON VISITOR
insert into Person values
("V001","Aman","Sharma","Male", "Visitor","1999-03-13"),
("V002","George","Rhea","Female", "Visitor","1990-11-08"),
("V003","Salman","Khan","Male", "Visitor","1983-11-14"),
("V004","Sharukh","Khan","Male", "Visitor","1982-03-10"),
("V005","Sana","Dharma","Female", "Visitor","1995-02-20");

-- INSERTION A PERSON PATIENT
insert into Person values
("P001","Aman","Sharman","Male", "Patient","1970-12-10"),
("P002","Kajol","Salman","Female", "Patient","1986-11-28"),
("P003","Dave","Kaali","Male", "Patient","1985-11-14"),
("P004","Sana","Kubur","Female", "Patient","1970-03-02"),
("P005","Pryanka","Kadr","Female", "Patient","1983-09-30"),
("P006","Dave","Soni","Male", "Patient","1993-05-30"),
("P007","Sana","Katappa","Female", "Patient","1973-09-10"),
("P008","Bahubali","Samr","Male", "Patient","1980-04-20"),
("P009","Davesana","Radgmata","Female", "Patient","1985-12-30"),
("P010","Jack","Conor","Male", "Patient","1982-09-10");

-- INSERTION A PERSON REFUGEE
insert into Person values
("R001","Khna","Jamaldeen","Male", "Refugee","1984-03-04"),
("R002","Sara","Timothy","Female", "Refugee","1970-01-07"),
("R003","Karl","Desmond","Male", "Refugee","1995-11-14"),
("R004","Path","Conor","Female", "Refugee","1984-03-17"),
("R005","Veer","Singh","Male", "Refugee","1973-10-19"),
("R006","Anjali","Sharma","Female", "Refugee","1977-11-09"),
("R007","Farhan","Khrishna","Male", "Refugee","1983-03-15"),
("R008","Moo","Dhorma","Female", "Refugee","1993-10-28");

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
insert into Room (capacity, victimTypesContained, num_victimsAccommodatd) values
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
("R005", 4, "Yemen", "Civil War"),
("R006", 3, "Yemen", "Civil War"),
("R007", 3, "Yemen", "Civil War"),
("R008", 2, "Syria", "Natural Disaster");


--  INSERTION INTO PATIENT TABLE
insert into Patient(patientID, roomID, illnessStatus, pastHospitalName) values
("P001", 1, "critical condition" ,"New Yangon General Hospital"),
("P002", 1, "mild condition" ,"Insein General Hospital"),
("P003", 5, "mild condition"  ,"East Yangon General Hospital"),
("P004", 5, "critical condition"  ,"500-bed Specialty Hospital"),
("P005", 1, "critical condition"  ,"Defence Services Orthopaedic Hospital"),
("P006", 5, "mild condition"  ,"East Yangon General Hospital"),
("P007", 1, "critical condition"  ,"Yagon Old Teaching Hospital Infection"),
("P008", 5, "critical condition"  ,"Community Health Center of Yagon"),
("P009", 5, "mild condition"  ,"East Yangon General Hospital"),
("P010", 1, "critical condition"  ,"Defence Services Orthopaedic Hospital");

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
("S002", 3),
("S002", 5),
("S004", 1),
("S005", 4);

-- INSERTION INTO THE REFUGEE PROGRAM 
insert into Refugee_Program(refugeeID, programID) values
("R001", 6), ("R001", 7), ("R001", 5), ("R002", 6),
("R002", 7), ("R002", 5), ("R003", 6), ("R003", 7),
("R003", 5), ("R004", 6), ("R004", 7), ("R007", 5),
("R004", 4), ("R005", 6), ("R007", 7), ("R005", 5),
("R005", 4), ("R006", 4), ("R002", 4), ("R008", 4);

-- INSERTION INTO THE PATIENT PROGRAM 
insert into Patient_Program(patientID, programID) values
("P001", 1), ("P001", 2), 
("P002", 1), ("P002", 2), 
("P003", 1), ("P004", 2), 
("P004", 1), ("P005", 1),
("P006", 2), ("P008", 2),
("P006", 1), ("P008", 1), 
("P007", 1), ("P009", 2), 
("P007", 2), ("P010", 1);

-- INSERTION INTO THE PATIENT PROGRAM 
insert into Patient_Visitor(patientID, visitorID) values
("P001", "V003"),
("P002", "V005"),
("P004", "V003"),
("P005", "V001"),
("P003", "V002"),
("P003", "V001"),
("P004", "V002"),
("P005", "V003"),
("P005", "V002"),
("P006", "V004"),
("P009", "V005"),
("P008", "V002"),
("P006", "V003"),
("P010", "V001");

-- INSERTION INTO THE PATIENT PROGRAM 
insert into healthRecord values
("P001", "Stroke", "A"),
("P002", "schemic Heart Disease", "B"),
("P003", "Chronic obstructive pulmonary disease", "AB"),
("P004", "Trachea, bronchus, and lung cancers", "AB"),
("P005", "Alzheimer’s disease", "O"),
("P006", "Adrenocortical Carcinoma", "A"),
("P007", "Adrenomyodystrophy", "A"),
("P008", "Adrenal gland hypofunction", "B"),
("P009", "Acromegaly", "AB"),
("P010", "Acute Erythroblastic Leukemia", "O");


-- CREATING INDEXES

-- creating an index for the names of the programs run by the organization
create index programs on Program (programName);

-- creating an index for the status of the illness of all the patients in the organization 
create index patientCondition on Patient (illnessStatus);

-- creating an index for the home countries of the refugees in the organization
create index home_country on Refugee(homeCountry);

-- creating for all the person groups in the organization
create index personGroup on Person(personType);  

-- QUERY ONE
-- INFORMATION ABOUT ALL REFUGEES
-- Information about all the refugees in the organization, ranging from their personal information , their home country,
-- and the phenomena that cowed their movement from their home countries.

select Person.personID as "refugeeID", Room.roomID, Person.lname as "last name", Person.fname as "first name", Person.dateOfBirth,
	Person.gender, Refugee.homeCountry, Refugee.countryIssue
	from (Person inner join Refugee on Person.personID = Refugee.refugeeID)
	join Room on Room.roomID = Refugee.roomID
    where Refugee.homeCountry = "Yemen"
order by Refugee.homeCountry;


-- QUERY TWO
-- INFORMATION ABOUT ALL PATIENTS
-- This retrives the information about all the patients , including their past hospitals 
-- before they were rehabilitated and their health record

select Person.personID as "patient Identifier", Person.lname as "last name",
Person.fname as "first name",  Room.roomID, Room.victimTypesContained as "In With", Person.dateOfBirth, Person.gender, Patient.pastHospitalName, 
healthRecord.bloodGroup, healthRecord.diagnosedOf, Patient.illnessStatus
from (Person join Patient on Person.personID = Patient.patientID join healthRecord on Patient.patientID = healthRecord.patientID)
join Room on Room.roomID = Patient.roomID
where Patient.illnessStatus IN ("critical condition", "mild condition")
order by "patient Identifier";


-- QUERY THREE

-- QUERY THREE
-- This retrives information about the programs run by the organization, and the information about the 
-- the number of victims(patients and refugees) taking them
select  Department.departmentID, Department.departmentName, Program.programID, Program.programName as "Program Name" ,
	(count(Patient_Program.ProgramID) + count(Refugee_Program.refugeeID)) as "Number of Victims Taking Program" from 
	(Program left join Refugee_Program on Program.programID = Refugee_Program.programID join Department on
	Program.departmentOfferingID = Department.departmentID) left join Patient_Program on 
	Patient_Program.programID = Program.programID
	where "Number of Victims Taking Program" <= 5 and "Program Name" not like "Gidance%"
group by Program.programName order by Program.programID ;


-- QUERY FOUR
-- This tracks the visiting activities among visitors and patients in the organization
select Person.lname, Person.fname, Visitor.visitorID, dateVisited, arrivalTime, departureTime from Person 
inner join Visitor on Person.personID = Visitor.patientVisitedID inner join Patient on Person.personID = Patient.patientID
where illnessStatus in (
	select illnessStatus from Patient 
    where illnessStatus = "critical condition"
);


-- QUERY FIVE
-- This stores information about the staff in the organization, and the number of the programs they coordinate in the entity
select lname as "Staff Lname", fname as "Staff Fname", gender, branchName as "Branch", departmentName as "Department", Staff.staffID as "ID", 
count(distinct Staff_Program.staffID, Staff_Program.programID) as "Number of Programs Allocated to Staff" 
from (Staff inner join Person on Person.personID = Staff.staffID inner join Branch on Staff.branchBasedID = Branch.branchID inner join 
Department on Staff.departmentID = Department.departmentID) 
join Staff_Program on Staff_Program.staffID = Staff.staffID left join 
Program on Program.programID = Staff_Program.programID group by Staff_program.staffID;


-- QUERY SIX
-- This retrieves information about the individual total number of the individual victims accomodated in the organization
select distinct personType as "People", count(personID) as "Number"
from Person where personType not in ("Staff","Visitor") 
group by personType;
