--Q1
Select city 
from agents
where aid 
in 
(select aid 
from orders 
where cid 
in 
(select cid 
from customers 
where name ='Basics'))
--Q2
select pid
from orders
where aid
in
(select aid
from orders
where cid 
in
(select cid
from customers
where city = 'Kyoto'))
--Q3
select cid, name
from customers
where cid 
not in
(select cid
from orders
where aid ='a03')
--Q4
select cid,name
from customers
where cid
in
(select cid
from orders
where pid
in
('p01','p07')
group by cid
having count(pid)>1)
--Q5
select pid
from products
where pid
in
(select pid
from orders
where cid
in
(select cid
from orders
where aid = 'a03'))
--if you wanted multiples just ignore the 
--first select,from,where,in.
--Q6
select name,discount
from customers
where cid
in
(select cid
from orders
where aid 
in
(select aid
from agents
where city
in
('Dallas','Duluth')))
--Q7
select *
from customers
where discount
in
(select discount
from customers
where city 
in
('Dallas','Kyoto')) 
and city != 'Dallas' and city != 'Kyoto'
