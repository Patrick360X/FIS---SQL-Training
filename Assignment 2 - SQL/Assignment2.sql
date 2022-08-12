use ASS1

select * from EMP
select * from DEPT

-- 1. Retrieve a list of MANAGERS.
 
select distinct(e2.ename) as 'List of Managers' from EMP e1 join EMP e2 on e1.mgr_id = e2.empno

-- 2. Find out the names and salaries of all employees earning more than 1000 per month.

select ename, sal from EMP where sal > 1000

-- 3. Display the names and salaries of all employees except JAMES. 

select ename, sal from EMP where ename!='JAMES'

-- 4. Find out the details of employees whose names begin with ‘S’. 

select * from EMP where ename like 'S%'

-- 5. Find out the names of all employees that have ‘A’ anywhere in their name. 

select ename from EMP where ename like '%A%'

-- 6. Find out the names of all employees that have ‘L’ as their third character in their name. 

select ename from EMP where ename like '___L%'

-- 7. Compute daily salary of JONES. 

select (sal/30) as 'Daily Salary' from EMP where ename = 'JONES' 

-- 8. Calculate the total monthly salary of all employees. 

select ename as 'Employee Name', sal as 'Total Monthly Salary' from EMP

-- 9. Print the average annual salary . 

select AVG(sal*12) as 'Average Annual Salary' from EMP

-- 10. Select the name, job, salary, department number of all employees except SALESMAN from department number 30. 

select ename, job, deptno from EMP where job != 'SALESMAN' AND deptno = 30

-- 11. List unique departments of the EMP table. 

select deptno, dname from DEPT where deptno in (select distinct deptno from EMP)

-- OR --

select distinct(d.deptno),(d.dname) from EMP e join DEPT d on e.deptno = d.deptno

-- 12. List the name and salary of employees who earn more than 1500 and are in department 10 or 30.
--     Label the columns Employee and Monthly Salary respectively.

select ename as 'Employee', sal as 'Monthly Salary' from EMP where sal > 1500 and (deptno = 10 or deptno = 30)

-- 13. Display the name, job, and salary of all the employees whose job is MANAGER or 
--     ANALYST and their salary is not equal to 1000, 3000, or 5000. 

select ename, job, sal from EMP 
where 
(job = 'Manager' or job = 'Analyst') 
and 
(sal not in (1000,3000,5000))

-- 14. Display the name, salary and commission for all employees whose commission 
--     amount is greater than their salary increased by 10%. 

select ename, sal, comm from EMP where comm > (sal + 0.1*sal)

-- OR --

select e1.ename, e1.sal, e1.comm from EMP e1 inner join (select ename, (sal + (0.1*sal))
as 'Salary Hike' from emp) e2 on e1.ename = e2.ename where comm > [Salary Hike]

-- 15. Display the name of all employees who have two Ls in their name and are in 
--     department 30 or their manager is 7782. 

select ename from emp where ename like '%L%L%' and (deptno = 30 or mgr_id = 7782)

-- 16. Display the names of employees with experience of over 10 years and under 20 yrs.
--     Count the total number of employees.

select ename as 'Employee Name', DATEDIFF(yy,hiredate,getdate()) as 'Employee Experience' from EMP
where DATEDIFF(yy,hiredate,getdate()) > 10 and DATEDIFF(yy,hiredate,getdate()) < 20
order by [Employee Experience]

-- 17. Retrieve the names of departments in ascending order and their employees in descending order.

select d.dname, e.ename from DEPT d join EMP e on d.deptno = e.deptno
order by d.deptno, e.ename desc

-- 18. Find out experience of MILLER. 

select DATEDIFF(yy,emp.hiredate,getdate()) as 'Experience of MILLER' from EMP where ename = 'MILLER'

