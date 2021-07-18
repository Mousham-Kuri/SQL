Delimiter $$
create procedure get_sales_customer(sales_input int)
begin
	select distinct cust_id,
					round(sales) as sales_amount
			from 
				market_fact_full
			where round(sales)>sales_input
            order by sales;
end $$
Delimiter ;

call get_sales_customer(300);

