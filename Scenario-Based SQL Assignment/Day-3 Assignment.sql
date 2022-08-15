create database ASS3_DB

use ASS3_DB

create table books 
(
id int primary key,
title varchar(40),
author varchar(30),
isbn bigint unique,
published_date datetime
)

insert into books values (1, 'My First SQL Book', 'Mary Parker', 981483029127, '2012-02-22 12:08:17'),
(2, 'My Second SQL Book', 'John Mayer', 857300923713, '1972-07-03 09:22:45'),
(3, 'My Third SQL Book', 'Cary Flint', 523120967812, '2015-10-18 14:05:44')

select * from books

-- 1. Write a query to fetch the details of the books written by author whose name ends with er.

select * from books where author like '%er'

----------------------------------------------------------
-----------------

create table reviews 
(
id int primary key,
book_id int references books(id),
reviewer_name varchar(40),
content varchar(30),
rating int,
published_date datetime
)

insert into reviews values (1, 1, 'John Smith', 'My first review', 4, '2017-12-10 05:50:11'),
(2, 2, 'John Smith', 'My second review', 5, '2017-10-13 15:05:12'),
(3, 2, 'Alice Walker', 'Another review', 1, '2017-10-22 23:47:10')

select * from reviews

-- 2. Display the Title ,Author and ReviewerName for all the books from the above table

select title, author, coalesce(reviewer_name, 'Yet to Review') as reviewer_name from
books b left outer join reviews r
on b.id = r.book_id

----------------------------------------------------------
-----------------

-- 3. Display the reviewer name who reviewed more than one book.

select reviewer_name from reviews
group by reviewer_name
having COUNT(distinct(book_id)) > 1

----------------------------------------------------------
-----------------

create table customers
(
id int primary key,
cName varchar(20),
age int not null,
cAddress varchar(30),
salary int
)

insert into customers values (1, 'Ramesh', 32, 'Ahmedabad', 2000),
(2, 'Khilan', 25, 'Delhi', 1500),
(3, 'Kaushik', 23, 'Kota', 2000),
(4, 'Chaitali', 25, 'Mumbai', 6500),
(5, 'Hardik', 27, 'Bhopal', 8500),
(6, 'Komal', 22, 'MP', 4500),
(7, 'Muffy', 24, 'Indore', 10000)

select * from customers

-- 4. Display the Name for the customer from above customer table who live in same address 
--    which has character o anywhere in address

select cName from customers where cAddress like '%o%'

----------------------------------------------------------
-----------------

create table orders
(
OID int primary key,
O_DATE Date,
CUSTOMER_ID int references customers(id),
AMOUNT int
)

insert into orders values (102, '2009-10-08', 3, 3000), (100, '2009-10-08', 3, 1500),
(101, '2009-11-20', 2, 1560), (103, '2008-05-20', 4, 2060)

-- 5. Write a query to display the Date,Total no of customer placed order on same Date

select o1.O_DATE as 'Order Date', COUNT(o2.customer_id) as 'Total no of Customers' from orders 
o1 join orders o2
on o1.OID = o2.OID
group by o1.O_DATE

----------------------------------------------------------
-----------------

create table employee
(
id int primary key,
cName varchar(20),
age int not null,
cAddress varchar(30),
salary int
)

insert into employee values (1, 'Ramesh', 32, 'Ahmedabad', 2000),
(2, 'Khilan', 25, 'Delhi', 1500),
(3, 'Kaushik', 23, 'Kota', 2000),
(4, 'Chaitali', 25, 'Mumbai', 6500),
(5, 'Hardik', 27, 'Bhopal', 8500),
(6, 'Komal', 22, 'MP', null),
(7, 'Muffy', 24, 'Indore', null)

select * from employee

-- 6. Display the Names of the Employee in lower case, whose salary is null

select LOWER(cname) as 'Employee Name' from employee where salary is null

----------------------------------------------------------
-----------------

create table studentdetails
(
RegisterNo int primary key,
sName varchar(20),
Age int not null,
Qualification varchar(20),
MobileNo bigint,
Mail_Id varchar(40),
sLocation varchar(20),
Gender varchar(10)
)

