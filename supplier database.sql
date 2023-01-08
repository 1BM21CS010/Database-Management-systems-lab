create database supplier_database;
use supplier_database;


create table supplier(
sid int,
sname varchar(20),
city varchar (20),
primary key (sid)
);
create table parts(
pid int,
pname varchar(20),
color varchar(20),
primary key (pid)
);
create table catalog(
sid int,
pid int,
cost int,
foreign key(sid)
references supplier(sid),
foreign key(pid)
references parts(pid)
);


insert into supplier values(10001,'Acme Widget','banglore');
insert into supplier values(10002,'Johns','Kolkata');
insert into supplier values(10003,'Vimal','Mumbai');
insert into supplier values(10004,'Relience','Delhi');

insert into parts values(20001,'Book','Red');
insert into parts values(20002,'Pen','Red');
insert into parts values(20003,'Pencil','Green');
insert into parts values(20004,'Mobile','Green');
insert into parts values(20005,'Charger','Black');

insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);
insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);

/*1*/
select pname from parts outerP where exists
(select pid from catalog where catalog.pid = outerP.pid);


/*2*/
select s.sname from supplier s, catalog c where s.sid = c.sid
and c.pid in (select pid from parts)
    group by s.sname
    having count(c.pid) = (select count(pid) from parts);


/*3*/
select s.sname from supplier s, catalog c where s.sid = c.sid
and c.pid in (select pid from parts where color = 'red')
    group by (s.sname)
    having count(c.pid) = (select count(pid) from parts where color = 'red');

/*4*/
select pname from parts where pid in
(select c.pid from supplier s, catalog c
where s.sname = 'Acme Widget' and s.sid = c.sid
and c.pid not in
(select distinct c.pid from supplier s, catalog c
where s.sname != 'Acme Widget' and s.sid = c.sid));

/*5*/
create view averageCost as
select avg(cost)as avgCost, pid from catalog group by pid;
select * from averageCost;
select sid from catalog c, averageCost a where c.pid=a.pid and c.cost>a.avgCost;
   

/*6*/
select outerP.pid, outerP.pname, s.sname from supplier s, parts outerP
where s.sid in
(select c.sid from catalog c
where cost =
(select max(cost) from catalog where pid = outerP.pid)
and c.pid = outerP.pid);

