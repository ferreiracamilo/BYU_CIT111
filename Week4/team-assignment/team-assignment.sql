/*

USE BIKE DATA FROM db-intro-database-setup.sql - This must be executed upon assignment start

*/


/*
##### 1 #####
I need a list of all the customers with Gmail accounts because there is a new Google application
that can interface with them through their email. We'd like to contact them and invite them to use it.
##### 1 #####
*/

--ALTERNATIVE 1
USE bike;
SELECT * FROM customer
WHERE email REGEXP "@gmail.com";

--ALTERNATIVE 2
USE bike;
SELECT * FROM customer
WHERE email LIKE "%@gmail.com"; --there's no wildcard at the end since there should not be any thing after the domain suffix

/*
##### 2 #####
Haro called and wants to discount all their bikes by 20%. Please get me the name of the bikes from Haro (brand_id 2)
and show the original price and then a column with the sales price with a readable column header.
##### 2 #####
*/

USE bike;
SELECT product_name, list_price, list_price * 0.8 AS price_with_discount
FROM product
WHERE brand_id = (SELECT brand_id FROM brand WHERE brand_name = 'Haro');

/*
##### 3 #####
We need to see the order number and order date from all orders at Santa Cruz Bikes (store_id 1) but
I don't need to see the orders made by Mireya Copeland who's staff_id is 2. Just Fabiola, Genna and Virgie's orders (everyone else who works there).
##### 3 #####
*/

--ALTERNATIVE 1
SELECT cust_order_id, order_date FROM cust_order
WHERE staff_id <> 2 AND store_id = 1;

--ALTERNATIVE 2
SELECT cust_order_id, order_date FROM cust_order
WHERE staff_id <> 2 AND store_id = (SELECT store_id FROM store WHERE store_name = 'Santa Cruz Bikes');

/*
##### 4 #####
I need all the order numbers and order dates for the month of February 2017. We need to clear out all our frame specific bikes and Women's bikes. 
They are not selling well and we will be displaying them in our annual sidewalk sale. Find all of the bike product names with 'Frame' or 'Frameset'
in the name or the word 'Women's'.
##### 4 #####
*/

--- <<< DIVIDE & CONQUER STRATEGY >>>>

--- !! RESOLVE DATE FILTER !!

--START ALTERNATIVE 1
SELECT cust_order_id
FROM cust_order
WHERE YEAR(order_date) = 2017 AND MONTH(order_date) = 2

--START ALTERNATIVE 2 > However using a fix day number would require for you to check how many days feb 2017 had
SELECT cust_order_id
FROM cust_order
WHERE order_date BETWEEN '2017-02-01' AND '2017-02-28'

--- !! RESOLVE PRODUCT FILTER !!
--- Do not list any bike that its name includes either 'Frame', 'Frameset' or 'Women's'

SELECT product_id
FROM product
WHERE NOT(product_name REGEXP "Frame|Frameset|Women's"); --We initially search for those name that include these words and then DENY our search to filter them out

--- !! RESOLVE cust_order & product table relationship !!
SELECT cust_order_id
FROM cust_order_item
WHERE product_id IN (
    SELECT product_id
    FROM product
    WHERE NOT(product_name REGEXP "Frame|Frameset|Women's")
);

--- !! MIX - FINAL STEP !!
SELECT cust_order_id, order_date
FROM cust_order
WHERE order_date BETWEEN '2017-02-01' AND '2017-02-28' AND cust_order_id IN (
    SELECT cust_order_id
    FROM cust_order_item
    WHERE product_id IN (
        SELECT product_id
        FROM product
        WHERE NOT(product_name REGEXP "Frame|Frameset|Women's")
    )
);

/*
##### 5 #####
We need all the bikes product names that start with A-H and whose list price is more than $299.99 or exactly $299.99.
Sort them by product name. We will need to inventory those bikes first during inventory.
##### 5 #####
*/

SELECT product_name
FROM product
WHERE product_name LIKE 'a%' OR  product_name LIKE 'h%' AND list_price >= 299.99
ORDER BY product_name;