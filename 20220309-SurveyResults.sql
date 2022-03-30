/* 
3/9/2022

You're consulting for a company, and you've sent out a survey that asks successive qustions randomly. 
The survey logs data into a table called survey_logging. The schema of the table is:

Column Title	Data Type	Description
employee_id	integer	employee id of the survey respondant
action	string	Will be one of the following values, 'view', 'answer', 'skip'
question_id	integer	ID of the question asked
answer_id	integer	ID of the answer askedD
timestamp	integer	time stamp of the action made by respondant

Using SQL, find which question has the highest response rate. 
*/

select
 question_id,
 sum(case action when 'answer' then 1 else 0 end)/count(*) as response_rate 
from survey_logging
group by question_id
order by response_rate desc
limit 1;


