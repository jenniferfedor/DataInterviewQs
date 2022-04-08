/*
4/8/2022

You are an analyst for a major US hotel chain which has locations all over the US.  
Your marketing team is planning a promotion focused around loyal customers, and they are trying to forecast how much revenue the promotion will bring in.  
However, they need help from you to understand how much revenue comes from "loyal" customers to plug into their model. 
    
A "loyal" customer is defined as:   
 1. having a membership with your company's point system,  and 
 2. meeting either of the below conditions  
  i. having >2 stays at any hotel location  
  ii. having stayed at 3 different locations  
    
You have a table showing all transactions made in 2017. The schema of the table is below:

Table: customer_transactions
Column Name			Data Type	Description
customer_id			id					id of the customer
hotel_id					integer			unique id for hotel
transaction_id			integer			id of the given transaction
first_night				string			first night of the stay, column format is "YYYY-mm-dd" 
number_of_nights	integer			# of nights the customer stayed in hotel
total_spend				integer			total spend for transaction, in USD
is_member				boolean		indicates if the customer is a member of our points system

Given this, write a SQL query that calculates percent of revenue loyal customers brought in 2017.
*/

-- in the innermost subquery, get the number of times each customer has stayed at each hotel, num_stays_per_hotel 
-- in the outer query, create an indicator for loyal customers which is based on whether the customer is a member (is_member = 1) AND
-- if they have stayed at any hotel at least 2 times (max(num_stays_per_hotel) >= 2) or they have stayed at at least three different hotels (count(distinct(hotel_id)) >= 3)
-- finally, that table is joined back to the customer_transactions table so we can calculate what percent of the revenue was from loyal customers

select 
 sum(total_spend) as total_revenue,
 sum(if(loyal_customer = 1, total_spend, 0)) as loyal_customer_total_revenue,
 round(sum(if(loyal_customer = 1, total_spend, 0))/sum(total_spend), 2)  as loyal_customer_percent_revenue
from customer_transactions
left join (
 select
  customer_id,
  case
   when is_member = 1 and (max(num_stays_per_hotel) >= 2 or count(distinct(hotel_id)) >= 3) then 1
   else 0
  end as loyal_customer
 from (
  select 
   customer_id,
   is_member,
   hotel_id,
   count(hotel_id) as num_stays_per_hotel
  from customer_transactions
  group by customer_id, is_member, hotel_id
 ) as stays_per_hotel
 group by customer_id, is_member
) as loyal_customer_status
on loyal_customer_status.customer_id = customer_transactions.customer_id;
