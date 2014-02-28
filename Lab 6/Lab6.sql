--Andrew Lohr
--Lab 6
 
--Q1
select c.name,c.city
from customers c
where c.city
in
(select city
from
(select p.city,sum(p.quantity) as lowSum
from products p
group by city) summedCityQuantities
order by lowSum desc
limit 1)
 
--Q2
select c.name,c.city
from customers c
where c.city
in
(select city
from
(select p.city,sum(p.quantity) as lowSum
from products p
group by city) summedCityQuantities
order by lowSum desc) 
 
--Q3
with average as(
select avg(p.priceUSD) as averagePriceUSD
from products p
)
select name
from products
where priceUSD > (select averagePriceUSD from average)
 
--Q4
 
select customers.name,orders.pid,orders.dollars
from customers
inner join orders on
customers.cid = orders.cid
order by dollars desc
 
--Q5 I think this means, get the customers name, and I believe "total ordered" means
--the count of each customers pid's in the table orders.
 
 
select customers.name,count(coalesce(orders.pid)) as total_ordered
from customers
inner join orders on
customers.cid = orders.cid
group by customers.name
 
--Q6
 
select products.name, custOrder.name, agents.name
from agents
join (select *
      from customers
      join orders
      on customers.cid = orders.cid) as custOrder
      
on agents.aid = custOrder.aid
join products
on products.pid = custOrder.pid
where agents.city = 'New York'

--Q7

select customers.name as gay,customers.cid,(prod.qty * prod.priceUSD) - ((prod.qty * prod.priceUSD)*customers.discount)/100 as totalAfterDiscount
from customers 
join (select *
      from orders
      join products
      on orders.pid = products.pid)as prod
on customers.cid = prod.cid



