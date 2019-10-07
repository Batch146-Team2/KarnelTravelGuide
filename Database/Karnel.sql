USE master
GO

CREATE DATABASE KarnelTravel
GO

USE KarnelTravel
GO


CREATE TABLE Customers(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CustomerName nvarchar(50) NOT NULL,
	Email nvarchar(150) NOT NULL,
	Password nvarchar(100) NULL,
	Phone nvarchar(50) NOT NULL,
	Address [nvarchar](200) NOT NULL,
	VIP int NOT NULL,
)
GO

CREATE TABLE Levels(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	LevelName nvarchar(50) NOT NULL,
)
GO

CREATE TABLE Employees(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	LoginName nvarchar(50) NOT NULL,
	Password nvarchar(100) NOT NULL,
	EmployeeName nvarchar(50) NOT NULL,
	Phone nchar(20) NULL,
	Email nchar(200) NULL,
	Address nvarchar(200) NULL,
	LevelId int NULL,
	LastLogin datetime NULL,
	CONSTRAINT [FK_Employees_Levels] FOREIGN KEY(LevelId)
	REFERENCES Levels(Id)
) 
GO

CREATE TABLE LevelPermissions(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	LevelId int NOT NULL,
	TableName nvarchar(50) NOT NULL,
	DisplayName nvarchar(100) NOT NULL,
	AllowPermission bit NOT NULL,
	AllowPermissionCode int,
	CONSTRAINT [FK_LevelPermissions_Levels] FOREIGN KEY(LevelId)
	REFERENCES Levels(Id)
)
GO

CREATE TABLE Statuses(
	Id int NOT NULL PRIMARY KEY,
	StatusName nvarchar(100) NOT NULL,
) 
GO

CREATE TABLE HotelType(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	HotelTypeName nvarchar(50) NOT NULL
)
GO

CREATE TABLE HotelPictures(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	HotelsId int NOT NULL,
	Url varchar(250) NOT NULL,
)
GO

CREATE TABLE Hotels(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	HotelName nvarchar(150) NOT NULL,
	HotelTypeId int NOT NULL,
	UnitPrice decimal(19, 4) NOT NULL,
	Description ntext NULL,
	PictureId int NULL,
	Ranks int,
	Star float,
	CONSTRAINT [FK_Hotels_HotelPictures] FOREIGN KEY(PictureId)
	REFERENCES HotelPictures(Id),
	CONSTRAINT [FK_Hotels_HotelType] FOREIGN KEY(HotelTypeId)
	REFERENCES HotelType(Id)
) 
GO

ALTER TABLE HotelPictures  WITH CHECK ADD  CONSTRAINT [FK_HotelPictures_Hotels] FOREIGN KEY(HotelsId)
REFERENCES Hotels(Id)
GO

CREATE TABLE PaymentMethods(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MethodName nvarchar(50) NOT NULL
)
GO

CREATE TABLE Booking(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	BookingCode nvarchar(20) NULL,
	BookingDate datetime NOT NULL,
	CustomerId int NULL,
	Discount decimal(18, 0) NOT NULL,
	PaymentMethodId int NULL,
	EmployeeId int NULL,
	StatusId int NULL,
	CONSTRAINT [FK_Booking_PaymentMethods] FOREIGN KEY(PaymentMethodId)
	REFERENCES PaymentMethods(Id),
	CONSTRAINT [FK_Booking_Customers] FOREIGN KEY(CustomerId)
	REFERENCES Customers(Id),
	CONSTRAINT [FK_Booking_Employees] FOREIGN KEY(EmployeeId)
	REFERENCES Employees(Id),
	CONSTRAINT [FK_Booking_Statuses] FOREIGN KEY(StatusId)
	REFERENCES Statuses(Id)
)
GO

CREATE TABLE BookingHotelDetails(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	BookingId int NOT NULL,
	HotelId int NOT NULL,
	UnitPrice decimal(19, 4) NOT NULL,
	Discount decimal(18, 0) NOT NULL,
	CONSTRAINT [FK_Booking_Booking] FOREIGN KEY(BookingId)
	REFERENCES Booking(Id),
	CONSTRAINT [FK_Booking_Hotels] FOREIGN KEY(HotelId)
	REFERENCES Hotels(Id)
)
GO

CREATE TABLE RestaurantType(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	RestaurantTypeName nvarchar(50) NOT NULL
)
GO

CREATE TABLE RestaurantPictures(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	RestaurantId int NOT NULL,
	Url varchar(250) NOT NULL,
)
GO

CREATE TABLE Restaurants(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	RestaurantName nvarchar(150) NOT NULL,
	RestaurantTypeId int NOT NULL,
	UnitPrice decimal(19, 4) NOT NULL,
	Description ntext NULL,
	RestaurantPictureId int NULL,
	Ranks int,
	Star float,
	CONSTRAINT [FK_Restaurants_RestaurantPictures] FOREIGN KEY(RestaurantPictureId)
	REFERENCES RestaurantPictures(Id),
	CONSTRAINT [FK_Restaurants_RestaurantType] FOREIGN KEY(RestaurantTypeId)
	REFERENCES RestaurantType(Id)
) 
GO

