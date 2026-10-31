-- 01 Получите список актёров, чьи фамилии - 'WILLIAMS' или 'DAVIS', а затем найдите в нём имя, начинающиеся на 'J'. Запишите имя и фамилию этого актёра.

-- Ваш код:
SELECT first_name, last_name 
FROM actor
WHERE last_name IN ('WILLIAMS', 'DAVIS') AND first_name LIKE 'J%';

-- Ваш ответ: JENNIFER DAVIS


-- 02 Получите список выдачи дисков в прокат (таблица rental) от 5 июля 2005 года. Чтобы игнорировать время выдачи, можно использовать функцию date(). Определите, какой заказ из этого списка был возвращён самым последним. Запишите дату.

-- Ваш код:
SELECT rental_id, rental_date
FROM rental 
WHERE DATE(rental_date)='2005-07-05'  ORDER BY rental_date  DESC LIMIT 1;

-- Ваш ответ: 3496 2005-07-05 23:59:15


-- 03 Создайте запрос, который находит всех клиентов, начальные буквы фамилий которых находятся между 'AN' и AT'. Отсортируйте вывод по именам.

-- Ваш код:
SELECT first_name, last_name 
FROM customer 
WHERE last_name BETWEEN 'AN' AND 'AT'  ORDER BY first_name ;


-- Ваш ответ:
/*BEATRICE ARNOLD
CARL ARTIS
DARRYL ASHCRAFT
HARRY ARCE
IDA ANDREWS
JORDAN ARCHULETA
JOSE ANDREW
KENT ARSENAULT
LISA ANDERSON
MELANIE ARMSTRONG
OSCAR AQUINO
TYRONE ASHER*/


-- 04 Создайте запрос, который находит всех клиентов, в фамилиях которых содержатся буква А во второй позиции и буква W — в любом месте после А. Отсортируйте результат по фамилиям. Если не знаете как это сделать, ищите информацию об использовании в запросах подстановочных знаков.

-- Ваш код:
SELECT first_name, last_name 
FROM customer 
WHERE last_name LIKE '_A%W%' ORDER BY last_name;

-- Ваш ответ:
/*KAY CALDWELL
JOHN FARNSWORTH
JILL HAWKINS
LEE HAWKS
LAURIE LAWRENCE
JEANNE LAWSON
LAWRENCE LAWTON
SAMUEL MARLOW
ERICA MATTHEWS*/


-- 05 Используя таблицы rental и customer среди клиентов, вернувших заказ 7 июля 2005 года найдите электронную почту того, кто продержал заказ дольше всех.

-- Ваш код:
SELECT c.email, r.rental_date, r.return_date, (r.return_date - r.rental_date ) AS delay
FROM customer c  JOIN rental r 
WHERE DATE(rental_date)='2005-07-05'  ORDER BY delay  DESC LIMIT 1;

-- Ваш ответ: MARY.SMITH@sakilacustomer.org


-- 06 Среди клиентов, разовый платёж которых за заказ был более 11 долларов и менее 12 найдите имя того, чья фамилия 'GILBERT'

-- Ваш код:
SELECT c.first_name, c.last_name, p.amount 
FROM payment p  JOIN customer c ON p.customer_id=c.customer_id 
WHERE p.amount > 11 AND p.amount <= 12 AND c.last_name = 'GILBERT';

-- Ваш ответ:TANYA GILBERT


-- 07 Постройте объединение таблиц customer, address и city и найдите имя, адрес и город клиента с фамилией 'JOHNSTON' из Калифорнии.

-- Ваш код:
SELECT c.first_name, c.last_name, a.address, c2.city 
FROM customer c JOIN address a ON c.address_id=a.address_id JOIN city c2 ON a.city_id=c2.city_id 
WHERE  c.last_name = 'JOHNSTON' AND a.district = 'California';

-- Ваш ответ: KRISTIN JOHNSTON 226 Brest Manor Sunnyvale


-- 08 Напишите запрос, который выводил бы названия всех фильмов, начинающиеся с буквы 'B', в которых играл актер с именем KARL.

-- Ваш код:
SELECT f.title 
FROM film f JOIN film_actor fa ON f.film_id=fa.film_id JOIN actor a ON fa.actor_id=a.actor_id 
WHERE f.title LIKE 'B%' and a.first_name = 'KARL';

-- Ваш ответ:
/*
BOUND CHEAPER
BOWFINGER GABLES
BUNCH MINDS
 */


-- 09 Используя таблицы rental и customer и функцию extract() найдите фамилию клиентки по имени JANET, которая в брала диски в августе и вернула в сентябре. Возможно для проверки и сравнения месяцев потребуется задействовать секцию having.

-- Ваш код:
SELECT c.first_name, c.last_name 
FROM rental r JOIN customer c ON r.customer_id=c.customer_id 
WHERE c.first_name = 'JANET' AND EXTRACT(MONTH FROM r.rental_date) = 8 
AND EXTRACT(MONTH FROM r.return_date) = 9; 

-- Ваш ответ: JANET PHILLIPS

SELECT f.title l.name as language
FROM film f 
JOIN language l ON f.language_id = l.language_id

SELECT CONCAT(c.first_name, '', c.last_name) as person, f.title
FROM rental r
JOIN customer c ON r.customer_id=c.customer_id
JOIN inventory i ON r.inventory_id=i.inventory_id
JOIN film f ON f.film_id=r.film_id
ORDER BY person, f.title
-- 10 Используя таблицу payment, подсчитайте количество платежей, которые сделал каждый клиент и общую уплаченную каждым клиентом сумму. Выполните упорядочивание результатов запроса по убыванию уплаченной суммы и ограничьте вывод тремя первыми записями.

-- Ваш код:
SELECT customer_id, COUNT(payment_id) AS payment_count, SUM(amount) AS total_amount
FROM payment 
GROUP BY customer_id ORDER BY total_amount DESC LIMIT 3;
-- Ваш ответ: 
/*45	221.55
46	216.54
42	195.58*/


-- 11 Модифицируйте предыдущий запрос так, чтобы он дополнительно выдавал имена и фамилии трёх клиентов с наибольшими суммарными платежами.

-- Ваш код: 
SELECT c.customer_id, c.first_name, c.last_name, COUNT(p.payment_id ) AS payment_count, SUM(p.amount) AS total_amount
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_amount DESC
LIMIT 3;

-- Ваш ответ:
/*KARL	SEAL
ELEANOR	HUNT
CLARA	SHAW*/
