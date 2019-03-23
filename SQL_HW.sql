USE sakila;
#1a
select first_name, last_name
from actor;
#1b
select upper(concat(first_name, ' ', last_name)) as 'Actor Name'
from actor;
#2a
select actor_id, first_name, last_name
from actor
where first_name = "Joe";
 #2b
select first_name, last_name
from actor
where last_name like '%GEN%';
#2c
select last_name, first_name 
from actor
where last_name like '%LI%';
#2d
select country_id, country
from country 
where country in 
('Afghanistan', 'Bangladesh', 'China');
#3a
alter table actor
add column Description blob;
#3b
alter table actor
drop column Description;
#4a
select last_name as 'Names of Actors', count(*) as 'Number of Actors' 
from actor group by last_name;
#4b
select last_name as 'Names of Actors', count(*) as 'Number of Actors' 
from actor group by last_name having count(*) >=2;
#4c
update actor 
set first_name = 'HARPO'
where first_name = "GROUCHO" and last_name = "WILLIAMS";
#4d
update actor 
set first_name = 'GROUCHO' 
where actor_id = 172;
#5a
show create table address;
#6a
select first_name, last_name, address
from staff s 
join address a
on s.address_id = a.address_id;
#6b
select staff.first_name, staff.last_name, payment.amount, payment.payment_date, payment.staff_id
from staff inner join payment on
staff.staff_id = payment.staff_id and payment_date like '2005-08%'; 
#6c
select f.title as "Film Title", count(fa.actor_id) as "Number of Actors"
from film_actor fa
inner join film f
on fa.film_id= f.film_id
group by f.title;
#6d
select title, (
select count(*) from inventory
where film.film_id = inventory.film_id) as 'Number of Copies'
from film
where title = "Hunchback Impossible";
#6e
select c.first_name as 'First Name', c.last_name as 'Last Name', sum(p.amount) as "Total Amount Paid"
from payment as p
join customer as c
on p.customer_id = c.customer_id
group by c.first_name, c.last_name
order by c.last_name, c.first_name;
#7a
select title
from film where title 
like 'K%' or title like 'Q%'
and title in 
(
select title 
from film 
where language_id = 1
);
#7b
select first_name, last_name
from actor
where actor_id in
(
select actor_id
from film_actor
where film_id in 
(
select film_id
from film
where title = 'Alone Trip'
));
#7c
select first_name, last_name, email 
from customer as c
join address as a 
on (c.address_id = a.address_id)
join city as i
on (i.city_id = a.city_id)
join country as z
on (z.country_id = i.country_id)
where z.country= 'Canada';
#7d
select title 
from film 
where film_id in
(
select film_id from film_category
where category_id in
(
select category_id from category
where name = "Family"
));
#7e
select f.title, count(f.title) as 'Times Rented'
from rental as r
join inventory as i
on r.inventory_id = i.inventory_id
join film as f
on i.film_id = f.film_id
group by f.title
order by count(f.title) desc;
#7f
select s.store_id, sum(amount) as 'Total Revenue'
from payment p
join rental r
on (p.rental_id = r.rental_id)
join inventory i
on (i.inventory_id = r.inventory_id)
join store s
on (s.store_id = i.store_id)
group by s.store_id; 
#7g
select s.store_id, x.city, y.country 
from store s
join address a 
on (s.address_id = a.address_id)
join city as x
on (x.city_id = a.city_id)
join country as y
on (y.country_id = x.country_id);
#7h
select c.name as 'Genre', sum(p.amount) as 'Gross Revenue' 
from category c
join film_category fc 
on (c.category_id=fc.category_id)
join inventory i 
on (fc.film_id=i.film_id)
join rental r 
on (i.inventory_id=r.inventory_id)
join payment p 
on (r.rental_id=p.rental_id)
group by c.name 
order by sum(p.amount) LIMIT 5;
#8a
create view gross_revenue as(
select c.name as 'Genre', sum(p.amount) as 'Gross Revenue' 
from category c
join film_category fc 
on (c.category_id=fc.category_id)
join inventory i 
on (fc.film_id=i.film_id)
join rental r 
on (i.inventory_id=r.inventory_id)
join payment p 
on (r.rental_id=p.rental_id)
group by c.name 
order by sum(p.amount) LIMIT 5
);
#8b
select * from gross_revenue;
#8c
drop view gross_revenue;















