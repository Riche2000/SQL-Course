SELECT * FROM customer LIMIT 1

SELECT COUNT(amount) FROM payment

SELECT DISTINCT amount FROM payment

SELECT COUNT (DISTINCT amount) FROM payment
SELECT COUNT (DISTINCT(amount)) FROM payment

SELECT * FROM customer

SELECT * FROM customer WHERE first_name = 'Jared'

SELECT * FROM film WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating ='R'
SELECT title FROM film WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating ='R'
SELECT COUNT(title) FROM film WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating ='R'
SELECT COUNT(*) FROM film WHERE rating ='R' OR rating ='PG-13'

SELECT * FROM customer Order BY first_name ASC
SELECT * FROM customer Order BY first_name DESC

SELECT * FROM payment WHERE amount BETWEEN 8 AND 9
SELECT COUNT(*) FROM payment WHERE amount BETWEEN 8 AND 9
SELECT COUNT(*) FROM payment WHERE amount NOT BETWEEN 8 AND 9
--En este caso se debe de poner un día despues de la fecha limite , por ejemplo para regresar de la fecha 14, debemos de poner 15
SELECT * FROM payment WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15'

--IN 

SELECT DISTINCT(amount) FROM payment ORDER BY amount
SELECT * FROM payment WHERE amount IN (0.99,1.98,1.99)
SELECT COUNT(*) FROM payment WHERE amount IN (0.99,1.98,1.99)
--Regresa los valores que no son 0.99,1.98,1.99
SELECT COUNT(*) FROM payment WHERE amount NOT IN (0.99,1.98,1.99)
SELECT * FROM customer WHERE first_name NOT IN ('John','Jake','Julie')

--LIKE and ILIKE

--LIKE es Key sensitive
SELECT * FROM customer WHERE first_name LIKE 'J%'
SELECT * FROM customer WHERE first_name LIKE 'J%' AND last_name LIKE 'S%'
SELECT COUNT(*) FROM customer WHERE first_name LIKE 'J' AND last_name LIKE 'S%'
SELECT * FROM customer WHERE first_name LIKE '%er%'
SELECT * FROM customer WHERE first_name LIKE '_er%'

--ILIKE no es Key Sensitive
SELECT * FROM customer WHERE first_name ILIKE 'j%' AND last_name ILIKE 's%'

--NOT LIKE
SELECT * FROM customer WHERE first_name NOT LIKE '%er%'
SELECT * FROM customer WHERE first_name NOT ILIKE 'er%' AND first_name NOT LIKE '%er%'

-- TEST

SELECT COUNT(amount) FROM payment WHERE amount > 5
SELECT COUNT(*) FROM actor WHERE first_name LIKE 'P%'
SELECT COUNT(DISTINCT(district)) FROM address
SELECT DISTINCT(district) FROM address
SELECT COUNT(*) FROM film WHERE rating='R' AND replacement_cost BETWEEN 5 AND 15
SELECT COUNT(*) FROM film WHERE title LIKE'%Truman%'

-- GROUP BY 

-- AGREGACIONES
--EL Costo minimo, solo puede regresar un solo valor
SELECT MIN(replacement_cost) FROM film
--El costo maximo, solo puede regresar un solo valor
SELECT MAX(replacement_cost) FROM film
--Si se usa MAX y MIN, si regresara los dos valores.
SELECT MAX(replacement_cost), MIN(replacement_cost) FROM film
--Consultar el promedio con AVG
SELECT AVG(replacement_cost) FROM film
--Redondear el resultado con dos decimales para que no aparezcan tantos ceros
SELECT ROUND(AVG(replacement_cost),2) FROM film
SELECT ROUND(AVG(replacement_cost)) FROM film
SELECT SUM(replacement_cost) FROM film

SELECT customer_id FROM payment GROUP BY customer_id ORDER BY customer_id
--MONTO TOTAL DE LAS TRANSACCIONES
SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC
--CUANTAS TRANSACCIONES ESTAN OCURRIENDO
SELECT customer_id, COUNT(amount) FROM payment GROUP BY customer_id ORDER BY COUNT(amount) DESC

SELECT customer_id, staff_id,SUM(amount) FROM payment GROUP BY staff_id,customer_id ORDER BY customer_id
SELECT staff_id, customer_id, SUM(amount) FROM payment GROUP BY staff_id,customer_id ORDER BY staff_id, customer_id

SELECT DATE(payment_date), SUM(amount) FROM payment GROUP BY DATE(payment_date)
SELECT DATE(payment_date), SUM(amount) FROM payment GROUP BY DATE(payment_date) ORDER BY SUM(amount)

SELECT staff_id, COUNT(*) FROM payment GROUP BY staff_id
SELECT rating, ROUND(AVG(replacement_cost),2) FROM film GROUP BY rating
SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 5

--HAVING
SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id
SELECT customer_id, SUM(amount) FROM payment WHERE customer_id NOT IN (184,87,477) GROUP BY customer_id
SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id HAVING SUM(amount)>100

SELECT store_id, COUNT(customer_id) FROM customer GROUP BY store_id
SELECT store_id, COUNT(*) FROM customer GROUP BY store_id HAVING COUNT(*) > 300
SELECT store_id, COUNT(customer_id) FROM customer GROUP BY store_id HAVING COUNT(customer_id) > 300

--CLIENTES QUE TIENEN MÁS DE 40 TRANSACCIONES
SELECT customer_id, COUNT(payment_id) FROM payment GROUP BY customer_id HAVING COUNT(payment_id) > 39
--CLIENTES QUE HAYAN COMPRADO AL MENOS $100 CON EL STAFF 2
SELECT customer_id, staff_id, SUM(amount) FROM payment WHERE staff_id='2' GROUP BY customer_id, staff_id HAVING SUM(amount) > 100

SELECT customer_id, staff_id, SUM(amount) FROM payment WHERE staff_id='2' GROUP BY customer_id, staff_id HAVING SUM(amount) > 110
SELECT COUNT(*) FROM film WHERE title LIKE 'J%'
SELECT customer_id, first_name, last_name, address_id FROM customer WHERE first_name LIKE 'E%' AND address_id<500 ORDER BY customer_id DESC LIMIT 1