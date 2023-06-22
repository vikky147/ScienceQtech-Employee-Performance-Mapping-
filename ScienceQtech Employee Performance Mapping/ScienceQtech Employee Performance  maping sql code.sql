Create database employee;

Use employee;
select  EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from emp_record_table;
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT,EMP_RATING from emp_record_table where EMP_RATING <2 or EMP_RATING>4 or EMP_RATING between 2 and 4 ;


select  concat(FIRST_NAME,' ', LAST_NAME) as NAME from emp_record_table where DEPT='FINANCE';
SELECT e1.manager_id,
       count(*)
FROM emp_record_table  e1,
     emp_record_table  e2
WHERE e1.manager_id = e2.emp_id
GROUP BY e1.manager_id
ORDER BY e1.manager_id ASC;

select emp_id from emp_record_table where dept='FINANCE'
union
select emp_id from emp_record_table where dept='HEALTHCARE';

select EMP_ID, manager_id,FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING, max(EMP_RATING) from emp_record_table group by dept;

select min(salary),max(salary) from emp_record_table group by role;

select emp_id,first_name,role,exp,rank() over(order by exp) emp_rank from emp_record_table;

Create view emp_country as select * from emp_record_table where salary > 6000;

select * from emp_record_table where emp_id in (select EMP_ID from emp_record_table where exp>10) ;

/*Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.*/
DELIMITER //

Create Procedure Emp_Detail_Exp()
Begin
	Select * from emp_record_table where exp> 3;
End //

DELIMITER ;

Call Emp_Detail_Exp();


14. Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.

The standard being:

For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',

For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',

For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',

For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',

For an employee with the experience of 12 to 16 years assign 'MANAGER'.

 

DELIMITER //
Create Function Org_Exp_Std( exp_year int)
Returns Varchar(25)
Deterministic
Begin
    Declare role_found varchar(25);
    If  exp_year <=2  Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
    Elseif (exp_year >2 And exp_year<=5) Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
	Elseif (exp_year >5 And exp_year<=10) Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
	Elseif (exp_year >10 And exp_year<=12) Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
	Elseif (exp_year >12 And exp_year<=16) Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
	End If;
    Return (role_found);
End //

DELIMITER $$

Create Index F_Name_INDX on emp_record_table(First_name(30));

Select salary,emp_rating, round(((5 * Salary * Emp_rating)/100),2) as Bonus from emp_record_table;

select salary, round(avg(salary),2) as avg_salary,country,continent  from emp_record_table group by CONTINENT, COUNTRY;