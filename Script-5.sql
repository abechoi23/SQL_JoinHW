-- Find all of the first and last names for customers in 'Clarksville'
SELECT *
FROM address
WHERE city_id=123;

SELECT *
FROM customer
WHERE address_id=144;

SELECT *
FROM customer 
WHERE address_id=145;

-- Inner join method
SELECT *
FROM address 
JOIN customer
ON address.address_id = customer.address_id
WHERE city_id=123;

SELECT customer.address_id, district, first_name, last_name 
FROM address 
JOIN customer
ON address.address_id = customer.address_id
WHERE district = 'Gois';


-- How many movies has Tamara Nguyen rented?
SELECT COUNT(*) AS tamaras_rentals
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
WHERE first_name = 'Tamara' AND last_name = 'Nguyen';

SELECT payment_id, amount, first_name
FROM payment p
JOIN staff s 
ON p.staff_id = s.staff_id;

-- Sum of all the payment(amount) handled by Mike
SELECT sum(amount)
FROM payment p
JOIN staff s 
ON p.staff_id = s.staff_id
WHERE first_name = 'Mike';

-- Sum of all the payment(amount) handled by all first_name
SELECT sum(amount), first_name
FROM payment p
JOIN staff s 
ON p.staff_id = s.staff_id
GROUP BY first_name;

-- Find all of the movie title with an actor id of 3 in the cast
SELECT title, a.first_name, a.actor_id 
FROM film f 
JOIN film_actor fa 
ON f.film_id = fa.film_id 
JOIN actor a 
ON fa.actor_id = a.actor_id 
WHERE a.actor_id = '3';

-- Find all films in a certain language (English)
SELECT title
FROM film f 
JOIN "language" l 
ON l."name" = 'English';

-- Find all the actors who released a PG-13 film
SELECT DISTINCT a.actor_id, first_name
FROM film f 
JOIN film_actor fa 
ON f.film_id  = fa.film_id
JOIN actor a 
ON fa.actor_id = a.actor_id 
WHERE rating = 'PG-13'
ORDER BY a.actor_id ASC;

-- What customers rent movies with at least 8 actors

-- What country rents the most movie
SELECT country, count(*) AS rental_qty
FROM country c 
JOIN city c2 
ON c2.country_id = c.country_id
JOIN address a 
ON a.city_id = c2.city_id
JOIN customer c3 
ON c3.address_id = a.address_id
JOIN rental r 
ON r.customer_id = c3.customer_id
GROUP BY country
ORDER BY rental_qty DESC;


--
SELECT *
FROM inventory i 
RIGHT JOIN film f 
ON f.film_id = i.film_id;

SELECT *
FROM film f
left JOIN inventory i  
ON f.film_id = i.film_id;

SELECT *
FROM inventory i 
FULL OUTER JOIN film f 
ON f.film_id = i.film_id 
WHERE inventory_id IS NULL OR f.film_id IS NULL;


-- Find actors that starred in pg-13 movies
SELECT DISTINCT a.actor_id, first_name, last_name, rating 
FROM film f 
JOIN film_actor fa 
ON f.film_id  = fa.film_id
JOIN actor a 
ON fa.actor_id = a.actor_id 
WHERE rating = 'PG-13'
ORDER BY a.actor_id ASC;

-- Find all the staff that live in Canada.
SELECT "name", country 
FROM staff_list sl
WHERE country = 'Canada';


SELECT first_name, last_name, country 
FROM staff s 
JOIN address a ON s.address_id = a.address_id 
JOIN city c ON a.city_id = c.city_id 
JOIN country c2 ON c.country_id = c2.country_id 
WHERE country = 'Canada';

-- How many times have movies featuring Nick Wahlberg been rented?
SELECT a.first_name, a.last_name, COUNT(*)
FROM film f 
JOIN film_actor fa 
ON f.film_id  = fa.film_id
JOIN actor a 
ON fa.actor_id = a.actor_id 
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
WHERE first_name = 'Nick' AND last_name = 'Wahlberg'
GROUP BY a.first_name, a.last_name;

