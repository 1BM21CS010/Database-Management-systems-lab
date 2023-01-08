create database employeee_database;
use employeee_database;
drop database employeee_database;


create table dept(
deptno int,
dname varchar(20),
dloc varchar(20),
primary key(deptno)
);

create table employee(
empno int,
ename varchar(20),
mgr_no int,
hiredate date,
sal int,
deptno int,
primary key(empno),
foreign key(deptno)
references dept(deptno)
);

create table project(
pno int,
pname varchar(20),
ploc varchar(20),
primary key (pno)
);

create table incentives(
empno int,
incentive_date date,
incentive_amount int,
primary key (incentive_date),
foreign key (empno)
references employee(empno)
);

create table assigned_to(
empno int,
pno int,
job_role varchar(20),
foreign key(empno)
references incentives(empno),
foreign key (pno)
references project(pno)
);
INSERT INTO dept VALUE (1,'Production','Bengaluru');
INSERT INTO dept VALUE (2,'analytics','Ahemdabad');
INSERT INTO dept VALUE (3,'Customer care','Mysuru');
INSERT INTO dept VALUE (4,'Marketing & Sales','Bengaluru');
INSERT INTO dept VALUE (5,'Production','Hyderabad');
INSERT INTO dept VALUE (6,'Marketing & Sales','Mysuru');
INSERT INTO dept VALUE (7,'Marketing & Sales','Kerla');


INSERT INTO employee VALUE (1, 'Sam', 6, '2016-04-04',4000, 1);
INSERT INTO employee VALUE (2, 'bob',6,'2015-07-05' ,3000,2);
INSERT INTO employee VALUE (3, 'anne',6 ,'2013-12-06' , 6250,3);
INSERT INTO employee VALUE (4, 'julia',5,'2014-01-14',3000,2);
INSERT INTO employee VALUE (5,'matt', 4,'2012-01-04',2000,1);
INSERT INTO employee VALUE (6, 'jeff', 4,'2001-07-07',3000,4);



INSERT INTO project VALUE (1,'microsoft','Bengaluru');
INSERT INTO project VALUE (2,'apple','Bengaluru');
INSERT INTO project VALUE (3,'sony','Hyderabad');
INSERT INTO project VALUE (4,'intel','Hyderabad');
INSERT INTO project VALUE (5,'infosys','Mysuru');
INSERT INTO project VALUE (6,'apple','Mysuru');
INSERT INTO project VALUE (7,'sony','Kerla');
INSERT INTO project VALUE (8,'sony','Ahemdabad');

INSERT INTO incentives VALUE (1,'2019-01-19',200);
INSERT INTO incentives VALUE (2,'2019-01-02',700);
INSERT INTO incentives VALUE (3,'2019-01-09',440);
INSERT INTO incentives VALUE (4,'2019-01-01',280);
INSERT INTO incentives VALUE (5,'2019-01-24',900);
INSERT INTO incentives VALUE (6,'2019-01-04',200);


INSERT INTO assigned_to VALUE(1,1,'Production manager');
INSERT INTO assigned_to VALUE(2,2,'Marketing manager');
INSERT INTO assigned_to VALUE(3,3,'call center');
INSERT INTO assigned_to VALUE(4,2,'Marketing manager');
INSERT INTO assigned_to VALUE(5,1,'Production manager');



select empno,ploc from assigned_to a, project p where a.pno=p.pno and p.ploc in ('Bengaluru','Hyderabad','Mysuru');

select empno from employee where empno not in (select empno from incentives) order by empno;

select e.empno, e.ename, d.dname, p.pname, p.ploc, d.dloc
from dept d, employee e, project p, assigned_to a
where e.deptno = d.deptno
and e.empno = a.empno
        and a.pno = p.pno
        and p.ploc = d.dloc;
/*week 6*/
select ename from employee where empno in
(select mgr_no from employee group by (mgr_no) having count(empno) =
(select max(employee_count) from
(select count(empno) as employee_count, mgr_no as mgr_no from employee group by(mgr_no)) as employee_count));
       
select e1.empno, e1.ename, e1.sal
from employee e1, employee e2
    where e1.empno = e2.mgr_no and e1.sal >
(select avg(employee_sal) from
(select sal as employee_sal from employee e3 where e3.mgr_no = e1.empno ) as avg_emp_sal)
group by e1.ename order by e1.Empno;

select ename
from employee
    where mgr_no in
(select empno from employee where mgr_no NOT IN (select empno from employee))
        and empno in (select mgr_no from employee);


select e.empno, e.ename, e.mgr_no, e.hireDate, e.sal, e.deptno, i.incentive_Amount
from employee e, incentives i
    where e.empno = i.empno and incentive_date like '2019%'
    and e.empno in
(select empno from incentives where incentive_Amount in
(select max(incentive_Amount) from incentives where incentive_Amount <
(select max(incentive_Amount) from incentives)));
               
 
select e.empno, e.ename, e.mgr_no, e1.ename as mgr_name, e.hireDate, e.sal, e.deptno, d.dloc
from employee e, employee e1, dept d
    where e1.empno = e.mgr_no and e.deptno = d.deptno
    and d.dloc =
(select d1.dloc from employee e2, dept d1 where e2.empno = e.mgr_no and e2.deptno = d1.deptno);
