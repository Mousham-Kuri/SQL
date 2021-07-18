/*
Problem Statement
to determine if there are any fraud customers.
*/

-- Unique customer name and city check

select customer_name,
		city,
        count(distinct cust_id) as cust_id_count
from cust_dimen
group by 
	customer_name,
    city
having count(distinct cust_id)<>1 ;

-- Final output

with cust_details
as (
	select customer_name,
			city,
			count(distinct cust_id) as cust_id_count
	from cust_dimen
	group by 
		customer_name,
		city
	having count(distinct cust_id)<>1
),

fraud_cust_list as
(
	select customer_name,
			city,
			count(distinct cust_id) as cust_id_count
	from cust_dimen
	group by 
		customer_name,
		city
	having count(distinct cust_id)>1
)

select *,
		case when fc.cust_id_count is not null
			then "Fraud" 
		else "Normal" 
		end as fraud_flag
from 
	cust_details as cd
    left join 
    fraud_cust_list as fc
		on cd.customer_name=fc.customer_name and
			cd.city=fc.city;