-- What categories does Nick Walburg feature in?
SELECT c.name, a.first_name, a.last_name
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id 
JOIN film f ON fc.film_id = f.film_id 
JOIN film_actor fa ON f.film_id = fa.film_id 
JOIN actor a ON fa.actor_id = a.actor_id 
WHERE first_name = 'Nick' AND last_name = 'Wahlberg'
GROUP BY c.name, a.first_name, a.last_name;

-- Subqueries

-- Find all of the payments in our database
-- that are larger than the average payment
SELECT avg(amount)
FROM payment p;

SELECT *
FROM payment p 
WHERE amount > 4.20;

SELECT *
FROM payment
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
);

-- Write a subquery to find all of the films that have a language of English
SELECT *
FROM "language" l 
WHERE "name" = 'English';

SELECT *
FROM film f
WHERE language_id = (
	SELECT language_id 
	FROM "language" l 
	WHERE "name" = 'English'
);

-- Find all of the films with an actor with the last name 'Allen'
SELECT actor_id
FROM actor a 
WHERE last_name = 'Allen';

SELECT *
FROM film_actor fa 
WHERE actor_id IN (
	SELECT actor_id 
	FROM actor a 
	WHERE last_name = 'Allen'
)

SELECT title
FROM film f 
WHERE film_id  IN (
	SELECT film_id 
	FROM film_actor fa 
	WHERE actor_id IN (
		SELECT actor_id
		FROM actor a 
		WHERE last_name = 'Allen'
	)
);

-- Find which country rents the most foreign films
SELECT country
FROM category c
JOIN film_category fc 
ON c.category_id = fc.category_id 
JOIN film f 
ON f.film_id = fc.film_id
JOIN inventory i 
ON i.film_id = f.film_id 
JOIN rental r
ON r.inventory_id = i.inventory_id 
JOIN customer c2
ON c2.customer_id = r.customer_id 
JOIN address a 
ON c2.address_id = a.address_id 
JOIN city c3 
ON c3.city_id = a.city_id
JOIN country c4 
ON c4.country_id = c3.country_id 
WHERE "name"='Foreign'
GROUP BY country
HAVING COUNT(*) = (
	SELECT MAX(foreign_count)
	FROM (
		SELECT country, COUNT(*) AS foreign_count
		FROM category c
		JOIN film_category fc 
		ON c.category_id = fc.category_id 
		JOIN film f 
		ON f.film_id = fc.film_id
		JOIN inventory i 
		ON i.film_id = f.film_id 
		JOIN rental r
		ON r.inventory_id = i.inventory_id 
		JOIN customer c2
		ON c2.customer_id = r.customer_id 
		JOIN address a 
		ON c2.address_id = a.address_id 
		JOIN city c3 
		ON c3.city_id = a.city_id
		JOIN country c4 
		ON c4.country_id = c3.country_id 
		WHERE "name"='Foreign'
		GROUP BY country
	) foreign_country_rentals
);

CREATE OR REPLACE VIEW foreign_country_rentals
AS
	SELECT country, COUNT(*) AS foreign_count
	FROM category c
	JOIN film_category fc 
	ON c.category_id = fc.category_id 
	JOIN film f 
	ON f.film_id = fc.film_id
	JOIN inventory i 
	ON i.film_id = f.film_id 
	JOIN rental r
	ON r.inventory_id = i.inventory_id 
	JOIN customer c2
	ON c2.customer_id = r.customer_id 
	JOIN address a 
	ON c2.address_id = a.address_id 
	JOIN city c3 
	ON c3.city_id = a.city_id
	JOIN country c4 
	ON c4.country_id = c3.country_id 
	WHERE "name"='Foreign'
	GROUP BY country;

SELECT *
FROM foreign_country_rentals fcr 
WHERE foreign_count = (
	SELECT MAX(foreign_count)
	FROM foreign_country_rentals
);

