use employee;

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT  from emp_record_table	
	Order By DEPT;
-- Task-4
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT,Emp_Rating ,
	case  
		when emp_rating < 2 then 'less than two'
        when emp_rating <= 4 then 'between two and four'
        else 'greater than four'
	end as Rating_Status
	from emp_record_table;	

-- Task-5
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS NAME FROM emp_record_table
WHERE DEPT = "FINANCE";


-- Task-6
select m.First_Name, count(e.Manager_ID) as No_Of_Emps
	from emp_record_table e JOIN emp_record_table m
    ON e.Manager_ID = m.Emp_ID
    group by m.First_Name;
    
-- Task-7
select * from emp_record_table where Dept = 'HealthCare'
UNION
select * from emp_record_table where Dept = 'Finance';

-- Task - 8

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT,Emp_Rating,
	max(emp_Rating) over(partition by DEPT) as Max_RatingByDept
	from emp_record_table;	
    

-- Task - 9

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT,ROLE,Salary,
	MIN(Salary) over(partition by ROLE) as Mim_Salary,
    max(Salary) over(partition by ROLE) as Max_Salary    
	from emp_record_table;	
    
select ROLE, Min(Salary),Max(Salary) from emp_record_table
	group by Role;
    
    
-- Task - 10

select *,Rank() over(order by Exp desc) from emp_record_table;

--  Task - 11

CREATE VIEW employees_in_various_countries AS
SELECT EMP_ID,FIRST_NAME,LAST_NAME,COUNTRY,SALARY
FROM emp_record_table
WHERE SALARY>6000
order by Country;

-- Task-12
select * from emp_record_table where Emp_ID in
(select Emp_ID from emp_record_table where Exp > 10);

delimiter //
CREATE procedure EmpWith_3plusExp()
Begin
	select * from emp_record_table where Exp > 3;
end // 
Delimiter;
 
call EmpWith_3plusExp;


-- Task-14
DELIMITER $$
USE `employee`$$
CREATE FUNCTION `Task14`(eid   varchar(5)) 
RETURNS varchar(100) 
    DETERMINISTIC
BEGIN
	declare ex int;
    declare r varchar(80);
    declare vrole varchar(100);
    declare flag varchar(10);
    select exp, ROLE into ex, VROLE from data_science_team where emp_ID = eid;
  
		if ex > 12 and ex < 16 then
			if VROLE = 'Manager' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			# set r = 'Manager';
		elseif ex > 10 and ex <= 12 then 
			if VROLE = 'LEAD DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'LEAD DATA SCIENTIST';
		elseif ex > 5 and ex <=10 then 
			if VROLE = 'SENIOR DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r ='SENIOR DATA SCIENTIST';
		elseif ex > 2 and ex <=5 then
			if VROLE = 'ASSOCIATE DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'ASSOCIATE DATA SCIENTIST';
		elseif ex <= 2 then
			if VROLE = 'JUNIOR DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'JUNIOR DATA SCIENTIST';
		end if;
	

RETURN flag;
END$$
DELIMITER ;
;

SELECT *,Task14(Emp_ID) FROM data_science_team;

-- Task-15

select * from emp_record_table where First_Name='Eric';


create Index idx_emp_Fname on emp_record_table(First_Name);

select * from emp_record_table where First_Name='Eric';


-- Task - 16

select *, (salary* .05) * Emp_Rating Bonus from emp_record_table;

-- Task - 17
 select Emp_ID,First_Name,salary,CONTINENT,Country,
	AVg(SALARY) over( partition by CONTINENT,Country )	from emp_record_table;