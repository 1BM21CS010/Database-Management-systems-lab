CREATE DATABASE bank_database;
USE bank_database;
CREATE TABLE Branch (
	BranchName varchar(20),
    BranchCity varchar(20),
    Assets real,
    PRIMARY KEY (BranchName)
    );

CREATE TABLE BankAccount (
	Accno int,
    BranchName varchar(20),
    balance real,
    PRIMARY KEY (Accno),
    FOREIGN KEY (BranchName)
    references branch(BranchName)
    
    );
    
CREATE TABLE BankCustomer (
CustomerName varchar(30),
CustomerStreet char(30),
CustomerCity char(30),
primary key (CustomerName)
);

CREATE TABLE Depositor (
        Accno int,
        CustomerName varchar(30),
   foreign key (CustomerName)
   references BankCustomer(CustomerName),
   foreign key (Accno)
    references BankAccount(Accno)
    );

CREATE TABLE Loan (
	LoanNum int,
    BranchName varchar(20),
	amount real,
	PRIMARY KEY (LoanNum),
    foreign key(BranchName)
    references Branch(BranchName)
    );
    CREATE TABLE borrower(
		CustomerName varchar(20),
        loan_number int);
    desc Branch;
desc BankAccount;
desc Depositor;
desc Loan;

insert into Branch values('SBI_Chamrajpet', 'Banglore',50000);
insert into Branch values('SBI_ResidancyRoad', 'Banglore',10000);
insert into Branch values('SBI_ ShivajiRoad', 'Bombay',20000);
insert into Branch values('SBI_ParlimentRoad', 'Delhi',10000);
insert into Branch values('SBI_Jantarmantar', 'Delhi',20000);

insert into BankAccount values(1,'SBI_Chamrajpet',2000);
insert into BankAccount values(2,'SBI_ResidancyRoad', 5000);
insert into BankAccount values(3,'SBI_ ShivajiRoad', 6000);
insert into BankAccount values(4,'SBI_ParlimentRoad', 9000);
insert into BankAccount values(5,'SBI_Jantarmantar', 8000);
insert into BankAccount values(6,'SBI_ ShivajiRoad', 4000);
insert into BankAccount values(8,'SBI_ResidancyRoad', 4000);
insert into BankAccount values(9,'SBI_ParlimentRoad', 3000);
insert into BankAccount values(10,'SBI_ResidancyRoad', 5000);
insert into BankAccount values(11,'SBI_Jantarmantar', 2000);

insert into BankCustomer values('Avinash', 'Bull_Temple_Road' ,'Bangalore');
insert into BankCustomer values('Dinesh', 'Bannergatta_Road' ,'Bangalore');
insert into BankCustomer values('Mohan', 'NationalCollege_Road' ,'Bangalore');
insert into BankCustomer values('Nikil', 'Akbar_Road' ,'Delhi');
insert into BankCustomer values('Ravi', 'Prithviraj_Road' ,'Delhi');

insert into depositor values(1, 'Avinash');
insert into depositor values(2, 'Dinesh');
insert into depositor values(4, 'Nikil');    
insert into depositor values(5, 'Ravi');    
insert into depositor values(8, 'Avinash'); 
insert into depositor values(9, 'Nikil');   
insert into depositor values(10, 'Dinesh');
insert into depositor values(11, 'Nikil'); 

insert into loan values(1,'SBI_Chamrajpet',1000);
insert into loan values(2,'SBI_ResidancyRoad', 2000);
insert into loan values(3,'SBI_ ShivajiRoad', 3000);
insert into loan values(4,'SBI_ParlimentRoad', 4000);
insert into loan values(5,'SBI_Jantarmantar', 5000);

SELECT * FROM Branch;
SELECT * FROM BankAccount;
SELECT * FROM BankCustomer;
SELECT * FROM Depositor;
SELECT * FROM loan;

select BranchName, (Assets/100000) as assets_in_lakhs from branch;

SELECT CustomerName from Depositor, BankAccount where Depositor.accno = BankAccount.accno and BranchName ='SBI_ResidencyRoad' having count(BranchName);

SELECT BranchName from Branch ,BankAccount ,Depositer where BranchCity ='Delhi'


