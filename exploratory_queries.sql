DESCRIBE internet_service_types;


SELECT * FROM customers;

-- 1869 customers have churned OUT of a total of 7043 customers
SELECT * 
FROM customers
WHERE churn = 'Yes';

DESCRIBE customers;

-- Breaks down churn OR NOT based ON TYPE of contract
-- this is worth exploring
-- looks like two year contract people stay longer don't churn as much
-- have to calculate proportions to figure out break down

SELECT c.churn AS churn,
ct.`contract_type` AS contract_type,
count(c.customer_id) AS customer_count
FROM customers AS c
JOIN internet_service_types AS it ON it.internet_service_type_id = c.`internet_service_type_id`
JOIN contract_types AS ct ON ct.`contract_type_id` = c.contract_type_id
JOIN payment_types AS pt ON pt.payment_type_id = c.payment_type_id
GROUP BY c.churn, contract_type
ORDER BY contract_type;


-- query FOR churn breakdown BY payment TYPE 
-- don't see a significant difference here

SELECT c.churn AS churn,
pt.`payment_type` AS payment_type,
count(c.customer_id) AS customer_count
FROM customers AS c
JOIN internet_service_types AS it ON it.internet_service_type_id = c.`internet_service_type_id`
JOIN contract_types AS ct ON ct.`contract_type_id` = c.contract_type_id
JOIN payment_types AS pt ON pt.payment_type_id = c.payment_type_id
GROUP BY c.churn, payment_type
ORDER BY customer_count DESC;

-- are they streaming movies? 
-- Looks like there are twice as many month to month customers 
SELECT c.churn AS churn,
c.streaming_movies AS movies,
count(c.customer_id) AS customer_count
FROM customers AS c
JOIN internet_service_types AS it ON it.internet_service_type_id = c.`internet_service_type_id`
JOIN contract_types AS ct ON ct.`contract_type_id` = c.contract_type_id
JOIN payment_types AS pt ON pt.payment_type_id = c.payment_type_id
GROUP BY c.churn, movies
ORDER BY `churn`;

-- contract type and paperless? does paperless have an impact
SELECT c.churn AS churn,
c.paperless_billing AS paperless,
ct.`contract_type` AS contract_type,
COUNT(c.customer_id) AS customer_count
FROM customers AS c
JOIN internet_service_types AS it ON it.internet_service_type_id = c.`internet_service_type_id`
JOIN contract_types AS ct ON ct.`contract_type_id` = c.contract_type_id
JOIN payment_types AS pt ON pt.payment_type_id = c.payment_type_id
GROUP BY c.churn, paperless, contract_type
HAVING contract_type = 'Month-to-month'
ORDER BY paperless, c.churn;

-- monthly charges were higher on average for people who churn 
-- but is it higher proportionally, because 1869 churned and 5174 didn't
-- churn monthly average is $74.44
-- stayed on monthly average is $61.27

SELECT c.churn AS churn,
AVG(c.monthly_charges) AS avg_monthly_charge,
count(*) AS customer_count
FROM customers AS c
GROUP BY churn;

-- average tenure before churn
-- probably not super useful just because obviously people who haven't churned are still there
-- not really a factor

SELECT c.churn AS churn,
AVG(c.tenure) AS avg_tenure
FROM customers AS c
GROUP BY churn;

SELECT AVG(`monthly_charges`)
FROM customers;




