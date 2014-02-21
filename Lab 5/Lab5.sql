--Andrew Lohr
--Lab 5

--Q1
select agents.city
from agents
inner join orders
    on agents.aid = orders.aid
inner join customers
    on customers.cid = orders.cid
    where customers.name = 'Basics'

--Q2 needs to be more than 3 results. It won't select all the pids from orders with
--those agents, only their respective ones.
select pid
from orders
inner join agents
	on orders.aid = agents.aid
inner join customers
	on customers.cid = orders.cid
	where customers.city = 'Kyoto'

--Q3
select name
from customers
where cid
not in
(select cid
from orders)

--Q4
select name 
from customers
left outer join orders
	on customers.cid = orders.cid
	where orders.cid is null

--Q5 tiptop orderd twice through otasi, 
--just remove the groupby to see the duplicate entry
select customers.name, agents.name 
from customers
inner join orders
	on customers.cid = orders.cid
inner join agents
	on customers.city = agents.city
	and agents.aid = orders.aid
	group by customers.name,agents.aid

--Q6
select customers.name, agents.name, agents.city
from agents
inner join customers
	on customers.city = agents.city

--Q7 may not be the prettiest, but it gets the job done. This one took the longest
--and I pushed my google machine to the limit.

with citySum as(
select city,sum(quantity) as sum
from products
group by city)

select name,city
from customers
where city 
in
(select city
from citySum
where sum =(
select min(sum)
from citySum))




	



	
	







