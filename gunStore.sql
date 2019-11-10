
drop database if exists GUN_STORE;
create database GUN_STORE;
use GUN_STORE;

/* The tables are created in each of these blocks and sample values are loaded for each table */

create table STORE (
	StoreNo INT NOT NULL AUTO_INCREMENT,
	Location char(50) NOT NULL,
	PRIMARY KEY (StoreNo)
);

insert into STORE (Location) values ('Hyderabad');
insert into STORE (Location) values ('Bangalore');
insert into STORE (Location) values ('Chennai');


create table CUSTOMER (
	CustomerID char(10) not null,
	Fname char(20) not null,
	Mname char(20),
	Lname char(20) not null,
	TotalPurchaseValue float not null default '0',
	ContactNo char(10) not null,				/* left as atomic attribute for now */
	VerifiedBy char(10) not null,
	primary key (CustomerID)		
);

insert into CUSTOMER values ('1234567890', 'Anirudh', 'Narayan', 'Palutla', '0', '7799806566', '9876543210');
insert into CUSTOMER (CustomerID, Fname, Lname, TotalPurchaseValue, ContactNo, VerifiedBy) values ('2222222222', 'Nikhil', 'E', '69', '1213231344', '9876543210');
insert into CUSTOMER (CustomerID, Fname, Lname, TotalPurchaseValue, ContactNo, VerifiedBy) values ('3333333333', 'Tanmay', 'Sachan', '420', '1313331344', '9876543310');


create table EMPLOYEE (
	EmployeeID char(10) not null,
	Fname char(20) not null,
	Mname char(20),
	Lname char(20) not null,
	DoB date not null,
	YearsWorked int not null,
	Sex char(2) not null,
	ContactNo char(10) not null,				/* left as atomic attribute for now */
	Salary int not null,
	ManagerID char(10) not null,
	WorksAt int not null,
	primary key (EmployeeID)
);

insert into EMPLOYEE values ('9876543210', 'Nigga', 'Gay', 'Employeet', '2001-02-18', '3', 'M', '1212121212', '42069', '9876543310', '1');


create table DEPENDANT (
	DependsOn char(10) not null,
	Fname char(20) not null,
	Mname char(20),
	Lname char(20) not null,
	ContactNo char(10) not null,			/* left as atomic attribute for now */
	constraint DependantKey primary key (DependsOn, Fname, Lname)
);

insert into DEPENDANT values ('9876543210', 'Fag', '', 'Yeet', '6969696969');


create table STORE_CONTACTNOS (
	StoreNo int not null,
	ContactNo char(10) not null,
	constraint StoreContactKey primary key (StoreNo, ContactNo)
);

insert into STORE_CONTACTNOS values ('1', '1231231231');
insert into STORE_CONTACTNOS values ('1', '1232232232');
insert into STORE_CONTACTNOS values ('2', '2232232232');
insert into STORE_CONTACTNOS values ('2', '1262232232');


create table MANUFACTURER (
	Name char(40) not null,
	Country char(15) not null,
	YearEst date not null,
	primary key (Name)
);

insert into MANUFACTURER values ('JihadTime', 'Pakistan', '2001-09-11');


create table FACTORY (
	ManufacturerName char(40) not null,
	LocationID char(40) not null,
	constraint FactoryKey primary key (ManufacturerName, LocationID)
);

insert into FACTORY values ('JihadTime', 'Karachi');
insert into FACTORY values ('JihadTime', 'Hyderabad');


create table FACTORY_CONTACTNOS (
	FactoryManufacturerName char(40) not null,
	FactoryLocationID char(40) not null,
	ContactNo char(10) not null,
	constraint FactoryContactKey primary key (FactoryManufacturerName, FactoryLocationID, ContactNo)
);

insert into FACTORY_CONTACTNOS values ('JihadTime', 'Karachi', '1111111111');
insert into FACTORY_CONTACTNOS values ('JihadTime', 'Karachi', '6666666666');

create table AMMO (
	CartridgeName char(40) not null, 
	Shape char(40) not null,
	NoOfRounds bigint not null,
	Caliber char(10) not null,
	Cost bigint not null, 
	primary key (CartridgeName)
);

insert into AMMO values ('TulAmmo 223 Rem', 'FMJ', '1000', '.223', '132074');

create table GUN_MODEL (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	Cost bigint not null,
	FireRate bigint not null,
	Colour char(20) not null,
	constraint GunModelKey primary key (Manufacturer, ModelType)
);

insert into GUN_MODEL values ('Kalashnikov', 'KR-9', '96359', '1000', 'Black');

create table ATTACHMENT (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	Cost bigint not null,
	AttachmentType char(20) not null, 
	constraint AttachmentKey primary key (Manufacturer, ModelType)
);

insert into ATTACHMENT values ('COAST', 'HP-7', '2640', 'Flashlight');
