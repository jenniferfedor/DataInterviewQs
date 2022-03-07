# Data Interview Qs 
# 2/28/2022

#### prompt ----

# Below is a daily table for an active acount at Shopify (an online ecommerce, retail platform). The table is called store_account and the columns are:

# | column name | data type | description                             |
# |-------------|-----------|-----------------------------------------|
# | store_id    | integer   | a unique Shopify store id               |
# | date        | string    | date                                    |
# | status      | string    | possible values are open, closed, fraud |
# | revenue     | double    | amount of spend in USD                  |
 
# The granularity of the table is store_id and date.  
# Assume 'closed' and 'fraud' are permanent labels.  
# Active = daily revenue > 0.  
# Accounts get labeled by Shopify as fraudulent and they no longer can sell product.
# Every day of the table has every store_id that has ever used Shopify. 

# Write code to show what percent of active stores were fraudulent by day. We want one value for each day in the month. 
# Note that a store can be fraudulent and active on same day. E.g., they could generate revenue until 10AM, then be flagged as fradulent from 10AM onward.

#### solution ----

library(dplyr)

# create a dataframe for the store_account table
store_account <- data.frame(
  store_id = integer(),
  date = character(),
  status = character(),
  revenue = double(),
  stringsAsFactors = FALSE
)

# calculate percent active (revenue > 0) stores that are fraudulent (status = fraud) by day
result <- store_account %>%
  group_by(date) %>%
  summarize(
    n_active = sum(revenue > 0),
    n_active_fraud = sum(revenue > 0 & status == 'fraud'),
    percent_active_fraud = round(n_active_fraud/n_active, 4)
  ) %>%
  select(date, percent_active_fraud)

# results
result
