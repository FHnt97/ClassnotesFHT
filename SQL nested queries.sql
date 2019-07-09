-- 1. How many sales do we have by store? (count of tickets )--
SELECT stor_name, COUNT(*) AS number_of_tickets
FROM stores AS st
JOIN sales AS sa
ON st.stor_id = sa.stor_id
GROUP BY stor_name
;
-- 2. How many titles are bought by store in total? (count of variety) 
--  *distinct will count ONLY different varieties - joints titles of same name as 1
SELECT stor_name, COUNT(distinct title_id) AS number_of_titles
FROM stores AS st
JOIN sales AS sa
ON st.stor_id = sa.stor_id
GROUP BY stor_name
;
-- 3. How many stores are bought by store -- 
SELECT stor_name, SUM(qty) AS number_of_books
FROM stores AS st
JOIN sales AS sa
ON st.stor_id = sa.stor_id
GROUP BY stor_name;
;
--  TIPP! to see what table you do operations on once you join, make sure to print the table once and then think what to group-- 
SELECT *
FROM stores AS st
JOIN sales AS sa
ON st.stor_id = sa.stor_id
;
-- 4. To make it quicker and cleaner, join all operations is one column --
SELECT stor_name, SUM(qty) AS number_of_books, COUNT(distinct title_id) AS number_of_title, COUNT(*) AS number_of_tickets
FROM stores AS st
JOIN sales AS sa
ON st.stor_id = sa.stor_id
GROUP BY stor_name
;
-- 5. Average items per order -- 
-- AVG = sum of SUM(qty)/sum of COUNT(*) as number_of_tickets
-- two methods: 
-- 			1. new temporary table (if you have priviledges) - through CREATE TEMPORARY TABLE summary_ticket, etc. (repeat 4)
-- 			2. table, nested query - ADD: SELECT (what you need) FROM(previously created table)
SELECT SUM(number_of_books)/SUM(number_of_tickets) AS average_items_per_order
FROM(
SELECT stor_name, SUM(qty) AS number_of_books, COUNT(distinct title_id) AS number_of_title, COUNT(*) AS number_of_tickets
FROM stores AS st
JOIN sales AS sa
ON st.stor_id = sa.stor_id
GROUP BY stor_name
) summary_ticket
-- summary_ticket is the NEW NAME OF THE TABLE!! 
;
-- 6. For average numer of books per store -- 
SELECT stor_name, SUM(qty) AS number_of_books, COUNT(distinct title_id) AS number_of_title, COUNT(*) AS number_of_tickets, SUM(qty)/COUNT(*) AS avg
FROM stores AS st
JOIN sales AS sa
ON st.stor_id = sa.stor_id
GROUP BY stor_name
;