/*
3/30/2022

Below are two table schemas for a popular music streaming application:

Table 1: user_song_log
Column Name	Data Type	Description
user_id	id	id of the streaming user
timestamp	integer	timestamp of when the user started listening to the song, epoch seconds
song_id	integer	id of the song
artist_id	integer	id of the artist

Table 2: song_info
Column Name	Data Type	Description
song_id	integer	id of the song
artist_id	integer	id of the artist
song_length	integer	length of song in seconds

Given the above, write a SQL query to estimate the average number of hours a user spends listening to music daily.  
You can assume that once a given user starts a song, they listen to it in its entirety.
*/

-- in the subquery, calculate the total listening time (sum of song lengths) in seconds per user per day
-- because timestamp is in epoch seconds, use from_unixtime() to convert to date time and extract the date with date()
-- in the outer query, calculate the average of the total daily times per user in seconds and convert to hours

select 
	user_id,
    round(avg(total_song_length_sec)/3600, 2) as avg_daily_listening_hrs
from (
	select
		user_id,
		date(from_unixtime(timestamp)) as listening_date,
        sum(song_length) as total_song_length_sec
	from user_song_log u
    left join song_info s on u.song_id = s.song_id
    group by user_id, listening_date
) as user_daily_totals
group by user_id;
