/*
#################################
        !!! QUERY 1 !!!
#################################

When you visit the Virtual Art Gallery Database and you search by Period/Style and you choose Impressionism,
you get two resulting images ("Woman in the Garden" and "Irises"). What query would be used in the code here
to allow the user to see these images? No join is needed. 
*/

SELECT artfile
FROM v_art.artwork
WHERE arttype = 'Impressionism';

/*
#################################
        !!! QUERY 2 !!!
#################################

When you visit the Virtual Art Gallery Database, search by Subject and type in the word flower, you get three images.
What query would have allowed the user to get those results (remember, the keyword might have been 'flowers' but they typed 'flower') .
*/

SELECT artfile
FROM v_art.artwork a
	JOIN v_art.artwork_keyword ak
    ON a.artwork_id = ak.artwork_id
    JOIN v_art.keyword k
    ON ak.keyword_id = k.keyword_id
WHERE k.keyword LIKE 'flower%';

/*
#################################
        !!! QUERY 3 !!!
#################################

List all the artists from the artist table, but only the related artwork from the artwork table.
We need the first name, last name, and artwork title. 
*/

SELECT fname, lname, title
FROM v_art.artist a
    LEFT JOIN artwork awk
    ON a.artist_id = awk.artist_id;

/*
#################################
        !!! QUERY 4 !!!
#################################

List all subscriptions with the magazine name, last name,
first name, and sort alphabetically by magazine name. 
*/

SELECT magazineName, subscriberLastName, subscriberFirstName
FROM magazine.subscription subtion
    JOIN magazine.magazine m
    ON subtion.magazineKey = m.magazineKey
    JOIN magazine.subscriber suber
    ON subtion.subscriberKey = suber.subscriberKey
ORDER BY m.magazineName;

/*
#################################
        !!! QUERY 5 !!!
#################################

List all the magazines that Samantha Sanders subscribes to. 
*/
SELECT magazineName
FROM magazine.subscription subtion
    JOIN magazine.magazine m
    ON subtion.magazineKey = m.magazineKey
    JOIN magazine.subscriber suber
    ON subtion.subscriberKey = suber.subscriberKey
WHERE suber.subscriberLastName = 'Sanders' AND suber.subscriberFirstName = 'Samantha';

/*
#################################
        !!! QUERY 6 !!!
#################################

List the first five employees from the Customer Service Department.
Put them in alphabetical order by last name.
*/

SELECT first_name, last_name, dep.dept_name
FROM employees.employees e
    JOIN employees.dept_emp demp
    ON e.emp_no = demp.emp_no
    JOIN employees.departments dep
    ON demp.dept_no = dep.dept_no
WHERE dep.dept_name = 'Customer Service'
ORDER BY last_name;

/*
#################################
        !!! QUERY 7 !!!
#################################

Find out the current salary and department of Berni Genin.
You can use the ORDER BY and LIMIT to get just the most recent salary.
*/

SELECT first_name, last_name, dep.dept_name, sal.salary, sal.from_date
FROM employees.employees e
    JOIN employees.dept_emp demp
    ON e.emp_no = demp.emp_no
    JOIN employees.departments dep
    ON demp.dept_no = dep.dept_no
    JOIN employees.salaries sal
    ON e.emp_no = sal.emp_no
WHERE first_name = 'Berni' AND last_name = 'Genin'
ORDER BY sal.from_date DESC
LIMIT 1;

/*
#################################
        !!! QUERY 8 !!!
#################################

Get the average quantity that we have in all our bike stocks. Round to the nearest whole number. 
*/

SELECT ROUND(AVG(quantity)) FROM bike.stock;

/*
#################################
        !!! QUERY 9 !!!
#################################

Show each bike that needs to be reordered. Filter the results to only the lowest quantity of zero.
Order by product_name The image below show the first 12 of 24 rows total. You don't need to use a LIMIT.
(Hint for this one: Two different stores have the same bike that needs to be reordered. You only need it to show up once.)
*/

SELECT DISTINCT(product_name)
FROM bike.product p
        JOIN bike.stock s
        ON p.product_id = s.product_id
WHERE s.quantity = 0;

/*
#################################
        !!! QUERY 10 !!!
#################################

How many of each category of bikes do we have in stock (inventory) at our "Baldwin Bikes" store,
which has the store_id of 2. We need to see the name of the category as well as the number of bikes
we have in inventory in the category. Sort by lowest inventory items first. 
*/

SELECT c.category_name, SUM(s.quantity) AS "instock"
FROM bike.product p
        JOIN bike.stock s
        ON p.product_id = s.product_id
        JOIN bike.category c
        ON p.category_id = c.category_id
WHERE
        s.store_id = 2 AND s.quantity > 0
GROUP BY c.category_name;

/*
#################################
        !!! QUERY 11 !!!
#################################

How many employees do we have? (3 points)
*/

SELECT COUNT(emp_no) FROM employees.employees;

/*
#################################
        !!! QUERY 12 !!!
#################################

Get the average salaries in each department.
We only need those departments that have average salaries that are below 60,000.
Format the salary to 2 decimal places and a comma in the thousands place. 
*/

SELECT dep.dept_name, FORMAT(AVG(s.salary), 2) AS "average_salary"
FROM employees.employees e
        JOIN employees.salaries s
        ON e.emp_no = s.emp_no
        JOIN employees.dept_emp demp
        ON e.emp_no = demp.emp_no
        JOIN employees.departments dep
        ON demp.dept_no = dep.dept_no
GROUP BY dep.dept_name
HAVING average_salary < 60000;

/*
#################################
        !!! QUERY 13 !!!
#################################

Find out how many females work in each department. Sort by department name.
*/
SELECT dep.dept_name, COUNT(e.emp_no)
FROM employees.employees e
        JOIN employees.dept_emp demp
        ON e.emp_no = demp.emp_no
        JOIN employees.departments dep
        ON demp.dept_no = dep.dept_no
WHERE e.gender = 'F'
GROUP BY dep.dept_name
ORDER BY dep.dept_name;