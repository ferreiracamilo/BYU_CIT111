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