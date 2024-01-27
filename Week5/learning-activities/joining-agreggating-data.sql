/*

Practice inner joins by following along with the video.

INNER JOIN will show the intersection between the tables

*/

USE v_art;

---## QUERY 1 ##---

--These are the same
SELECT fname, lname, title
FROM artwork INNER JOIN artist;

SELECT fname, lname, title
FROM artwork JOIN artist;

SELECT fname, lname, title
FROM artwork
    JOIN artist
    ON artwork.artist_id = artist.artist_id;

--Replace the ON clause for a USING clause. Primary and foreign key must match exactly on their names
--This is not totally recommended anyways
SELECT fname, lname, title
FROM artwork
    JOIN artist
    USING(artist_id);

---## QUERY 2 ##---
SELECT fname, lname, title
FROM artwork
    JOIN artist
    ON artwork.artist_id = artist.artist_id
WHERE lname = 'da Vinci';

---## QUERY 3 ##---
USE bike;

SELECT product_name, category_name, list_price
FROM product
    JOIN category
    ON product.category_id = category.category_id;

---## QUERY 4 ##---
USE bike;

SELECT product_name, category_name, brand_name, list_price
FROM product
    JOIN category
    ON product.category_id = category.category_id
    JOIN brand
    ON product.brand_id = brand.brand_id;

---## QUERY 5 ##---
USE bike;

SELECT product_name, category_name, brand_name, list_price
FROM product
    JOIN category
    ON product.category_id = category.category_id
    JOIN brand
    ON product.brand_id = brand.brand_id
WHERE category_name = 'Children Bicycles';

---## QUERY 6 ##---
USE bike;

SELECT product_name, category_name, brand_name, list_price
FROM product p
    JOIN category c
    ON p.category_id = c.category_id
    JOIN brand b
    ON p.brand_id = b.brand_id
WHERE category_name = 'Children Bicycles';

---## QUERY 7 ##---
USE bike;

SELECT first_name, last_name, store.store_id
FROM staff
    JOIN store
    ON staff.store_id = store.store_id
WHERE staff.store_id = 3;

---## QUERY 8 ##---
USE v_art;

SELECT title
FROM artwork a
    JOIN artwork_keyword ak
    ON a.artwork_id = ak.artwork_id
    JOIN keyword k
    ON ak.keyword_id = k.keyword_id
WHERE keyword = 'water';


/*

Practice OUTER JOIN by following along with the video.

*/

USE v_art;

---## QUERY 9 ##---
--These are the same
SELECT fname, lname, title
FROM artist LEFT JOIN artwork
    ON artist.artist_id = artwork.artist_id;

SELECT fname, lname, title
FROM artist LEFT OUTER JOIN artwork
    ON artist.artist_id = artwork.artist_id;


/*

Practice with AGREGGATE FUNCTIONS

*/

---## QUERY 10 ##---
USE v_art;

SELECT COUNT(country), country
FROM artist
WHERE country = 'France';

---## QUERY 11 ##---
USE bike;

SELECT SUM(list_price), MAX(list_price), MIN(list_price)
FROM product;

---## QUERY 12 ##---
SELECT AVG(list_price)
FROM product;

---## QUERY 13 ##---
SELECT model_year, AVG(list_price)
FROM product
WHERE list_price > 2800
GROUP BY model_year;