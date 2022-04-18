# DataInterviewQs 
# 4/15/2022

#### prompt ----

# You're given a set of data that is aggregated on a monthly basis (as illustrated in Table A). 
# Write code that can expand this monthly table into a daily table which spreads revenue across the 30 day period (as shown in Table B).  

# You can assume each month has 30 days and that Table A is in a dataframe named "df".  

# Table A
# 	  Month	Revenue
# 0	  1	    300
# 1	  2	    330
# 2	  3	    390 

# Table B
#     Month	Day	Revenue
# 0	  1	    1	  10
# 1	  1	    2	  10
# 2	  1	    3	  10
# ...	...	  ...	...
# 30	2	    1	  11
# 31	2	    2	  11
# ...	...	  ...	...
# 60	3	    1	  13
# ...	...	  ...	...
# 89	3	    30	13

#### solution ----

# only using base R!

# data frame with aggregated revenues
df <- data.frame(
  month = c(1, 2, 3),
  revenue = c(300, 330, 390)
)

# assuming 30 days per month
days_per_month <- 30

# create data frame linking month and day of the month
days <- data.frame(
  month = unlist(lapply(df$month, rep, days_per_month)),
  day = rep(seq(1, days_per_month, by = 1), length(df$month))
)

# join the two data frames
expanded_df <- merge(days, df, by = 'month')

# convert revenue to daily average
expanded_df$revenue <- expanded_df$revenue/days_per_month

# final result
expanded_df
