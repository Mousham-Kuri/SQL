/*
Problem Statement: Growth team wants to understand sustainable(Profitable) product category.
Sustainability can be achieved if we make better profits or at least positive profits.
	we can look at the profits per product category.
    we can look at the profits per product sub-catefory.
    we can look at the Average profit per order.
    also consider Average Profit % per order.
*/
-- ans 1 & 2
select 
		p.Product_Category,
        p.Product_Sub_Category,
        sum(m.Profit)as Profits
from 
	market_fact_full as m
inner join 
	prod_dimen as p
on m.prod_id=p.prod_id
group by 
	p.Product_Category,
	p.Product_Sub_Category
    order by p.Product_Category,
			sum(m.Profit);
-- exploring order table
select ord_id,
		order_number
from 
	orders_dimen
group by
		ord_id,
		order_number
order by
		ord_id,
		order_number;
        
select 
		count(*) as rec_count,
		count(distinct ord_id) as ord_id_count,
        count(distinct order_number) as ord_number_count
from 
	orders_dimen;

select * 
from 
	orders_dimen 
where 
	Order_Number in
(    
select 
		Order_Number
from 
	orders_dimen
group by
		order_number
having count(ord_id)>1
);

-- Ans 3
select 
		p.Product_Category,
        sum(m.profit) as Profits,
        round(
				sum(m.Profit)/
								count(distinct o.order_number) ,2) as Avg_profit_per_order
from 
	market_fact_full as m
inner join 
	prod_dimen as p
	on m.prod_id=p.prod_id
		inner join 
		orders_dimen as o
        on m.Ord_id=o.Ord_id
group by 
	p.Product_Category
    order by p.Product_Category,
			sum(m.Profit);

-- ans 4

select 
		p.Product_Category,
        sum(m.profit) as Profits,
        round(sum(m.Profit)/count(distinct o.order_number) ,2) as Avg_profit_per_order,
        round(sum(m.Sales)/count(distinct o.order_number) ,2) as Avg_sales_per_order,
        round(sum(m.Profit)/sum(m.Sales),4)*100 as Avg_profit_percent
from 
	market_fact_full as m
inner join 
	prod_dimen as p
	on m.prod_id=p.prod_id
		inner join 
		orders_dimen as o
        on m.Ord_id=o.Ord_id
group by 
	p.Product_Category
    order by p.Product_Category,
			sum(m.Profit);