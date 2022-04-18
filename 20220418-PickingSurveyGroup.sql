/*
4/18/2022

You work for a large hardware company (one that manufactures watches, computers, and phones).
You're trying to understand user sentiment towards the company's brand and the products. 
You decide to send out a survey to a random set of users across different products. 

Create a query that samples across the different product offerings. 
The output of your query should be user_id and group (e.g. the sampling group the user belongs to).

You have a table with all users and their registered devices. The schema of the table is below:

Column Name			Data Type			Description
user_id					integer					id of the user
devices					array of strings	lists the devices (watch, computer, phone) 
device_ids				array of integers	id of the devices used by the user
user_create_time	integer					epoch time of the user's account
total_spend				integer					lifetime spend of a user
country					string					user country

*/

-- create a temporary table with one row per device per user, sorted in random order within each device group
create temporary table user_devices_long
select 
	user_id, 
    device,
    -- randomly sort user ids within device group and assign row number
    row_number() over(partition by device order by rand()) as row_id
from 
	user_devices, 
    -- unnest strings stored in json arrays (this gives us one row per array element)
	json_table(
		user_devices.devices, 
        '$[*]' 
        columns (device varchar(20) path '$')
	) d 
;

-- select n (e.g., 10) users (who were already randomly sorted above) per device (i.e., sampling group)
select 
	user_id,
    device
from user_devices_long
where row_id <= 10;
