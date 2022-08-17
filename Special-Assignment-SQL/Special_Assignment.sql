create database special_Assignment
use special_Assignment

create table clients(Client_ID int primary key,
					Cname varchar(40) not null,
					Address varchar(30),
					Email varchar(30) unique,
					Phone bigint,
					Business varchar(20) not null)

create table departments(Deptno int primary key,
					Dname varchar(15) not null,
					Loc varchar(20))

create table employees(Empno int primary key,
					Ename varchar(20) not null,
					Job varchar(15),
					Salary int,
					Deptno int,
					constraint chksal check(salary > 0),
					constraint fk foreign key(Deptno) references Departments(Deptno))


create table projects(Project_ID int primary key,
					Descr varchar(30) not null,
					Start_Date date,
					Planned_End_Date date,
					Actual_End_Date date,
					Budget int,
					Client_ID int references clients(Client_ID) ,
					constraint ch_act_date check(Actual_End_date > Planned_End_date),
					constraint chbudget check(Budget > 0 ))

create table EmpProjectTasks(Project_ID int references projects(Project_ID),
						Empno int references employees(Empno),
						Start_date date,
						End_date date,
						Task varchar(25) not null,
						Status varchar(15) not null,
						constraint cmposite primary key(Project_ID, Empno))


insert into clients values(1001,'ACME Utilities','Noida','contact@acmeuutil.com',9567880032,'Manufacturing'),
						  (1002,'Trackon Consultants','Mumbai','consult@trackon.com',8734210090,'Consultant'),
						  (1003,'MoneySaver Distributors','Kolkata','save@moneysaver.com',7799886655,'Reseller'),
						  (1004,'Lawful Corp','Chennai','justice@lawful.com',9210342219,'Professional')

select * from clients

insert into departments values(10,'Design','Pune'),
							(20,'Development','Pune'),
							(30,'Testing','Mumbai'),
							(40,'Document','Mumbai')

select * from departments

insert into employees values(7001,'Sandeep','Analyst',25000,10),
							(7002,'Rajesh','Designer',30000,10),
							(7003,'Madhav','Developer',40000,20),
							(7004,'Manoj','Desiner',40000,20),
							(7005,'Abhay','Designer',35000,10),
							(7006,'Uma','Tester',30000,30),
							(7007,'Gita','Tech. Writer',30000,40),
							(7008,'Priya','Tester',35000,30),
							(7009,'Nutan','Developer',45000,20),
							(7010,'Smita','Analyst',20000,10),
							(7011,'Anand','Project Mgr',65000,10)
select * from employees

insert into projects values(401,'Inventory','01-Apr-11','01-Oct-11','31-Oct-11',150000,1001)
insert into projects(Project_ID,Descr,Start_Date,Planned_End_Date,Budget,Client_ID) values(402,'Accounting','01-Aug-11','01-Jan-12',500000,1002),
(403,'Payroll','01-Oct-11','31-Dec-11',75000,1003),
(404,'Contact Mgmt','01-Nov-11','31-Dec-11',50000,1004)

select * from projects


insert into EmpProjectTasks values(401,7001,'01-Apr-11','20-Apr-11','System Analysis','Completed'),
(401,7002,'21-Apr-11','30-May-11','System Design','Completed'),
(401,7003,'01-Jun-11','15-Jun-11','Coding ','Completed'),
(401,7004,'18-Jun-11','01-Sep-11','Coding ','Completed'),
(401,7006,'03-Sep-11','15-Sep-11','Testing ','Completed'),
(401,7009,'18-Sep-11','05-Oct-11','Code Change','Completed'),
(401,7008,'06-Oct-11','16-Oct-11','Testing','Completed'),
(401,7007,'06-Oct-11','22-Oct-11','Documentation ','Completed'),
(401,7011,'22-Oct-11','31-Oct-11','Sign off','Completed'),
(402,7010,'01-Aug-11','20-Aug-11','System Analysis','Completed'),
(402,7002,'22-Aug-11','30-Sep-11','System Design','Completed')
insert into EmpProjectTasks(Project_ID,Empno,Start_date,Task,Status) values(402,7004,'01-Oct-11',' Coding','In Progress')

select * from EmpProjectTasks
