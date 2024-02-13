-- 18 --
update Orders
set price = price / 1.5
where order_date between '2020/10/10' and '2020/10/17';
