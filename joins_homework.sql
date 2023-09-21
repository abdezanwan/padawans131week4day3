--List all customers who live in Texas (useJOINs) 
--I used "c" as a short name for it, so we can easily mention it as "c" later in the query.
Bryan Hardison

SELECT c.customer_id, c.first_name, c.last_name
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE co.country = 'United States' AND ci.city = 'Dallas';



--Get all payments above $6.99 with the Customer's Full Name
Douglas Graf         919.67 
Mary Smith           478.86 
Alfredo Mcadams      74.94 
Harold Martino       81.99 
Mary Smith           34.95 
Mary Smith           77.95 
Mary Smith           980.45 
Peter Menard         142.99 
Peter Menard         136.99 
Peter Menard         142.99 
Peter Menard         137.99 
Peter Menard         1142.99 
Peter Menard         140.99 
Peter Menard         135.99 
Peter Menard         141.99 
Alvin Deloach        33.44 
Peter Menard         137.99 
Peter Menard         135.99 
Peter Menard         143.99 
Peter Menard         139.99 
Peter Menard         139.99 
Peter Menard         135.99 
Peter Menard         141.99 
Peter Menard         139.99 
Peter Menard         137.99 
Peter Menard         139.99
Peter Menard         135.99
Peter Menard         137.99
Peter Menard         137.99
Peter Menard         144.99



SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, p.amount
FROM customer AS c
JOIN payment AS p ON c.customer_id = p.customer_id
WHERE p.amount > 6.99;



--Show all customers names who have made payments over $175(usesubqueries)
Mary Smith
Douglas Graf

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customer AS c
WHERE c.customer_id IN (
    SELECT DISTINCT p.customer_id
    FROM payment AS p
    WHERE p.amount > 175
);



--List all customers that live in Nepal (use the citytable)
Kevin Schuler

SELECT c.customer_id, c.first_name, c.last_name
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE co.country = 'Nepal';



--Which staff member had the most transactions?
Mike Hillyer

SELECT s.staff_id, CONCAT(s.first_name, ' ', s.last_name) AS staff_name, COUNT(r.rental_id) AS transaction_count
FROM staff AS s
JOIN rental AS r ON s.staff_id = r.staff_id
GROUP BY s.staff_id, staff_name
ORDER BY transaction_count DESC
LIMIT 1;



--How many movies of each rating are there?
NC-17        209
G            178
PG-13        224
pG           194
R            196

SELECT rating, COUNT(film_id) AS movie_count
FROM film
GROUP BY rating;


-- Show all customers who have made a single payment above $6.99 (Use Subqueries)
0

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customer AS c
WHERE c.customer_id IN (
    SELECT p.customer_id
    FROM payment AS p
    GROUP BY p.customer_id
    HAVING COUNT(*) = 1 AND MAX(p.amount) > 6.99
);


--How many free rentals did our stores give away?"
0

SELECT COUNT(*) AS free_rentals_count
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
WHERE f.rental_rate = 0.00;
