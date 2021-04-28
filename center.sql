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
	departmentID int primary key,
    departmentName varchar(50)
);

create table Address(
	addressID int primary key,
    country varchar(50),
    district varchar(50),
    region varchar(50),
    city varchar(50),
    street varchar(50),
    landmark varchar(50)
);

create table Branch(
	branchID int primary key,
    branchLocation int,
    branchName varchar(50),
    foreign key(branchLocation)  references Address(addressID)
);

create table Program (
	programID int auto_increment primary key,
    departmentOfferingID int,
    programName varchar(100),
    foreign key (departmentOfferingID)  references Department(departmentID)
);

create table Room (
	roomID int primary key,
    capacity int,
    victimsAccommodated int
);

create table Staff(
	staffID varchar(10) primary key,
    centerBranchID int,
    departmentID int,
    branchBasedID int,
    roomID int,
    email varchar(100), -- chech 
    foreign key(staffID)  references Person(personID),
    foreign key(departmentID)  references Department(departmentID),
    foreign key(branchBasedID)  references Branch(branchID)
);

create table Refugee (
	refugeeID varchar(10) primary key,
    roomID int,
    homeCountry varchar(40),
    countryVictim varchar(100),
    foreign key(refugeeID)  references Person(personID),
	foreign key(roomID) references Room(roomID)
);

create table Patient (
	patientID varchar(10) primary key,
    roomID int,
    pastHospitalName varchar (50),
    foreign key(patientID)  references Person(personID),
	foreign key(roomID) references Room(roomID)
);

create table Visitor (
	visitorID varchar(10) primary key,
    patientID varchar(10),
    dateVisited date,
    arrivalTime time,
    departureTime time,
    foreign key(patientID)  references Patient (patientID),
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
