delimiter $$

create function profitType(profit int)
returns varchar(30) deterministic

begin

Declare message varchar(30);	
if profit < -500 then 
	set message="Huge loss";
elseif profit between -500 and 0 then 
	set message="Bearable loss";
elseif profit between 0 and 500 then
	set message="Decent profit";
else
	set message="Great Profit";
end if;
return message;
end; 
$$
delimiter ;

select profitType(20) as fucntion_output;