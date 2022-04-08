# DataInterviewQs 
# 3/28/2022

#### prompt ----

# Below is a snippet from a table that contains information about employees that work at Company XYZ:
  
# Column name	      Data type	Example value	Description
# employee_name	    string	  Cindy	        Name of employee
# employee_id	      integer	  1837204	      Unique id for each employee
# yrs_of_experience	integer	  14	          total working years of experience
# yrs_at_company	  integer	  10	          total working years at Company XYZ
# compensation	    integer	  100000	      dollar value of employee compensation
# career_track	    string	  technical	    Potential values: technical, non-technical, executive 

# Company XYZ Human Resource department is trying to understand compensation across the company. 
# Pull the average, median, minimum, maximum, and standard deviations for salary across 5 year experience buckets at Company XYZ. 
# I.e., get the corresponding average, median, minimum, maximum, and standard deviations for experience buckets 0-5, 5-10, 10-15, etc. 
# You can assume the data is imported into a dataframe named, df

#### solution ---- 

library(tidyverse)

# set seed for reproducibility
set.seed(12345)

# create some random example data
df <- data.frame(
  employee_name = sample(letters, 20),
  employee_id = sample(1000:10000, 20),
  yrs_of_experience = sample(0:100, 20),
  yrs_at_company = sample(0:100, 20),
  compensation = sample(50000:90000, 20),
  career_track = sample(c('technical', 'non-technical', 'executive'), 20, replace = TRUE)
)

# pull the requested data
df %>%
  # create 5-year bins for experience 
  mutate(
    yrs_at_company_bin = cut(
      yrs_at_company, 
      breaks = seq(0, max(yrs_at_company+5), by = 5), 
      right = FALSE, 
      include.highest = TRUE)
  ) %>%
  # group by the experience bins
  group_by(yrs_at_company_bin) %>%
  # calculate the summary statistics
  summarize(
    Average = mean(compensation),
    SD = sd(compensation),
    Median = median(compensation),
    Minimum = min(compensation),
    Maximum = max(compensation)
  ) %>%
  # give the experience bin column a more descriptive name
  rename(`Years at company (binned)` = yrs_at_company_bin)
