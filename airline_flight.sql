create database flight_database;
use flight_database;

create table flights (
 flno int,
 D_from varchar(30),
 A_to varchar(30),
 distance int,
 departs time,
 arrives time,
 price int,
 primary key (flno)
 );
 
 create table aircraft (
	aid int,
    aname varchar(30),
    cruising_range int,
    primary key (aid)		
);

create table employees (
	eid int,
    ename varchar(30),
    salary int,
    primary key (eid)
);

create table certified (
	eid int,
    aid int,
    foreign key (eid)
		references employees (eid)
        on delete cascade
        on update cascade,
	foreign key (aid)
		references aircraft (aid)
        on delete cascade
        on update cascade
);


insert into flights values (1,'Bengaluru','New Delhi',500,'6:00:00','9:00:00',5000);
insert into flights values (2,'Bengaluru','Chennai',300,'7:00:00','8:30:00',3000);
insert into flights values (3,'Trivandrum','New Delhi',800,'8:00:00','11:30:00',6000);
insert into flights values (4,'Bengaluru','Frankfurt',10000,'6:00:00','23:30:00',50000);
insert into flights values (5,'Kolkata','New Delhi',2400,'11:00:00','3:30:00',9000);
insert into flights values (6,'Bengaluru','Frankfurt',8000,'9:00:00','23:00:00',40000);
    
insert into aircraft values (1,'Airbus',2000);
insert into aircraft values (2,'Boeing',700);
insert into aircraft values (3,'JetAirways',550);
insert into aircraft values (4,'Indigo',5000);
insert into aircraft values (5,'Boeing',4500);
insert into aircraft values (6,'Airbus',2200);

insert into employees values (101,'Avinash',50000);
insert into employees values (102,'Lokesh',60000);
insert into employees values (103,'Rakesh',70000);
insert into employees values (104,'Santhosh',82000);
insert into employees values (105,'Tilak',5000);

insert into certified values (101,2);
insert into certified values (101,4);
insert into certified values (101,5);
insert into certified values (101,6);
insert into certified values (102,1);
insert into certified values (102,3);
insert into certified values (102,5);
insert into certified values (103,2);
insert into certified values (103,3);
insert into certified values (103,5);
insert into certified values (103,6);
insert into certified values (104,6);
insert into certified values (104,1);
insert into certified values (104,3);
insert into certified values (105,3);

select * from employees;
select * from aircraft;
select * from flights;
select * from certified;


/*1*/
select aname from aircraft where aid in 
	(select c.aid from certified c, employees e 
		where c.eid=e.eid and e.salary>80000);


/*2*/
select c.eid, max(cruising_range) from
certified c left outer join aircraft a on c.aid=a.aid where c.eid in
(select eid from certified group by eid having count(*)>=3) group by eid;
    
/*3*/
select ename from employees where salary <
	all (select min(price) from flights where D_from = 'Bengaluru' and A_to = 'Frankfurt');


/*4*/
select a.aid, a.aname, avg(e.salary)
from aircraft a left outer join certified c on a.aid=c.aid
left outer join employees e on c.eid = e.eid
        where a.cruising_range>=1000 group by a.aid;


/*5*/
select ename from employees where eid in 
	(select eid from certified c, aircraft a where c.aid=a.aid and a.aname = 'Boeing');


/*6*/
select aid from aircraft where cruising_range >=
	(select distance from flights where D_from = 'Bengaluru' and A_to ='New Delhi');
    
