
drop database if exists GUN_STORE;
create database GUN_STORE;
use GUN_STORE;

/* The tables are created in each of these blocks and sample values are loaded for each table */

create table STORE (
	StoreNo INT NOT NULL AUTO_INCREMENT,
	Location char(50) NOT NULL,
	PRIMARY KEY (StoreNo)
) engine=InnoDB default charset=latin1;

insert into STORE (Location) values ('Hyderabad');
insert into STORE (Location) values ('Bangalore');
insert into STORE (Location) values ('Chennai');


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
	primary key (EmployeeID),
	foreign	key (WorksAt) references STORE (StoreNo) on delete cascade on update cascade,
	foreign key (ManagerID) references EMPLOYEE (EmployeeID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into EMPLOYEE values ('9876543210', 'Nigga', 'Gay', 'Employeet', '2001-02-18', '3', 'M', '42069', NULL, '1');


create table EMPLOYEE_CONTACTNOS (
	EmployeeID char(10) not null,
	ContactNo char(10) not null,
	constraint EmployeeContactNosKey primary key (EmployeeID, ContactNo),
	foreign key (EmployeeID) references EMPLOYEE (EmployeeID) on delete cascade on update cascade
);

insert into EMPLOYEE_CONTACTNOS values ('9876543210', '2122122121');
insert into EMPLOYEE_CONTACTNOS values ('9876543210', '2122122122');

create table CUSTOMER (
	CustomerID char(10) not null,
	Fname char(20) not null,
	Mname char(20),
	Lname char(20) not null,
	TotalPurchaseValue float not null default '0',
	VerifiedBy char(10) not null,
	primary key (CustomerID),
	foreign key (VerifiedBy) references EMPLOYEE (EmployeeID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into CUSTOMER values ('1234567890', 'Anirudh', 'Narayan', 'Palutla', '0', '9876543210');
insert into CUSTOMER (CustomerID, Fname, Lname, TotalPurchaseValue, VerifiedBy) values ('2222222222', 'Nikhil', 'E', '69', '9876543210');
insert into CUSTOMER (CustomerID, Fname, Lname, TotalPurchaseValue, VerifiedBy) values ('3333333333', 'Tanmay', 'Sachan', '420', '9876543210');

create table CUSTOMER_CONTACTNOS (
	CustomerID char(10) not null,
	ContactNo char(10) not null,
	constraint CustomerContactNosKey primary key (CustomerID, ContactNo),
	foreign key (CustomerID) references CUSTOMER (CustomerID) on delete cascade on update cascade
);

insert into CUSTOMER_CONTACTNOS values ('1234567890', '1111111112');
insert into CUSTOMER_CONTACTNOS values ('1234567890', '2111111112');
insert into CUSTOMER_CONTACTNOS values ('2222222222', '2222222122');
insert into CUSTOMER_CONTACTNOS values ('2222222222', '3333322333');


create table DEPENDANT (
	DependsOn char(10) not null,
	Fname char(20) not null,
	Mname char(20),
	Lname char(20) not null,
	ContactNo char(10) not null,			/* left as atomic attribute for now */
	constraint DependantKey primary key (DependsOn, Fname, Lname),
	foreign key (DependsOn) references EMPLOYEE (EmployeeID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into DEPENDANT values ('9876543210', 'Fag', NULL, 'Yeet', '6969696969');


create table STORE_CONTACTNOS (
	StoreNo int not null,
	ContactNo char(10) not null,
	constraint StoreContactKey primary key (StoreNo, ContactNo),
	foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into STORE_CONTACTNOS values ('1', '1231231231');
insert into STORE_CONTACTNOS values ('1', '1232232232');
insert into STORE_CONTACTNOS values ('2', '2232232232');
insert into STORE_CONTACTNOS values ('2', '1262232232');

create table MANUFACTURER (
	Name char(40) not null,
	Country char(15) not null,
	YearEst date not null,
	primary key (Name)
) engine=InnoDB default charset=latin1;

insert into MANUFACTURER values ('JihadTime', 'Pakistan', '2001-09-11');


create table FACTORY (
	ManufacturerName char(40) not null,
	LocationID char(20) not null,
	constraint FactoryKey primary key (ManufacturerName, LocationID),
	foreign key (ManufacturerName) references MANUFACTURER (Name) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into FACTORY values ('JihadTime', 'Karachi');
insert into FACTORY values ('JihadTime', 'Hyderabad');


create table FACTORY_CONTACTNOS (
	FactoryManufacturerName char(40) not null,
	FactoryLocationID char(20) not null,
	ContactNo char(10) not null,
	constraint FactoryContactKey primary key (FactoryManufacturerName, FactoryLocationID, ContactNo),
	constraint FMN_FK foreign key (FactoryManufacturerName, FactoryLocationID) references FACTORY (ManufacturerName, LocationID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

insert into FACTORY_CONTACTNOS values ('JihadTime', 'Karachi', '1111111111');
insert into FACTORY_CONTACTNOS values ('JihadTime', 'Karachi', '6666666666');

create table AMMO (
	CartridgeName char(40) not null, 
	Shape char(40) not null,
	NoOfRounds bigint not null,
	Caliber char(10) not null,
	Cost bigint not null, 
	primary key (CartridgeName)
) engine=InnoDB default charset=latin1;

insert into AMMO values ('TulAmmo 223 Rem', 'FMJ', '1000', '.223', '132074');

create table GUN_MODEL (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	Cost bigint not null,
	FireRate bigint not null,
	Colour char(20) not null,
	constraint GunModelKey primary key (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

insert into GUN_MODEL values ('Kalashnikov', 'KR-9', '96359', '1000', 'Black');

create table ATTACHMENT (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	Cost bigint not null,
	AttachmentType char(20) not null, 
	constraint AttachmentKey primary key (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

insert into ATTACHMENT values ('COAST', 'HP-7', '2640', 'Flashlight');

create table SUPPLIED_BY (
	StoreNo int not null,
	FactoryName char(40) not null,
	FactoryLocationID char(20) not null,
	constraint SupplyKey primary key (StoreNo, FactoryName, FactoryLocationID),
	constraint StoreNoKey foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade,
	constraint FactoryKey foreign key (FactoryName, FactoryLocationID) references FACTORY (ManufacturerName, LocationID) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;

create table SOLD (
	SoldTo char(10) not null,
	SoldBy char(10) not null,
	StoreNo int not null,
	Ammo char(40) not null,
	Gun_Manufacturer char(40) not null,
	Gun_ModelType char(40) not null,
	Attachment_Manufacturer char(40) not null,
	Attachment_ModelType char(40) not null,
	constraint SaleKey primary key (SoldTo, SoldBy, StoreNo, Ammo, Gun_Manufacturer, Gun_ModelType, Attachment_Manufacturer, Attachment_ModelType),
	constraint SoldTo_FK foreign key (SoldTo) references CUSTOMER (CustomerID) on delete cascade on update cascade,
	constraint SoldBy_FK foreign key (SoldBy) references EMPLOYEE (EmployeeID) on delete cascade on update cascade,
	constraint StoreNum_FK foreign key (StoreNo) references STORE (StoreNo) on delete cascade on update cascade,
	constraint Ammo_FK foreign key (Ammo) references AMMO (CartridgeName) on delete cascade on update cascade,
	constraint Gun_FK foreign key (Gun_Manufacturer, Gun_ModelType) references GUN_MODEL (Manufacturer, ModelType) on delete cascade on update cascade,
	constraint Attachment_FK foreign key (Attachment_Manufacturer, Attachment_ModelType) references ATTACHMENT (Manufacturer, ModelType) on delete cascade on update cascade
) engine=InnoDB default charset=latin1;


create table BARREL (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	BarrelLength float not null,
	constraint AttachmentKey primary key (Manufacturer, ModelType),
	constraint foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

create table GRIP (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	_Length float not null,
	Material char(40) not null,
	constraint AttachmentKey primary key (Manufacturer, ModelType),
	constraint foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

create table FLASHLIGHT (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	_Range float not null,
	constraint AttachmentKey primary key (Manufacturer, ModelType),
	constraint foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

create table SCOPE (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	_Type char(40) not null,
	Zoom float not null,
	constraint AttachmentKey primary key (Manufacturer, ModelType),
	constraint foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

create table LASER (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	Wavelength float not null,
	Colour char(20) not null,
	_Range float not null,
	constraint AttachmentKey primary key (Manufacturer, ModelType),
	constraint foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;

create table MAGAZINE (
	Manufacturer char(40) not null,
	ModelType char(40) not null, 
	_Length float not null,
	Capacity int not null,
	constraint AttachmentKey primary key (Manufacturer, ModelType),
	constraint foreign key (Manufacturer, ModelType) references ATTACHMENT (Manufacturer, ModelType)
) engine=InnoDB default charset=latin1;