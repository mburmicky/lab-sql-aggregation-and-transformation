USE sakila;
#CHALLENGE 1
#1) You need to use SQL built-in functions to gain insights relating to the duration of movies:

#1.1) Determine the shortest and longest movie durations and name the values as max_duration and min_duration.


SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM sakila.film;

#1.2) Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions

SELECT CONCAT(FLOOR(AVG(length)/60),'h',ROUND(AVG(length)%60),'m') AS average_duration FROM sakila.film;

#2) You need to gain insights related to rental dates:

#2.1) Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT * FROM sakila.rental ORDER BY rental_date ASC;

SELECT DATEDiff(MAX(rental_date),MIN(rental_date)) AS nb_days_comp_operating FROM sakila.rental;

#2.2) Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT * FROM sakila.rental;

SELECT *, date_format(rental_date, '%M') AS rental_month, date_format(rental_date,'%a') AS rental_week_day FROM sakila.rental LIMIT 20;

#3) You need to ensure that customers can easily access information about the movie collection. 
# To achieve this, retrieve the film titles and their rental duration.
# If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order

SELECT title,
CASE
WHEN rental_duration = 3 then 3
WHEN rental_duration = 4 then 4
WHEN rental_duration = 5 then 5
WHEN rental_duration = 6 then 6
WHEN rental_duration = 7 then 7
WHEN rental_duration IS NULL then 'Not Available'
ELSE 'Not Available'
END AS 'rental_duration'
FROM film ORDER BY title ASC;

#CHALLENGE 2

#1.1) The total number of films that have been released.

SELECT COUNT(DISTINCT film_id) AS nb_films_released FROM film;

#1.2) The number of films for each rating

SELECT rating, count(rating) AS nb_films_per_rating FROM film GROUP BY rating;

#1.3) The number of films for each rating, sorting the results in descending order of the number of films.
#This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly

SELECT rating, count(rating) AS nb_films_per_rating FROM film GROUP BY rating ORDER BY nb_films_per_rating DESC;

#2.1) The mean film duration for each rating, and sort the results in descending order of the mean duration.
#Round off the average lengths to two decimal places. 
#This will help identify popular movie lengths for each category.

SELECT rating, ROUND(AVG(length),2) AS avg_film_length_per_rating FROM film GROUP BY rating ORDER BY avg_film_length_per_rating DESC;

#2.2) Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, ROUND(AVG(length),2) AS avg_film_length_per_rating FROM film GROUP BY rating HAVING avg_film_length_per_rating>120;

#3) Bonus: determine which last names are not repeated in the table actor.

SELECT last_name, COUNT(last_name) FROM sakila.actor GROUP BY last_name HAVING COUNT(last_name) = 1;
