/* Problem Statement
Extract the required details of the customers who have not placed an order yet.
*/

-- Exploring the customer dimension table.

select * 
from cust_dimen ;

-- List of customers that has not made any purchase.

select c.*
from 
	cust_dimen as c
left join
	market_fact_full as m
    on c.cust_id=m.cust_id
where m.ord_id is null;

-- checking count of customers that has not made any purchase

select count(cust_id) from cust_dimen;

select count(distinct cust_id) from market_fact_full;

-- people with no order with order count
select c.*,
		count(distinct ord_id) as order_count
from 
	cust_dimen as c
left join
	market_fact_full as m
    on c.cust_id=m.cust_id
where m.ord_id is null
group by cust_id;