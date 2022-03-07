# Data Interview Qs 
# 3/7/2022

#### prompt ----

# Here is a table containing information from a P2P messaging application. The table contains send/receive message data for the application's users. 
# The structure is as follows:

# Table name: user_messaging
# date
# sender_id (#id of the message sender)
# receiver_id (#id of the message receiver)

# Calculate what fraction of senders sent messages to at least 9 unique people on March 1, 2018. 

#### solution ----

library(dplyr)

# read in the csv file
user_messaging <- read.csv(url('https://raw.githubusercontent.com/erood/interviewqs.com_code_snippets/master/Datasets/ddi_message_app_data.csv'))

user_messaging %>%
  # entries for March 1, 2018
  filter(date == '2018-03-01') %>%
  # calculate number of unique message recipients per sender
  group_by(sender_id) %>%
  summarize(
    n_recipients = length(unique(receiver_id))
  ) %>%
  ungroup() %>%
  # calculate percent of all senders who had 9 or more unique message recipients
  summarize(
    total_senders = length(sender_id),
    senders_with_9plus_recipients = sum(n_recipients >= 9),
    percent_senders_with_9plus_recipients = round(senders_with_9plus_recipients/total_senders, 4)
  ) %>%
  # final answer
  pull(percent_senders_with_9plus_recipients)

# 90% of senders sent messages to at least 9 unique people on March 1, 2018 
  