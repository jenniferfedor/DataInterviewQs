/* 
3/28/2022  

Below is a snippet from a table that contains information about employees that work at Company XYZ:  

employee_name	employee_id	date_joined	age	yrs_of_experience
Andy	123456	2015-02-15	45	24
Beth	    789456	NaN	            36	15
Cindy	654123	2017-05-16	34	14
Dale	    963852	2018-01-15	25	4

Company XYZ recently migrated database systems causing some of the date_joined records to be NULL.   
You're told by an analyst in human resources NULL records for the date_joined field indicates the employees joined prior to 2010.   
You also find out there are multiple employees with the same name and duplicate records for some employees.  

Given this, write code to find the number of employees that joined each month. You can group all of the null values as Dec 1, 2009.  
 */  

select
 -- replace missing dates with Dec 1, 2009 and pull the month
 month(ifnull(date_joined, '2009-12-01')) as month_joined,
 -- counting distinct employee IDs avoids issues with same-named employees and duplicate records
 count(distinct employee_id) as n_employees
from employee_info
group by month_joined
order by month_joined;