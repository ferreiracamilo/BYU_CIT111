/*
 !!! QUERY 1 !!!

Write a query to show the country and population of all countries with population smaller than 5 million.
Sort the list by population with the largest population first. What is the fifth country on your list?
*/
---- 'Togo', '4629000'

/*
 !!! QUERY 2 !!!

Copy and paste your first query here.
*/
SELECT Name, Population
FROM world.country
WHERE Population < 5000000
ORDER BY Population DESC;

/*
 !!! QUERY 3 !!!

Write a query to show a list of the unique languages in the country language table.
Sort the list in alphabetical order. What is the fifth language in your list?
*/
--- 'Afrikaans'


/*
 !!! QUERY 4 !!!
Copy and paste your second query here.
*/
SELECT DISTINCT(Language)
FROM world.countrylanguage
ORDER BY Language;

/*
 !!! QUERY 5 !!!
Write a query to list the continents and the number of countries in each continent.
How many countries are in North America?
*/
--North America > 37

/*
 !!! QUERY 6 !!!
Copy and paste your third query here.
*/
SELECT Continent, COUNT(Name)
FROM world.country
GROUP BY Continent;

/*
 !!! QUERY 7 !!!
Write a query that shows the columns (with specified labels):

Country - the name of the country

Avg_Population_of_Cities - the average population of the cities of that country

Sort the results by the largest population average first.

What is the average population of the cities of Liberia?
*/
--- Liberia	850000.0000

/*
 !!! QUERY 8 !!!
Copy and paste your fourth query here.
*/

SELECT co.Name AS "Country", AVG(ci.Population) AS "Avg_Population_of_Cities"
FROM world.country co
    JOIN world.city ci
    ON co.Code = ci.CountryCode
GROUP BY co.Name
ORDER BY Avg_Population_of_Cities DESC;