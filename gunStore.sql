
drop database if exists GUN_STORE;
create database GUN_STORE;
use GUN_STORE;

/* The tables are created in each of these blocks and sample values are loaded for each table */

create table STORE (
	StoreNo INT NOT NULL AUTO_INCREMENT,
	LocationID char(50) NOT NULL,
	constraint StoreKey primary key (StoreNo)
) engine=InnoDB default charset=latin1;

insert into STORE (LocationID) values ('Hyderabad');
insert into STORE (LocationID) values ('Bangalore');
insert into STORE (LocationID) values ('Chennai');


create table EMPLOYEE (
	EmployeeID char(10) not null,
	Fname char(20) not null,
	Mname char(20),
	Lname char(20) not null,
	DoB date not null,
	YearsWorked int not null,
	Sex char(2) not null,
	Salary int not null,
	ManagerID char(10),
	WorksAt int not null,
	constraint EmployeeKey primary key (EmployeeID),
	constraint Employee1 foreign key (WorksAt) references STORE (StoreNo) on delete cascade on update cascade,
	constraint Employee2 foreign key (ManagerID) references EMPLOYEE (EmployeeID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into EMPLOYEE values ('0000000001', 'Tanmay', '', 'Sachan', '2000-03-23', '3', 'M', '10000', NULL, '1');
insert into EMPLOYEE values ('0000000005', 'Akshat', '', 'Gahoi', '1999-08-12', '3', 'M', '30000', NULL, '1');
insert into EMPLOYEE values ('0000000002', 'Anirudh', '', 'Palutla', '2000-08-10', '5', 'M', '20000', NULL, '2');
insert into EMPLOYEE values ('0000000004', 'Nikhil', 'E', 'Rao', '2000-03-23', '7', 'M', '10000', NULL, '3');


create table EMPLOYEE_CONTACTNOS (
	EmployeeID char(10) not null,
	ContactNo char(10) not null,
	constraint EmployeeContactNosKey primary key (EmployeeID, ContactNo),
	constraint EmployeeContactNos1 foreign key (EmployeeID) references EMPLOYEE (EmployeeID) on delete cascade on update cascade
);

insert into EMPLOYEE_CONTACTNOS values ('0000000001', '1893749183');
insert into EMPLOYEE_CONTACTNOS values ('0000000002', '1479183749');
insert into EMPLOYEE_CONTACTNOS values ('0000000005', '8410989810');

create table CUSTOMER (
	CustomerID char(10) not null,
	Fname char(20) not null,
	Mname char(20),
	Lname char(20) not null,
	TotalPurchaseValue float not null default '0',
	VerifiedBy char(10) not null,
	constraint CustomerKey primary key (CustomerID),
	constraint Customer1 foreign key (VerifiedBy) references EMPLOYEE (EmployeeID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into CUSTOMER values ('0000000001', 'Shivansh', 'Tiwari', 'Seth', '10', '0000000001');
insert into CUSTOMER (CustomerID, Fname, Lname, TotalPurchaseValue, VerifiedBy) values ('0000000002', 'Istasis', 'Mishra', '70', '0000000005');
insert into CUSTOMER (CustomerID, Fname, Lname, TotalPurchaseValue, VerifiedBy) values ('0000000003', 'Risubh', 'Jain', '420', '0000000004');

create table CUSTOMER_CONTACTNOS (
	CustomerID char(10) not null,
	ContactNo char(10) not null,
	constraint CustomerContactNosKey primary key (CustomerID, ContactNo),
	constraint CustomerContactNos1 foreign key (CustomerID) references CUSTOMER (CustomerID) on delete cascade on update cascade
);

insert into CUSTOMER_CONTACTNOS values ('0000000001', '1934810938');
insert into CUSTOMER_CONTACTNOS values ('0000000002', '1924810938');
insert into CUSTOMER_CONTACTNOS values ('0000000003', '8597698475');

create table DEPENDANT (
	DependsOn char(10) not null,
	Fname char(20) not null,
	Mname char(20),
	Lname char(20) not null,
	ContactNo char(10) not null,			/* left as atomic attribute for now */
	constraint DependantKey primary key (DependsOn, Fname, Lname),
	constraint Dependant1 foreign key (DependsOn) references EMPLOYEE (EmployeeID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into DEPENDANT values ('0000000001', 'Akshat', NULL, 'Chhajer', '1984909818');
insert into DEPENDANT values ('0000000002', 'Manas', NULL, 'Kabre', '1984909838');
insert into DEPENDANT values ('0000000001', 'Shourja', NULL, 'Mukherjee', '4738295723');


create table STORE_CONTACTNOS (
	StoreNo int not null,
	ContactNo char(10) not null,
	constraint StoreContactNosKey primary key (StoreNo, ContactNo),
	constraint StoreContactNos1 foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into STORE_CONTACTNOS values ('1', '1231231231');
insert into STORE_CONTACTNOS values ('1', '1232232232');
insert into STORE_CONTACTNOS values ('2', '2232232232');
insert into STORE_CONTACTNOS values ('2', '1262232232');

create table MANUFACTURER (
	NameID char(40) not null,
	Country char(75) not null,
	YearEst int not null,
	constraint ManufacturerKey primary key (NameID)
) engine=InnoDB default charset=latin1;

insert into MANUFACTURER values ('McDonalds', 'USA', '1970');
insert into MANUFACTURER values ('KFC', 'Germany', '1950');
insert into MANUFACTURER values ('Amul', 'India', '1992');
insert into MANUFACTURER values ('Subway', 'India', '1974');

create table FACTORY (
	ManufacturerName char(40) not null,
	LocationID char(20) not null,
	constraint FactoryKey primary key (ManufacturerName, LocationID),
	constraint Factory1 foreign key (ManufacturerName) references MANUFACTURER (NameID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into FACTORY values ('Amul', 'Faridabad');
insert into FACTORY values ('Amul', 'Jhansi');
insert into FACTORY values ('McDonalds', 'Florida');
insert into FACTORY values ('KFC', 'Karachi');
insert into FACTORY values ('Subway', 'Hyderabad');
insert into FACTORY values ('McDonalds', 'Hyderabad');

create table FACTORY_CONTACTNOS (
	FactoryManufacturerName char(40) not null,
	FactoryLocationID char(20) not null,
	ContactNo char(10) not null,
	constraint FactoryContactNosKey primary key (FactoryManufacturerName, FactoryLocationID, ContactNo),
	constraint FactoryContactNos1 foreign key (FactoryManufacturerName, FactoryLocationID) references FACTORY (ManufacturerName, LocationID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into FACTORY_CONTACTNOS values ('Amul', 'Faridabad', '1394803198');
insert into FACTORY_CONTACTNOS values ('Subway', 'Hyderabad', '6969696969');

create table AMMO (
	CartridgeName char(40) not null, 
	Shape char(40) not null,
	NoOfRounds bigint not null,
	Caliber char(10) not null,
	Cost bigint not null, 
	constraint AmmoKey primary key (CartridgeName)
) engine=InnoDB default charset=latin1;

insert into AMMO values ('TulAmmo 223 Rem', 'FMJ', '1000', '.223', '132074');
insert into AMMO values ('Tanmay ammo', 'TSM', '1000', '.223', '151839');
insert into AMMO values ('Anirudh ammo', 'ANP', '1000', '.211', '153058');
insert into AMMO values ('Nikhil ammo', 'NER', '1000', '.235', '589850');

create table GUN_MODEL (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	Cost bigint not null,
	FireRate bigint not null,
	Colour char(20) not null,
	constraint GunModelKey primary key (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

insert into GUN_MODEL values ('Kalashnikov', 'KR-9', '96359', '1000', 'Black');
insert into GUN_MODEL values ('AWP', 'AM-10', '1000000', '20', 'Pit Viper');
insert into GUN_MODEL values ('Glock', '18', '200', '500', 'Water Elemental');

create table ATTACHMENT (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	Cost bigint not null,
	AttachmentType char(20) not null, 
	constraint AttachmentKey primary key (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

insert into ATTACHMENT values ('COAST', 'HP-7', '2640', 'Flashlight');
insert into ATTACHMENT values ('ammunation', 'DK-9', '100', 'Grip');
insert into ATTACHMENT values ('Amul', 'DC-10', '10000', 'Scope');

create table SUPPLIED_BY (
	StoreNo int not null,
	FactoryName char(40) not null,
	FactoryLocationID char(20) not null,
	constraint SuppliedByKey primary key (StoreNo, FactoryName, FactoryLocationID),
	constraint SuppliedBy1 foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade,
	constraint SuppliedBy2 foreign key (FactoryName, FactoryLocationID) references FACTORY (ManufacturerName, LocationID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into SUPPLIED_BY values ('1', 'Amul', 'Faridabad');
insert into SUPPLIED_BY values ('2', 'Amul', 'Jhansi');
insert into SUPPLIED_BY values ('1', 'McDonalds', 'Florida');


create table SOLD_GUNMODEL (
	SoldTo char(10) not null,
	SoldBy char(10) not null,
	StoreNo int not null,
	Gun_Manufacturer char(40) not null,
	Gun_ModelType char(40) not null,
	constraint SoldKey1 primary key (SoldTo, SoldBy, StoreNo, Gun_Manufacturer, Gun_ModelType),
	constraint SoldKey11 foreign key (SoldTo) references CUSTOMER (CustomerID) on delete cascade on update cascade,
	constraint SoldKey12 foreign key (SoldBy) references EMPLOYEE (EmployeeID) on delete cascade on update cascade,
	constraint SoldKey13 foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade,
	constraint SoldKey14 foreign key (Gun_Manufacturer, Gun_ModelType) references GUN_MODEL (Manufacturer, ModelType) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into SOLD_GUNMODEL values ('0000000001', '0000000001', '1', 'Glock', '18');
insert into SOLD_GUNMODEL values ('0000000002', '0000000002', '2', 'AWP', 'AM-10');
insert into SOLD_GUNMODEL values ('0000000003', '0000000001', '1', 'Kalashnikov', 'KR-9');

create table SOLD_AMMO (
	SoldTo char(10) not null,
	SoldBy char(10) not null,
	StoreNo int not null,
	Ammo char(40) not null,
	constraint SoldKey2 primary key (SoldTo, SoldBy, StoreNo, Ammo),
	constraint SoldKey21 foreign key (SoldTo) references CUSTOMER (CustomerID) on delete cascade on update cascade,
	constraint SoldKey22 foreign key (SoldBy) references EMPLOYEE (EmployeeID) on delete cascade on update cascade,
	constraint SoldKey23 foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade,
	constraint SoldKey24 foreign key (Ammo) references AMMO (CartridgeName) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into SOLD_AMMO values ('0000000001', '0000000001', '1', 'Anirudh ammo');
insert into SOLD_AMMO values ('0000000002', '0000000004', '3', 'Nikhil ammo');
insert into SOLD_AMMO values ('0000000001', '0000000001', '1', 'Tanmay ammo');

create table SOLD_ATTACHMENT (
	SoldTo char(10) not null,
	SoldBy char(10) not null,
	StoreNo int not null,
	Attachment_Manufacturer char(40),
	Attachment_ModelType char(40),
	constraint SoldKey primary key (SoldTo, SoldBy, StoreNo, Attachment_Manufacturer, Attachment_ModelType),
	constraint SoldKey31 foreign key (SoldTo) references CUSTOMER (CustomerID) on delete cascade on update cascade,
	constraint SoldKey32 foreign key (SoldBy) references EMPLOYEE (EmployeeID) on delete cascade on update cascade,
	constraint SoldKey33 foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade,
	constraint SoldKey34 foreign key (Attachment_Manufacturer, Attachment_ModelType) references ATTACHMENT (Manufacturer, ModelType) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into SOLD_ATTACHMENT values ('0000000003', '0000000002', '2', 'Amul', 'DC-10');
insert into SOLD_ATTACHMENT values ('0000000002', '0000000005', '1', 'Amul', 'DC-10');
insert into SOLD_ATTACHMENT values ('0000000002', '0000000005', '1', 'ammunation', 'DK-9');

create table BARREL (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	BarrelLength float not null,
	constraint BarrelKey primary key (Manufacturer, ModelType),
	constraint Barrel1 foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

create table GRIP (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	_Length float not null,
	Material char(40) not null,
	constraint GripKey primary key (Manufacturer, ModelType),
	constraint Grip1 foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

insert into GRIP values ('ammunation', 'DK-9', '10', 'Leather');

create table FLASHLIGHT (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	_Range float not null,
	constraint FlashlightKey primary key (Manufacturer, ModelType),
	constraint Flashlight1 foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

insert into FLASHLIGHT values ('COAST', 'HP-7', '1000');

create table SCOPE (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	_Type char(40) not null,
	Zoom float not null,
	constraint ScopeKey primary key (Manufacturer, ModelType),
	constraint Scope1 foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

insert into SCOPE values ('Amul', 'DC-10', 'ACOG', '2');

create table LASER (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	Wavelength float not null,
	Colour char(20) not null,
	_Range float not null,
	constraint LaserKey primary key (Manufacturer, ModelType),
	constraint Laser1 foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

create table MAGAZINE (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	_Length float not null,
	Capacity int not null,
	constraint MagazineKey primary key (Manufacturer, ModelType),
	constraint Magazine1 foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

create table FITS_ATTACHMENT (
	Gun_Manufacturer char(40) not null,
	Gun_ModelType char(40) not null,
	Attachment_Manufacturer char(40) not null,
	Attachment_ModelType char(40) not null,
	constraint FitsKey1 primary key (Gun_Manufacturer, Gun_ModelType, Attachment_Manufacturer, Attachment_ModelType),
	constraint Fits11 foreign key (Gun_Manufacturer, Gun_ModelType) references GUN_MODEL (Manufacturer, ModelType) on delete cascade on update cascade,
	constraint Fits12 foreign key (Attachment_Manufacturer, Attachment_ModelType) references ATTACHMENT (Manufacturer, ModelType) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into FITS_ATTACHMENT values ('Glock', '18', 'Amul', 'DC-10');
insert into FITS_ATTACHMENT values ('Kalashnikov', 'KR-9', 'ammunation', 'DK-9');

create table FITS_AMMO (
	Gun_Manufacturer char(40) not null,
	Gun_ModelType char(40) not null,
	CartridgeName char(40) not null,
	constraint FitsKey2 primary key (Gun_Manufacturer, Gun_ModelType, CartridgeName),
	constraint Fits21 foreign key (Gun_Manufacturer, Gun_ModelType) references GUN_MODEL (Manufacturer, ModelType) on delete cascade on update cascade,
	constraint Fits22 foreign key (CartridgeName) references AMMO (CartridgeName) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into FITS_AMMO values ('Glock', '18', 'Tanmay ammo');
insert into FITS_AMMO values ('Kalashnikov', 'KR-9', 'Anirudh ammo');

create table SOLD_AT_GUNMODEL (
	StoreNo int not null,
	Gun_Manufacturer char(40) not null,
	Gun_ModelType char(40) not null,
	constraint SoldAtGMKey1 primary key (StoreNo, Gun_Manufacturer, Gun_ModelType),
	constraint SoldAt11 foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade,
	constraint SoldAt12 foreign key (Gun_Manufacturer, Gun_ModelType) references GUN_MODEL (Manufacturer, ModelType) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into SOLD_AT_GUNMODEL values ('1', 'AWP', 'AM-10');
insert into SOLD_AT_GUNMODEL values ('2', 'Kalashnikov', 'KR-9');

create table SOLD_AT_ATTACHMENT (
	StoreNo int not null,
	Attachment_Manufacturer char(40) not null,
	Attachment_ModelType char(40) not null,
	constraint SoldAtGMKey2 primary key (StoreNo, Attachment_Manufacturer, Attachment_ModelType),
	constraint SoldAt21 foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade,
	constraint SoldAt22 foreign key (Attachment_Manufacturer, Attachment_ModelType) references ATTACHMENT (Manufacturer, ModelType) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into SOLD_AT_ATTACHMENT values ('1', 'Amul', 'DC-10');
insert into SOLD_AT_ATTACHMENT values ('2', 'ammunation', 'DK-9');

create table SOLD_AT_AMMO (
	StoreNo int not null,
	CartridgeName char(40) not null,
	constraint SoldAtGMKey3 primary key (StoreNo, CartridgeName),
	constraint SoldAt31 foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade,
	constraint SoldAt32 foreign key (CartridgeName) references AMMO (CartridgeName) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into SOLD_AT_AMMO values ('1', 'Anirudh ammo');
insert into SOLD_AT_AMMO values ('2', 'Nikhil ammo');
