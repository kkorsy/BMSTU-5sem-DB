-- 19 --
update Orders
set price = (select avg(price)
			 from Orders
			 where order_date between '2010/03/15' and '2015/03/15')
where order_date between '2010/03/15' and '2015/03/15';
