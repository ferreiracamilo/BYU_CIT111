/*
#################################
Virtual Gallery Database/Schema
#################################
*/

---!! QUERY 1 !!
/*
The manager wants to add the artist Johannes Vermeer as an artist in the database.
He was born in 1632 and is from the Netherlands and died in 1674. He is not a local artist.
What would the insert statement look like that would run as the manager adds a new artist to the system?
(The following image is a screenshot of the backend of the system that the manager of the art gallery would see.
We are interested only in the SQL statement that would run in the code when a new artist is added.)
*/

INSERT INTO v_art.artist
VALUES ("Johannes", NULL, "Vermeer", 1632, 1674, "Netherlands", "n");
--id is ommited based on artist_id configuration to be Auto Incremented

---!! QUERY 2 !!
/*
If the manager lists all the artists with 'List all Artist Records' the following screen renders sorted by the last name of the artist. 
What query would allow all seven columns of values to show up on the screen alphabetically by the last name?
*/

--Added aliases to match exactly with image table column headers, however does not impact on the final result on order or records picked
SELECT fname AS "First name", mname AS "Middle Name", lname AS "Last Name", dob AS "Date of Birth", dod AS "Date of Death", country AS "Country", local as "Local"
FROM v_art.artist
ORDER BY lname;

---!! QUERY 3 !!
/*
The manager wants to edit Vermeer's information. She finds out that he died in 1675, not 1674.
She selects EDIT next to Johannes Vermeer the following screen displays. The manager changes the 'Date of Death' value to be 1675 and selects 'Update Entry'.
What SQL statement will run in the background to accomplish this edit? (Don't forget a WHERE clause!)
*/
UPDATE v_art.artist
SET dod = 1675
WHERE lname = 'Vermeer';

---!! QUERY 4 !!
/*
The manager decides that she wants to delete Vermeer as an artist from her database.
She selects the DELETE next to the Vermeer's row of information and the following screen renders confirming that she really wants to delete Vermeer as an artist.
What SQL statement will run in the code that would delete Johannes Vermeer from the database when the manager selects 'Confirm Deletion'? (Don't forget a WHERE clause!)
*/

DELETE FROM v_art.artist
WHERE lname = 'Vermeer';

/*
#################################
Virtual Gallery Database/Schema
#################################
*/


/*
#################################
Bike Shop Database/Schema
#################################
*/

---!! QUERY 5 !!
/*
There is a product demonstration and bike race planned in Houston, Texas and you'd like to text each of your customers from that city to see if they will participate.
You need a list of their first and last names and phone numbers.
*/
--- SELECT * FROM bike.customer;
SELECT first_name, last_name, phone
FROM bike.customer
WHERE city = 'Houston' and state = 'TX';
--In hypotetical case there could be another city called houston we could reinforce by adding state filter as this query

---!! QUERY 6 !!
/*
You need to sell more of your high-end bikes. You want to take $500 off all bikes that have a list price of $5,000.00 or more.
You need to have a list showing the bike name, list price and discount price with an alias of 'Discount Price'.
Sort the list showing the most expensive bike first. The result set will look like this:
*/
SELECT product_name, list_price, list_price - 500 AS "Discount Price"
FROM bike.product
WHERE list_price >= 5000
ORDER BY list_price DESC;

---!! QUERY 7 !!
/*
An important announcement was given to all the staff at your store (store_id 1). The same announcement needs to get to all the other staff at the other stores.
You don't want to email all your staff again. You need a list of all the staff and their email who are not from your store.
*/

SELECT first_name, last_name, email
FROM bike.staff
WHERE store_id <> 1;

---!! QUERY 8 !!
/*
A customer needs more information about a specific bike, but all they know is that is has the word 'spider' in the name.
You need to list the name, model year, and list price of all the bikes with the word 'spider' somewhere in the name. 
*/
SELECT product_name, model_year, list_price
FROM bike.product
WHERE product_name REGEXP 'spider';

---!! QUERY 9 !!
/*
You need to list all bikes names that have a range of prices from $500–$550 sorted with the lowest price first.
*/
SELECT product_name, list_price
FROM bike.product
WHERE list_price BETWEEN 500 AND 550
ORDER BY list_price ASC;

---!! QUERY 10 !!
/*
Show the customer's first_name, last_name, phone, street, city, state, zip_code who:

have a phone number listed
and whose city has the letters 'ach' or 'och' somewhere in their name of the city
or whose last name is William. 
Limit the result set to the first five results.
*/
SELECT first_name, last_name, phone, street, city, state, zip_code
FROM bike.customer
WHERE phone IS NOT NULL AND city REGEXP "ach|och" OR last_name = "William"
LIMIT 5;

---!! QUERY 11 !!
/*
We need a list of all the products without the year at the end of the product_name string.
Notice that some have two years listed, make sure you take those off as well.
Order your results by product_id and limit your results to the first 14.
*/

SELECT TRIM(TRAILING '0123456789/' FROM SUBSTRING_INDEX(product_name, ' - ', 1)) AS product_name_without_year
FROM bike.product
ORDER BY product_id
LIMIT 14;

---!! QUERY 12 !!
/*
List the product name and then take the 2019 model year bikes and divide the price into 3 equal payments.
Display one of the payments with a dollar sign, comma at the thousands place and two decimal places.
*/

SELECT product_name, CONCAT('$', FORMAT(list_price / 3, 2)) AS "One of 3 payments"
FROM bike.product
WHERE model_year = 2019;

/*
#################################
Bike Shop Database/Schema
#################################
*/



/*
#################################
Magazine Database/Schema
#################################
*/

---!! QUERY 13 !!
/*
List the magazine name and then take 3% off the magazine price and round to 2 decimal places. 
*/