create database ASS1

create table DEPT
(
	deptno int primary key,
	dname varchar(30),
	loc varchar(30)
)

create table EMP
(
	empno int primary key,
	ename varchar(30),
	job varchar(20),
	mgr_id int,
	hiredate date not null,
	sal float not null,
	comm int,
	deptno int references DEPT(deptno)
)

insert into DEPT values (10,'Accounting','New York'), (20,'Research','Dallas'), (30,'Sales','Chicago'), (40,'Operations','Boston')

select * from DEPT
select * from EMP

drop table EMP

insert into EMP values (7934, 'MILLER', 'CLERK', 7782, '23-JAN-82', 1300, null, 10)
insert into EMP values (7844, 'TURNER', 'SALESMAN', 7698, '08-SEP-81', 1500, 0, 30)
insert into EMP values (7782, 'CLARK', 'MANAGER', 7839, '09-JUN-81', 2450, null, 10)
insert into EMP values (7902, 'FORD', 'ANALYST', 7566, '03-DEC-81', 3000, null, 20)
insert into EMP values (7839, 'KING', 'PRESIDENT', null, '17-NOV-81', 5000, null, 10)

-- 1. List all employees whose name begins with 'A'. 

select * from EMP where ename like 'A%'

-- 2. Select all those employees who don't have a manager.

select * from EMP where mgr_id is null

-- 3. List employee name, number and salary for those employees who earn in the range 1200 to 1400. 

select ename, empno, sal from EMP where sal between 1200 and 1400

-- 4. Give all the employees in the RESEARCH department a 10% pay rise.  
-- Verify that this has been done by listing all their details before and after the rise. 

select sal as 'Current Salary', (sal + 0.1*sal) as 'Revised Salary' from emp where deptno = (select deptno from DEPT where dname = 'RESEARCH')

-- 5. Find the number of CLERKS employed. Give it a descriptive heading.

select count(job) as 'No. of Clerks Employed' from emp where job = 'CLERK'

-- 6. Find the average salary for each job type and the number of people employed in each job. 

select AVG(sal) as 'Clerk Average Salary', count(empno) as 'Count' from emp where job = 'clerk'
select AVG(sal) as 'Salesman Average Salary', count(empno) as 'Count' from emp where job = 'Salesman'
select AVG(sal) as 'Manager Average Salary', count(empno) as 'Count' from emp where job = 'Manager'
select AVG(sal) as 'Analyst Average Salary', count(empno) as 'Count' from emp where job = 'Analyst'
select AVG(sal) as 'President Average Salary', count(empno) as 'Count' from emp where job = 'President'

-- Another Approach using group by

select job, count(*) as 'No. of Employees', avg(sal) as 'Average Salary of Employees' from emp
group by job

-- 7. List the employees with the lowest and highest salary. 

select ename, sal from emp where sal = (select max(sal) from emp)
select ename, sal from emp where sal = (select min(sal) from emp) 

-- 8. List full details of departments that don't have any employees. 

select * from DEPT where deptno not in (select distinct deptno from emp)

-- 9. Get the names and salaries of all the analysts earning more than 1200 who are based in department 20. 
-- Sort the answer by ascending order of name. 

select ename, sal from emp where job = 'analyst' and sal > 1200 and deptno = 20 order by ename 

-- 10. For each department, list its name and number together with the total salary paid to employees in that department. 

select dname, deptno, result.[Total Salary] from DEPT join
	(select deptno as dno, sum(sal) as 'Total Salary' from emp group by emp.deptno)
	result on DEPT.deptno = result.dno union
		select dname, deptno, sal = 0 from DEPT where deptno not in (select distinct deptno from emp)

-- OR

select d.deptno, d.dname, sum(e.sal) as 'Total Salary' from DEPT d full outer join emp e on d.deptno = e.deptno
group by d.dname,d.deptno

-- 11. Find out salary of both MILLER and SMITH.

select ename, sal from emp where ename = 'MILLER' or ename = 'SMITH'

-- 12. Find out the names of the employees whose name begin with ‘A’ or ‘M’. 

select ename from emp where ename like '[AM]%'

-- 13. Compute yearly salary of SMITH. 

select sal*365 as 'SMITH - Yearly Salary' from emp where ename = 'SMITH'

-- 14. List the name and salary for all employees whose salary is not in the range of 1500 and 2850. 

select ename, sal from emp where sal < 1500 or sal > 2850

/* Additional queries */

-- Display the no. of employees under each manager in descending order

select count(empno) as employees, mgr_id from emp group by mgr_id 
order by mgr_id desc

-- List of managers who have alteast 1 employee reporting to them

select mgr.ename 'Manager Name', count(emp.ename) 'No. of Employees' 
from emp emp left outer join emp mgr
on emp.mgr_id = mgr.empno
where mgr.ename is not null
group by emp.mgr_id,mgr.ename
having count(emp.ename) > 1