ALTER TABLE RestaurantPictures WITH CHECK ADD  CONSTRAINT [FK_RestaurantPictures_Restaurants] FOREIGN KEY(RestaurantId)
REFERENCES Restaurants(Id)
GO

CREATE TABLE BookingRestaurantDetails(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	BookingId int NOT NULL,
	RestaurantId int NOT NULL,
	UnitPrice decimal(19, 4) NOT NULL,
	Discount decimal(18, 0) NOT NULL,
	CONSTRAINT [FK_Booking_Bookingrestaurant] FOREIGN KEY(BookingId)
	REFERENCES Booking(Id),
	CONSTRAINT [FK_Booking_Restaurants] FOREIGN KEY(RestaurantId)
	REFERENCES Restaurants(Id)
)
GO

CREATE TABLE ContactType(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ContactTypeName nvarchar(50) NOT NULL,
)
GO
CREATE TABLE Contact(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ContactName nvarchar(30) NOT NULL,
	Phone varchar(100) NOT NULL unique,
	Email nvarchar(150),
	Address varchar(250),
	CustomerId int,
	TypeId int,
	CONSTRAINT [FK_Contact_Customers] FOREIGN KEY(CustomerId)
	REFERENCES Customers(Id),
	CONSTRAINT [FK_Contact_ContactType] FOREIGN KEY(TypeId)
	REFERENCES ContactType(Id)
)
GO

CREATE TABLE TransportsType(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TransportsTypeName nvarchar(50) NOT NULL,
)
GO

CREATE TABLE Transports(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TransportsName nvarchar(50) NOT NULL,
	Depart datetime,
	Arrival datetime,
	Froms varchar(250),
	Tos varchar(250),
	People int,
	TransportsTypeId int,
	CONSTRAINT [FK_Transports_TransportsType] FOREIGN KEY(TransportsTypeId)
	REFERENCES TransportsType(Id)
)
GO

CREATE TABLE ToursType(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ToursTypeName nvarchar(50) NOT NULL
)
GO

CREATE TABLE TourPictures(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TourId int NOT NULL,
	Url varchar(250) NOT NULL,
)
GO

CREATE TABLE Tours(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ToursName nvarchar(150) NOT NULL,
	ToursTypeId int NOT NULL,
	UnitPrice decimal(19, 4) NOT NULL,
	Description ntext NULL,
	TourPictureId int NULL,
	Ranks int,
	Star float,
	CONSTRAINT [FK_Tours_TourPictures] FOREIGN KEY(TourPictureId)
	REFERENCES TourPictures(Id),
	CONSTRAINT [FK_Tours_ToursType] FOREIGN KEY(ToursTypeId)
	REFERENCES ToursType(Id)
) 
GO

ALTER TABLE TourPictures WITH CHECK ADD  CONSTRAINT [FK_TourPictures_Tours] FOREIGN KEY(TourId)
REFERENCES Tours(Id)
GO

CREATE TABLE BookingTourDetails(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	BookingId int NOT NULL,
	ToursId int NOT NULL,
	UnitPrice decimal(19, 4) NOT NULL,
	Discount decimal(18, 0) NOT NULL,
	CONSTRAINT [FK_BookingTourDetails_Booking] FOREIGN KEY(BookingId)
	REFERENCES Booking(Id),
	CONSTRAINT [FK_BookingTourDetails_Tours] FOREIGN KEY(ToursId)
	REFERENCES Tours(Id)
)
GO

CREATE TABLE ResortType(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ResortTypeName nvarchar(50) NOT NULL
)
GO

CREATE TABLE ResortPictures(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ResortId int NOT NULL,
	Url varchar(250) NOT NULL,
)
GO

CREATE TABLE Resorts(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ResortName nvarchar(150) NOT NULL,
	ResortsTypeId int NOT NULL,
	UnitPrice decimal(19, 4) NOT NULL,
	Description ntext NULL,
	ResortPictureId int NULL,
	Ranks int,
	Star float,
	CONSTRAINT [FK_Resorts_ResortType] FOREIGN KEY(ResortsTypeId)
	REFERENCES ResortType(Id),
	CONSTRAINT [FK_Resorts_ResortPictures] FOREIGN KEY(ResortPictureId)
	REFERENCES ResortPictures(Id)
) 
GO

ALTER TABLE ResortPictures WITH CHECK ADD  CONSTRAINT [FK_ResortPictures_Resorts] FOREIGN KEY(ResortId)
REFERENCES Resorts(Id)
GO

CREATE TABLE BookingResortDetails(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	BookingId int NOT NULL,
	ResortId int NOT NULL,
	UnitPrice decimal(19, 4) NOT NULL,
	Discount decimal(18, 0) NOT NULL,
	CONSTRAINT [FK_BookingResortDetails_Booking] FOREIGN KEY(BookingId)
	REFERENCES Booking(Id),
	CONSTRAINT [FK_BookingResortDetails_Resorts] FOREIGN KEY(ResortId)
	REFERENCES Resorts(Id)
)
GO













