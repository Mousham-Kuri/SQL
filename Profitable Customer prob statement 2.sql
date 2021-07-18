/*
Problem statement: get the details of the top 10 profitable customer in form of a table shown below:
cust_id
rank
customer_name
profit
customer_city
customer_state
sales
*/
-- exploring cust_dimen table
select 
	cust_id,
    customer_name,
    city as customer_city,
    state as customer_state
from
	cust_dimen
where 
	cust_id like "cust_1%";

-- ranking
with cust_summary as
(
select 
	c.cust_id,
    rank() over(order by sum(profit) desc) as customer_rank,
    customer_name,
    round(sum(profit),2) as profit,
    city as customer_city,
    state as customer_state,
    round(sum(sales),2) as sales
from
	cust_dimen as c
    inner join
		market_fact_full as m
		on c.cust_id=m.cust_id
group by Cust_id
)
select * from cust_summary
-- to select top 10 customer
where customer_rank<=10;