insert into studentdetails values (2 , 'Sai',22 ,'B.E',9952836777 , 'Sai@gmail.com' ,'Chennai', 'M'),
(3 , 'Kumar',20 ,'BCS',7890125648 , 'Kumar@gmail.com' ,'Madurai', 'M'),
(4 , 'Selvi',22 ,'B.Tech',8904567342 , 'Selvi@gmail.com' ,'Selam', 'F'),
(5 , 'Nisha',25 ,'M.E',7834672310 , 'Nisha@gmail.com' ,'Theni', 'F'),
(6 , 'SaiSaran',21 ,'B.A',7890345678 , 'SaiSaran@gmail.com' ,'Madurai', 'F'),
(7 , 'Tom',23 ,'BCA',89012345675 , 'Tom@gmail.com' ,'Pune', 'M')

select * from studentdetails

-- 7. Write a sql server query to display the Gender,Total no of male and female from the above
--    relation.

select Gender, COUNT(Gender) as 'Total no. of Male and Female' from studentdetails group by Gender

----------------------------------------------------------
-----------------

create table coursedetails(
Cid varchar(20) primary key,
Cname varchar(30),
start_date date,
end_date date,
fees int
)

insert into coursedetails values ('DN003','DotNet','2018-02-01','2018-02-28',15000),
('DV004','DateVisualization','2018-03-01','2018-04-15',15000),
('JA002','AdvancedJava','2018-01-02','2018-01-20',10000),
('JC001','CoreJava','2018-01-02','2018-01-12',15000)

select * from coursedetails

create table CourseRegistration(
RegistrationNo int ,
C_ID varchar(20) references coursedetails(Cid),
Batch varchar(10)
)

insert into CourseRegistration values(2,'DN003', 'FN'),(3,'DV004', 'AN'),(4,'JA002', 'FN'),
(2,'JA002', 'AN'),(5,'JC001', 'FN')

select * from CourseRegistration

-- 8. Retrieve the CourseName and the number of student registered for each course between 2018-01-02 
--    and 2018-02-28 and arrange the result by courseid in descending order.

select CName, COUNT(*) as 'No. of registered students' from coursedetails d join CourseRegistration r
on d.Cid = r.C_ID
where start_date between '2018-01-02' and '2018-02-28'
group by Cname, C_ID
order by C_ID desc

----------------------------------------------------------
-----------------

create table Customer
(
customer_ID int primary key,
first_name varchar(30),
last_name varchar(30),
)

insert into Customer values (1,'George','Washington'), (2,'John','Adams'), 
(3,'Thomas','Jefferson'), (4,'James','Madison'), (5,'James','Monroe')

select * from Customer

create table c_Order
(
order_id int primary key,
order_date date,
amount float,
Customer_id int references Customer(customer_ID),
)

insert into c_Order values (1,'1776-04-04',234.56,1), (2,'1760-03-14',78.50,3),(3,'1784-05-23',124.00,2),
(4,'1790-09-03',65.50,3),(5,'1795-07-21',25.50,4),(6,'1787-11-27',14.40,5)

select * from c_Order

-- 9. Display the Firstname and LastName of the customer who have placed exactly 2 orders.

select first_name, last_name from Customer c join c_Order o
on c.customer_ID = o.Customer_id
group by o.Customer_id, first_name, last_name
having COUNT(o.Customer_id) = 2

----------------------------------------------------------
-----------------

-- 10. Display all the student name in reverse order and Capitalize all the character in location

select * from studentdetails

select REVERSE(sname) as 'Reversed Student Names', UPPER(slocation) as 'Capitalized Locations' 
from studentdetails

----------------------------------------------------------
-----------------

create table all_order
(
Id int primary key,
OrderDate date,
OrderNumber int ,
CustomerId int,
TotalAmount float
)

create table OrderItems
(
Id int primary key,
OrderId int,
ProductId int,
UnitPrice float,
Quantity int
)

create table Product
(
Id int primary key,
ProductName varchar(20),
SupplierId int,
UnitPrice float,
Package varchar(10),
IsDiscontinued varchar(20)
)

-- 11.Create a view table to display the ProductName,ordered Quantity and OrderNumber 
--     from the above relations

create view viewOrder
as 
select p.ProductName, i.Quantity, o.OrderNumber from all_order o
join OrderItems i on o.Id = i.Id
join Product p on o.Id = p.Id

select * from viewOrder

----------------------------------------------------------
-----------------

-- 12. Display the Course Name registered by student Nisha

select * from studentdetails
select * from coursedetails
select * from CourseRegistration

select cname as 'Course registered by Nisha' from studentdetails s join  CourseRegistration r 
on s.RegisterNo = r.RegistrationNo
join coursedetails d on d.Cid = r.C_ID
where s.sName = 'Nisha'

----------------------------------------------------------
-----------------