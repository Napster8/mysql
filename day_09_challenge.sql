-- drop TABLE if exists 09_orders;
-- CREATE TABLE 09_orders 
-- (
-- 	customer_id 	INT,
-- 	dates 			DATE,
-- 	product_id 		INT
-- );
-- INSERT INTO 09_orders VALUES
-- (1, '2024-02-18', 101),
-- (1, '2024-02-18', 102),
-- (1, '2024-02-19', 101),
-- (1, '2024-02-19', 103),
-- (2, '2024-02-18', 104),
-- (2, '2024-02-18', 105),
-- (2, '2024-02-19', 101),
-- (2, '2024-02-19', 106); 

-- SQL Query to merge products per customer, per day using comma seperated values

    -- Sample Output:
    -- 18-02-2024	101
    -- 18-02-2024	101,102
    -- 18-02-2024	102
    -- 18-02-2024	104
    -- 18-02-2024	104,105
    -- 18-02-2024	105
    -- 19-02-2024	101
    -- 19-02-2024	101,103
    -- 19-02-2024	101,106
    -- 19-02-2024	103
    -- 19-02-2024	106

(
    SELECT customer_id, dates, 
            GROUP_CONCAT (product_id ORDER BY customer_id asc, dates asc, product_id asc) as products 
    FROM 09_orders
    GROUP BY customer_id, dates
    ORDER BY customer_id, dates
)

union all

(
    SELECT customer_id, dates, product_id as products
    FROM 09_orders
    ORDER BY customer_id, dates
)
ORDER BY customer_id, dates
