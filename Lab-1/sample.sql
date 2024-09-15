--2
\i tableSales.sql
--3
\i dataSales.sql
--4
select CUST_NAME from CUSTOMER WHERE GRADE=2;
--5
SELECT ord_num, ord_date, ord_description FROM orders ORDER BY ord_date ASC;
--6
select ord_num,ord_date,ord_amount from orders where ord_amount>=800 order by ord_amount DESC;
--7
SELECT * FROM customer ORDER BY working_area ASC, cust_name DESC;
--8
SELECT cust_name FROM customer WHERE cust_name LIKE 'S%';
--9
SELECT ord_num FROM orders WHERE EXTRACT(MONTH FROM ord_date) = 3 AND EXTRACT(YEAR FROM ord_date) = 2008;
--10
SELECT ord_num, ord_amount * 1.10 AS new_order_amount FROM orders;
--11
SELECT ord_num, ord_amount - advance_amount AS balance_amount FROM orders WHERE ord_amount BETWEEN 2000 AND 4000;
--12
SELECT o.ord_num, o.cust_code, o.ord_amount FROM orders as o WHERE o.ord_amount IN (SELECT ord_amount FROM orders WHERE cust_code = 'C00022');
--13
SELECT agent_name, agent_code FROM agents WHERE commission > ALL (SELECT commission FROM agents WHERE working_area = 'Bangalore');
--14
SELECT agent_name, agent_code FROM agents WHERE commission > ANY (SELECT commission FROM agents WHERE working_area = 'Bangalore');
--15
select agent_code from agents where agent_code in (select agent_code from orders);
--16
SELECT cust_name FROM customer WHERE cust_code NOT IN (SELECT DISTINCT cust_code FROM orders);
--17
SELECT agent_code FROM orders WHERE ord_amount >= 800;
--18
SELECT DISTINCT agent_name FROM agents WHERE agent_code in (select agent_code from orders where ord_amount >= 800);
--19
select cust_name,cust_code from customer where cust_city='New York' or cust_city='Bangalore' or cust_city='Paris';
--20
SELECT DISTINCT agent_name FROM agents JOIN orders ON agents.agent_code = orders.agent_code WHERE orders.ord_amount = 1000;
--select agent_name from agents where agent_code in (select agent_code from orders where ord_amount=1000);
--21
SELECT COALESCE(SUM(ord_amount), 0) AS total_order_amount, CASE WHEN COUNT(ord_amount) > 0 THEN COALESCE(SUM(ord_amount) / COUNT(ord_amount), 0) ELSE NULL END AS average_order_amount, COALESCE(MIN(ord_amount), 0) AS min_order_amount, COALESCE(MAX(ord_amount), 0) AS max_order_amount FROM orders;
--SELECT SUM(ord_amount) AS total_order_amount, CASE WHEN COUNT(ord_amount) > 0 THEN SUM(ord_amount) / COUNT(ord_amount) ELSE NULL END AS average_order_amount, MIN(ord_amount) AS min_order_amount, MAX(ord_amount) AS max_order_amount FROM orders;
--SELECT SUM(ord_amount) AS total_order_amount,SUM(ord_amount) / COUNT(ord_amount) AS average_order_amount, MIN(ord_amount) AS min_order_amount, MAX(ord_amount) AS max_order_amount FROM orders;
--SELECT SUM(ord_amount),SUM(ord_amount) / COUNT(ord_amount) as avg, MIN(ord_amount), MAX(ord_amount) FROM orders;
--22
select count(*) from customer where cust_city='New York';
--23
select count(distinct(ord_amount)) from orders;
--24
SELECT a.agent_code, a.agent_name FROM agents a JOIN orders o ON a.agent_code = o.agent_code GROUP BY a.agent_code, a.agent_name HAVING COUNT(o.ord_num) >= 2;
--25
SELECT working_area, COUNT(distinct(agent_code)) AS agent_count FROM agents GROUP BY working_area;
--26
SELECT DISTINCT a.agent_name, a.working_area FROM agents a JOIN orders o ON a.agent_code = o.agent_code GROUP BY a.agent_name, a.working_area HAVING COUNT(o.ord_num) >= 2;
--27
SELECT agent_code, AVG(ord_amount) AS average_order_amount FROM orders GROUP BY agent_code;
--29
ALTER TABLE customer ADD COLUMN Address VARCHAR(50) DEFAULT NULL;
UPDATE customer SET Address = 'New Address Value' WHERE cust_code = 'C00013';
--30
ALTER TABLE agents DROP COLUMN Country;
--31
DELETE FROM orders;
--28
DELETE FROM customer WHERE agent_code=ANY(SELECT agent_code FROM agents WHERE working_area='Bangalore');
DELETE FROM agents WHERE working_area = 'Bangalore';
--32
DROP TABLE customer CASCADE;