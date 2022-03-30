/* 
3/21/2022

Given the following table schemas, how would you figure out the overall attendance rate for each grade on 2018-03-12? 

Table 1: student_attendance_log
Column Name	Data Type	Description
date	string	date of log per student_id, format is 'yyyy-mm-dd'
student_id	integer	id of the student
attendance_status	string	Possible values are ['present', 'tardy', 'absent']

Table 2: student_demographic
Column Name	Data Type	Description
student_id	integer	id of the student
grade_level	integer	will be a value between 0-12, which corresponds
date_of_birth	string	Student birth date, format is 'yyyy-mm-dd'
*/

select
 date,
 grade_level,
 -- attendance rate = number of students who attended (present or tardy) divided by total number of students
 sum(case when attendance_status = 'absent' then 0 else 1 end)/count(*) as attendance_rate
from student_attendance_log
join student_demographic on student_attendance_log.student_id = student_demographic.student_id
where date = '2018-03-12'
group by grade_level;
