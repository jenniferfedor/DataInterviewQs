# DataInterviewQs 
# 3/28/2022

#### prompt ----

# Below is a snippet from a table that contains information about employees that work at Company XYZ:
  
# employee_name	employee_id	  date_joined	  age	  yrs_of_experience
# Andy	        123456	      2015-02-15	  45	  24
# Beth	        789456	      NaN	          36	  15
# Cindy	        654123	      2017-05-16	  34	  14
# Dale	        963852	      2018-01-15	  25	  4

# Company XYZ recently migrated database systems causing some of the date_joined records to be NULL.   
# You're told by an analyst in human resources NULL records for the date_joined field indicates the employees joined prior to 2010.   
# You also find out there are multiple employees with the same name and duplicate records for some employees.  

# Given this, write code to find the number of employees that joined each month. You can group all of the null values as Dec 1, 2009.  

#### solution ---- 

# load packages
library(tidyverse)
library(lubridate)

# snippet of table 
employee_info <- tribble(
  ~employee_name, ~employee_id, ~date_joined, ~age, ~yrs_of_experience,
  'Andy',	123456,	'2015-02-15',	45,	24,
  'Beth',	789456,	NA_character_, 36,	15,
  'Cindy', 654123, '2017-05-16', 34,	14,
  'Dale',	963852,	'2018-01-15',	25,	4
)

# results
employees_per_month <- employee_info %>%
  # replace missing dates with Dec 1, 2009
  mutate(date_joined = replace_na(date_joined, '2009-12-01')) %>%
  # create a variable for month employee joined
  mutate(month_joined = month(as.Date(date_joined, format = '%Y-%m-%d'))) %>%
  # remove duplicate rows
  distinct() %>%
  # count number of observations per month
  group_by(month_joined) %>%
  summarize(n_employees = n())

employees_per_month


