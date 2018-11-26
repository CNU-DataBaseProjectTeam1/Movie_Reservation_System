CREATE DATABASE movie_reservation;

USE movie_reservation;

CREATE TABLE Admin(
	ID				varchar(20),
	Password 		varchar(20),
    
	PRIMARY KEY(ID)
);

CREATE TABLE User(
	ID 				varchar(20),
    Password 		varchar(20),
	Name 			varchar(20),
	Address  		varchar(20),
	Birth			date,
	PhoneNumber		int(11),
	Point			int,
	VIP				char(1),
    
	PRIMARY KEY(ID)
);

Create Table Theater(
	Theater_Name		varchar(40),
    Address				varchar(20),
    PhoneNumber			varchar(20),
    SeatNumber			varchar(10),
    primary key(Theater_Name)
);

Create Table Movie(
	Movie_Number		int,
    Title				varchar(20),
    Director			varchar(20),
    Rating				int,
    info				varchar(50),
    actors				varchar(50),
    
    primary key(Movie_Number)
);

Create Table Auditorium(
	Auditorium_Number	int,
    Theater_Name		varchar(40),
    SeatCount			int,
    
    primary key(Auditorium_Number),
    foreign key(Theater_Name) references Theater(Theater_Name) on delete cascade on update cascade
    
);

Create Table Schedule(
	Schedule_Number		int,
    Auditorium_Number	int,
    Movie_Number		int,
    StartTime			date,
    EndTime				date,
    
    primary key(Schedule_Number),
    foreign key(Auditorium_Number) references Auditorium(Auditorium_Number) on delete cascade on update cascade,
    foreign key(Movie_Number) references Movie(Movie_Number) on delete cascade on update cascade
    
);

Create Table Seat(
	Seat_Number			int,
    Schedule_Number		int,
    RealNumber			int,
    
    primary key(Seat_Number),
    foreign key(Schedule_Number) references Schedule(Schedule_Number) on delete cascade on update cascade
);

CREATE TABLE Reservation(
	Reservation_Number	int,
    ID					varchar(20),
    Seat_Number			int,
    
    primary key(Reservation_Number),
    foreign key(ID) references User(ID) on delete cascade on update cascade,
    foreign key(Seat_Number) references Seat(Seat_Number) on delete cascade on update cascade 
);

Create Table Payment(
	Payment_Number		int,
    Reservation_Number	int,
    Type				char(1),
    Amount				int,
    Point				int,
    
    primary key(Payment_Number),
    foreign key(Reservation_Number) references Reservation(Reservation_Number) on delete cascade on update cascade
    
);

Create Table Ticket(
	Ticket_Number		int,
    Payment_Number		int,
    
    primary key(Ticket_Number),
    foreign key(Payment_Number) references Payment(Payment_Number) on delete cascade on update cascade
    
);

set sql_safe_updates=0;

delete from theater;

select * from theater;

select * from auditorium;

insert into auditorium values(1, "3", 30);