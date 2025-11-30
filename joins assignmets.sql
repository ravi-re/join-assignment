-- 1. List all customers along with the films they have rented.
use sakila;
select c.first_name,
       c.last_name,
	   f.title as films
from customer c        
join rental r 
on c.customer_id = r.customer_id
 join inventory i 
on r.inventory_id = i.inventory_id
 join film f
on i.film_id = f.film_id
order by c.first_name,f.title;

-- 2. List all customers and show their rental count, including those who haven't rented any films.

select c.customer_id,
	   c.first_name,
       c.last_name,
       count(rental_id) as rental_count
from customer c
left join rental r
on c.customer_id = r.customer_id
group by c.customer_id,c.first_name,c.last_name;

-- 3. Show all films along with their category. Include films that don't have a category assigned.
select  title,
        description,
        name
from film f
 left join film_category fc 
on f.film_id = fc.film_id
left join category c

on fc.category_id = c.category_id;

-- 4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
select c.customer_id,
	   c.email as customer_email,
	   s.staff_id,
       s.email as staff_email
from customer c
left join staff s
on c.email = s.email

union

select c.customer_id,
	   c.email as customer_email,
       s.staff_id,
       s.email as staff_email
from customer c
right join staff s
on c.email = s.email;


-- 5. Find all actors who acted in the film "ACADEMY DINOSAUR".
select a.actor_id,
       a.first_name,
       a.last_name
from actor a
join film_actor fa
on a.actor_id = fa.actor_id
join film f
on fa.film_id = f.film_id
where f.title = 'ACADEMY DINOSAUR';


-- 6. List all stores and the total number of staff members working in each store, even if a store has no staff.
 SELECT 
    s.store_id,
    COUNT(st.staff_id) AS total_staff
FROM store s
LEFT JOIN staff st
    ON s.store_id = st.store_id
GROUP BY s.store_id;

-- 7. List the customers who have rented films more than 5 times. Include their name and total rental count.
select c.customer_id,
        c.first_name,
         c.last_name,
       count(rental_id) as total_rental
from customer c
join rental r
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name,c.last_name
having count(r.rental_id) >5;