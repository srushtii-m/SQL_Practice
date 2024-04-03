-- DATA EXPLORATION

-- SELECT & ORDER BY

--What is the name of the category with the highest category_id in the dvd_rentals.category table?
SELECT name, category_id
FROM dvd_rentals.category
ORDER BY category_id desc
LIMIT 1;

-- For the films with the longest length, what is the title of the “R” rated film with the lowest replacement_cost in dvd_rentals.film table?
SELECT length, title, replacement_cost, rating
FROM dvd_rentals.film
WHERE rating='R'
ORDER BY length desc, replacement_cost 
LIMIT 1;

-- Who was the manager of the store with the highest total_sales in the dvd_rentals.sales_by_store table?
SELECT manager, total_sales
FROM dvd_rentals.sales_by_store
ORDER BY total_sales DESC
LIMIT 1;

-- What is the postal_code of the city with the 5th highest city_id in the dvd_rentals.address table?
SELECT postal_code, city_id
FROM dvd_rentals.address
ORDER BY city_id DESC;

-- TOP instead of LIMIT
SELECT
  TOP 10 *
FROM some_schema.table_name;

-- NULLS FIRST - works even with DESC ORDER BY
WITH test_data (sample_values) AS (
VALUES
(null),
('0123'),
('_123'),
(' 123'),
('(abc'),
('  abc'),
('bca')
)
SELECT * FROM test_data
ORDER BY 1 DESC NULLS FIRST;

-- How many records?
SELECT
  COUNT(*) AS row_count
FROM dvd_rentals.film_list;

--How many unique category values are there in the film_list table?
SELECT
  COUNT(DISTINCT category) AS unique_category_count
FROM dvd_rentals.film_list

--What is the frequency of values in the rating column in the film_list table?
WITH example_table AS (
  SELECT
    fid,
    title,
    category,
    rating,
    price
  FROM dvd_rentals.film_list
  LIMIT 10
)
SELECT
  rating,
  COUNT(*) as record_count
FROM example_table
GROUP BY rating
ORDER BY record_count DESC;

-- What is the frequency of values in the rating column in the film table?
SELECT
  rating,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list
GROUP BY rating;
--with percentage
SELECT
  rating,
  COUNT(*) AS frequency,
  ROUND(
    100 * COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER (),
    2
  ) AS percentage
FROM dvd_rentals.film_list
GROUP BY rating
ORDER BY frequency DESC;

-- What are the 5 most frequent rating and category combinations in the film_list table?
SELECT
  rating,
  category,
  COUNT(*) AS frequency
FROM dvd_rentals.film_list
GROUP BY rating, category
ORDER BY frequency DESC
LIMIT 5;

-- Which actor_id has the most number of unique film_id records in the dvd_rentals.film_actor table?
SELECT
  actor_id,
  COUNT(DISTINCT film_id)
FROM dvd_rentals.film_actor
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- How many distinct fid values are there for the 3rd most common price value in the dvd_rentals.nicer_but_slower_film_list table?
SELECT
  price,
  COUNT(DISTINCT fid)
FROM dvd_rentals.nicer_but_slower_film_list
GROUP BY 1
ORDER BY 2 DESC;

-- How many unique country_id values exist in the dvd_rentals.city table?
SELECT
  COUNT(DISTINCT country_id) AS unique_countries
FROM dvd_rentals.city;

-- What percentage of overall total_sales does the Sports category make up in the dvd_rentals.sales_by_film_category table?
SELECT
  category,
  ROUND(
    100 * total_sales::NUMERIC / SUM(total_sales) OVER (),
    2
  ) AS percentage
FROM dvd_rentals.sales_by_film_category;

-- What percentage of unique fid values are in the Children category in the dvd_rentals.film_list table?
SELECT
  category,
  ROUND(
    100 * COUNT(DISTINCT fid)::NUMERIC / SUM(COUNT(DISTINCT fid)) OVER (),
    2
  ) AS percentage
FROM dvd_rentals.film_list
GROUP BY category
ORDER BY category;