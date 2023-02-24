--1. List all customers who live in Texas (use JOINs)
SELECT *
FROM customer c 
JOIN address a ON c.address_id = a.address_id 
WHERE district = 'Texas';


--2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id 
WHERE amount > 6.99
ORDER BY amount DESC;

--3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name 
FROM customer c 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment p 
	GROUP BY customer_id 
	HAVING SUM(amount) > 175
);


--4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country
FROM customer c 
JOIN address a ON c.address_id = a.address_id 
JOIN city c2 ON a.city_id = c2.city_id 
JOIN country c3 ON c2.country_id = c3.country_id 
WHERE country = 'Nepal';

--5. Which staff member had the most transactions?
SELECT first_name, last_name, COUNT(amount)
FROM staff s 
JOIN payment p ON s.staff_id = p.staff_id 
GROUP BY s.first_name, s.last_name 
ORDER BY COUNT(amount) DESC;


--6. How many movies of each rating are there?
SELECT rating, COUNT(*) AS num_movies
FROM film f 
GROUP BY rating;


--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer c 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment p 
	WHERE amount > 6.99
	GROUP BY customer_id 
	HAVING COUNT(*) = 1
)
ORDER BY first_name ASC;

--8. How many free rentals did our stores give away?
SELECT a.address, COUNT(*) AS free_movies
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id 
JOIN store s2 ON s.staff_id = s2.store_id 
JOIN address a ON s2.address_id = a.address_id 
WHERE amount = '0'
GROUP BY a.address;



