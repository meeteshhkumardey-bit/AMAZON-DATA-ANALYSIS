
SELECT *
FROM "amazon_brazil"."customers"
LIMIT 10;

SELECT COUNT(*)
FROM amazon_brazil.customers;

SELECT COUNT(*)
FROM amazon_brazil.sellers;

SELECT COUNT(*)
FROM amazon_brazil.products;

SELECT COUNT(*)
FROM amazon_brazil.orders;

SELECT *
FROM amazon_brazil.orders
LIMIT 10;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'amazon_brazil'
  AND table_name = 'orders'
ORDER BY ordinal_position;

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM amazon_brazil.orders;

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'amazon_brazil'
  AND table_name = 'orders'
ORDER BY ordinal_position;

SELECT
    COUNT(*) AS total_orders,
    COUNT(order_id) AS order_id_present,
    COUNT(customer_id) AS customer_id_present,
    COUNT(order_status) AS order_status_present,
    COUNT(order_purchase_timestamp) AS purchase_date_present,
    COUNT(order_approval_at) AS approval_date_present,
    COUNT(order_delivered_carrier_date) AS carrier_date_present,
    COUNT(order_delivered_customer_date) AS delivered_date_present,
    COUNT(oder_estimated_delivery_date) AS estimated_date_present
FROM amazon_brazil.orders;

SELECT
    order_status,
    COUNT(*) AS order_count
FROM amazon_brazil.orders
GROUP BY order_status
ORDER BY order_count DESC;

SELECT
    order_status,
    COUNT(*) AS total_orders,
    COUNT(order_delivered_carrier_date) AS carrier_date_present,
    COUNT(order_delivered_customer_date) AS customer_date_present
FROM amazon_brazil.orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_status = 'delivered') AS delivered_orders,
    COUNT(*) FILTER (WHERE order_status = 'canceled') AS canceled_orders,
    ROUND(
        COUNT(*) FILTER (WHERE order_status = 'delivered') * 100.0
        / COUNT(*), 2
    ) AS delivery_rate,
    ROUND(
        COUNT(*) FILTER (WHERE order_status = 'canceled') * 100.0
        / COUNT(*), 2
    ) AS cancellation_rate
FROM amazon_brazil.orders;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'amazon_brazil'
ORDER BY table_name;

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'amazon_brazil'
  AND table_name = 'products'
ORDER BY ordinal_position;

SELECT
    product_category_name,
    COUNT(*) AS product_count
FROM amazon_brazil.products
GROUP BY product_category_name
ORDER BY product_count DESC
LIMIT 15;

SELECT
    COUNT(*) AS total_products,
    COUNT(product_category_name) AS categorized_products,
    COUNT(*) - COUNT(product_category_name) AS uncategorized_products
FROM amazon_brazil.products;

SELECT
    product_id,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g
FROM amazon_brazil.products
WHERE product_category_name IS NULL
LIMIT 20;

SELECT
    COUNT(*) AS uncategorized_products,

    COUNT(product_name_length) AS name_present,
    COUNT(product_description_length) AS description_present,
    COUNT(product_photos_qty) AS photos_present,
    COUNT(product_weight_g) AS weight_present

FROM amazon_brazil.products
WHERE product_category_name IS NULL;

SELECT
    COUNT(*) AS total_products,
    COUNT(*) - COUNT(product_category_name) AS missing_category,
    ROUND(
        (COUNT(*) - COUNT(product_category_name)) * 100.0 / COUNT(*),
        2
    ) AS missing_category_pct,

    COUNT(*) - COUNT(product_name_length) AS missing_name_length,
    COUNT(*) - COUNT(product_description_length) AS missing_description_length,
    COUNT(*) - COUNT(product_photos_qty) AS missing_photos,
    COUNT(*) - COUNT(product_weight_g) AS missing_weight

FROM amazon_brazil.products;

SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_id) AS unique_product_ids,
    COUNT(*) - COUNT(DISTINCT product_id) AS duplicate_product_ids
FROM amazon_brazil.products;

SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_id) AS unique_product_ids,
    COUNT(*) - COUNT(DISTINCT product_id) AS duplicate_product_ids
FROM amazon_brazil.products;

SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customer_id) AS unique_customer_ids,
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_customer_ids
FROM amazon_brazil.customers;

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_order_ids
FROM amazon_brazil.orders;

SELECT
    COUNT(*) AS total_sellers,
    COUNT(DISTINCT seller_id) AS unique_seller_ids,
    COUNT(*) - COUNT(DISTINCT seller_id) AS duplicate_seller_ids
FROM amazon_brazil.sellers;

--NULL/Completeness analysis
SELECT
    'orders' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id_present,
    COUNT(customer_id) AS customer_id_present,
    COUNT(order_status) AS status_present,
    COUNT(order_purchase_timestamp) AS purchase_date_present,
    COUNT(order_approval_at) AS approval_date_present,
    COUNT(order_delivered_carrier_date) AS carrier_date_present,
    COUNT(order_delivered_customer_date) AS customer_date_present,
    COUNT(oder_estimated_delivery_date) AS estimated_date_present
FROM amazon_brazil.orders;

--Missing percentage calculation
SELECT
    COUNT(*) AS total_orders,

    COUNT(*) - COUNT(order_approval_at)
        AS missing_approval_date,

    ROUND(
        (COUNT(*) - COUNT(order_approval_at)) * 100.0 / COUNT(*),
        2
    ) AS missing_approval_pct,

    COUNT(*) - COUNT(order_delivered_carrier_date)
        AS missing_carrier_date,

    ROUND(
        (COUNT(*) - COUNT(order_delivered_carrier_date)) * 100.0 / COUNT(*),
        2
    ) AS missing_carrier_pct,

    COUNT(*) - COUNT(order_delivered_customer_date)
        AS missing_customer_date,

    ROUND(
        (COUNT(*) - COUNT(order_delivered_customer_date)) * 100.0 / COUNT(*),
        2
    ) AS missing_customer_pct

FROM amazon_brazil.orders;

--Product completeness
SELECT
    COUNT(*) AS total_products,
    COUNT(product_category_name) AS category_present,
    COUNT(product_name_length) AS name_length_present,
    COUNT(product_description_length) AS description_length_present,
    COUNT(product_photos_qty) AS photos_present,
    COUNT(product_weight_g) AS weight_present,
    COUNT(product_length_cm) AS length_present,
    COUNT(product_height_cm) AS height_present,
    COUNT(product_width_cm) AS width_present
FROM amazon_brazil.products;

--Any duplicate!
SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_id) AS unique_product_ids,
    COUNT(*) - COUNT(DISTINCT product_id) AS duplicate_product_ids
FROM amazon_brazil.products;

--check Customer table
SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customer_id) AS unique_customer_ids,
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_customer_ids
FROM amazon_brazil.customers;

--customer completeness
SELECT
    COUNT(*) AS total_customers,
    COUNT(customer_id) AS customer_id_present,
    COUNT(customer_unique_id) AS unique_id_present,
    COUNT(customer_zip_code_prefix) AS zip_code_present
FROM amazon_brazil.customers;

--Order table
SELECT
    COUNT(*) AS total_orders,
    COUNT(order_id) AS order_id_present,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_order_ids,

    COUNT(customer_id) AS customer_id_present,
    COUNT(order_status) AS status_present,
    COUNT(order_purchase_timestamp) AS purchase_date_present,
    COUNT(order_approval_at) AS approval_date_present,
    COUNT(order_delivered_carrier_date) AS carrier_date_present,
    COUNT(order_delivered_customer_date) AS customer_date_present,
    COUNT(oder_estimated_delivery_date) AS estimated_delivery_date_present

FROM amazon_brazil.orders;

SELECT
    COUNT(*) AS total_orders,

    COUNT(*) - COUNT(order_approval_at) AS missing_approval_date,

    COUNT(*) - COUNT(order_delivered_carrier_date) AS missing_carrier_date,

    COUNT(*) - COUNT(order_delivered_customer_date) AS missing_customer_date

FROM amazon_brazil.orders;


-- Business Question 1:
-- What is the overall order volume and customer reach?
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM amazon_brazil.orders;

-- Business Question 2:
-- How many customers are repeat customers?
SELECT
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN order_count = 1 THEN 1 END) AS one_time_customers,
    COUNT(CASE WHEN order_count > 1 THEN 1 END) AS repeat_customers
FROM (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM amazon_brazil.orders
    GROUP BY customer_id
) customer_orders;

-- Business Question 3:
-- Check revenue-related columns
SELECT
    COUNT(*) AS total_delivered_orders,

    COUNT(
        CASE
            WHEN order_delivered_customer_date > oder_estimated_delivery_date
            THEN 1
        END
    ) AS late_orders,

    COUNT(
        CASE
            WHEN order_delivered_customer_date <= oder_estimated_delivery_date
            THEN 1
        END
    ) AS on_time_orders

FROM amazon_brazil.orders
WHERE order_delivered_customer_date IS NOT NULL
  AND oder_estimated_delivery_date IS NOT NULL;

-- Business Question 4:
-- What is the distribution of orders across different
-- order statuses, and which order status has the highest
-- number of orders?
SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM amazon_brazil.orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Business Question 5:
-- What is the average time taken to deliver an order
-- from the purchase date to the customer's delivery date?
SELECT
    COUNT(*) AS delivered_orders,
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    - order_purchase_timestamp
                )
            ) / 86400
        ), 2
    ) AS average_delivery_days
FROM amazon_brazil.orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL;

-- Business Question 6:
-- How many days does it take to deliver orders on average,
-- and how many orders take more than 15 days to deliver?
SELECT
    COUNT(*) AS delivered_orders,

    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    - order_purchase_timestamp
                )
            ) / 86400
        ), 2
    ) AS average_delivery_days,

    COUNT(
        CASE
            WHEN order_delivered_customer_date
                 - order_purchase_timestamp > INTERVAL '15 days'
            THEN 1
        END
    ) AS orders_over_15_days

FROM amazon_brazil.orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL;

-- Business Question 7:
-- How many orders does each customer place,
-- and what proportion of customers are repeat customers?
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM amazon_brazil.orders
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN order_count = 1 THEN 1 END) AS one_time_customers,
    COUNT(CASE WHEN order_count > 1 THEN 1 END) AS repeat_customers,
    ROUND(
        COUNT(CASE WHEN order_count > 1 THEN 1 END) * 100.0
        / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM customer_orders;

-- Business Question 8:
-- Which order statuses have the highest cancellation,
-- and what percentage of total orders does each status represent?
SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_orders
FROM amazon_brazil.orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Business Question 9:
-- What is the average delivery time for delivered orders,
-- and how many orders took more than 15 days to deliver?
SELECT
    COUNT(*) AS delivered_orders,

    ROUND(
        AVG(
            EXTRACT(EPOCH FROM
                (order_delivered_customer_date - order_purchase_timestamp)
            ) / 86400
        ),
        2
    ) AS average_delivery_days,

    COUNT(
        CASE
            WHEN order_delivered_customer_date - order_purchase_timestamp
                 > INTERVAL '15 days'
            THEN 1
        END
    ) AS orders_over_15_days

FROM amazon_brazil.orders

WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL;

-- Business Question 10:
-- Which order status has the highest average delivery time,
-- and how does it compare with other statuses?
SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM
                (order_delivered_customer_date - order_purchase_timestamp)
            ) / 86400
        ),
        2
    ) AS average_delivery_days
FROM amazon_brazil.orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL
GROUP BY order_status
ORDER BY average_delivery_days DESC;

-- Business Question 11:
-- Which customers have placed the highest number of orders?
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM amazon_brazil.orders
GROUP BY customer_id
ORDER BY order_count DESC
LIMIT 10;



------------------------ANALYSIS-->1----------------------------

-- Q1: Top 3 months with the highest total sales value

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(SUM(oi.price)) AS total_sales
FROM amazon_brazil.orders o
JOIN amazon_brazil.order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY total_sales DESC
LIMIT 3;

-- Q2: Find categories where price difference is greater than 500 BRL

SELECT
    p.product_category_name,
    ROUND(MAX(oi.price) - MIN(oi.price), 2) AS price_difference
FROM amazon_brazil.products p
JOIN amazon_brazil.order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
HAVING MAX(oi.price) - MIN(oi.price) > 500
ORDER BY price_difference DESC;

-- Q3: Find products priced between 100 and 500 BRL
-- with "Smart" in the product category name

SELECT DISTINCT
    p.product_id,
    oi.price
FROM amazon_brazil.products p
JOIN amazon_brazil.order_items oi
    ON p.product_id = oi.product_id
WHERE oi.price BETWEEN 100 AND 500
  AND p.product_category_name ILIKE '%smart%'
ORDER BY oi.price DESC;

-- Q4: To identify seasonal sales patterns, Amazon India needs to
-- focus on the most successful months.
-- Determine the top 3 months with the highest total sales value,
-- rounded to the nearest integer.
SELECT
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    ROUND(SUM(oi.price)) AS total_sales
FROM amazon_brazil.orders o
JOIN amazon_brazil.order_items oi
    ON o.order_id = oi.order_id
GROUP BY EXTRACT(MONTH FROM o.order_purchase_timestamp)
ORDER BY total_sales DESC
LIMIT 3;

-- Q5: Amazon India is interested in product categories with
-- significant price variations.
-- Find categories where the difference between the maximum and
-- minimum product prices is greater than 500 BRL.
SELECT
    p.product_category_name,
    MAX(oi.price) - MIN(oi.price) AS price_difference
FROM amazon_brazil.products p
JOIN amazon_brazil.order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
HAVING MAX(oi.price) - MIN(oi.price) > 500
ORDER BY price_difference DESC;

-- Q6: To enhance the customer experience, Amazon India wants to find
-- which payment types have the most consistent transaction amounts.
-- Identify the payment types with the least variance in transaction amounts,
-- sorting by the smallest standard deviation first.
SELECT
    payment_type,
    ROUND(STDDEV(payment_value), 2) AS std_deviation
FROM amazon_brazil.order_payments
GROUP BY payment_type
ORDER BY std_deviation ASC;

-- Q7: Amazon India wants to identify products that may have incomplete
-- names in order to fix them.
-- Retrieve products where the product category name is missing
-- or contains only a single character.
SELECT
    product_id,
    product_category_name
FROM amazon_brazil.products
WHERE product_category_name IS NULL
   OR LENGTH(TRIM(product_category_name)) = 1;



------------------------ANALYSIS-->2----------------------------
-- Q1: Amazon India wants to understand which payment types are most
-- popular across different order value segments.
-- Segment orders into:
-- Low: less than 200 BRL
-- Medium: between 200 and 1000 BRL
-- High: over 1000 BRL
-- Calculate the count of each payment type within these segments.
WITH order_values AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_order_value
    FROM amazon_brazil.order_payments
    GROUP BY order_id
)
SELECT
    CASE
        WHEN ov.total_order_value < 200 THEN 'Low'
        WHEN ov.total_order_value BETWEEN 200 AND 1000 THEN 'Medium'
        ELSE 'High'
    END AS order_value_segment,
    op.payment_type,
    COUNT(*) AS count
FROM order_values ov
JOIN amazon_brazil.order_payments op
    ON ov.order_id = op.order_id
GROUP BY
    order_value_segment,
    op.payment_type
ORDER BY count DESC;

-- Q2: Amazon India wants to analyse the price range and average price
-- for each product category.
-- Calculate the minimum, maximum, and average price for each category,
-- and list them in descending order by the average price.
SELECT
    p.product_category_name,
    MIN(oi.price) AS min_price,
    MAX(oi.price) AS max_price,
    ROUND(AVG(oi.price), 2) AS avg_price
FROM amazon_brazil.products p
JOIN amazon_brazil.order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY avg_price DESC;

-- Q3: Amazon India wants to identify customers who have placed
-- multiple orders over time.
-- Find customers with more than one order and display their
-- customer unique IDs along with the total number of orders.
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM amazon_brazil.customers c
JOIN amazon_brazil.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_orders DESC;

-- Q4: Amazon India wants to categorize customers based on their
-- purchase history using a temporary table.
--
-- New: 1 order
-- Returning: 2 to 4 orders
-- Loyal: More than 4 orders
DROP TABLE IF EXISTS customer_order_counts;

CREATE TEMP TABLE customer_order_counts AS
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM amazon_brazil.customers c
JOIN amazon_brazil.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id;

SELECT
    c.customer_unique_id,
    CASE
        WHEN t.total_orders = 1 THEN 'New'
        WHEN t.total_orders BETWEEN 2 AND 4 THEN 'Returning'
        WHEN t.total_orders > 4 THEN 'Loyal'
    END AS customer_type
FROM amazon_brazil.customers c
JOIN customer_order_counts t
    ON c.customer_unique_id = t.customer_unique_id
ORDER BY c.customer_unique_id;

-- Q5: Amazon India wants to know which product categories
-- generate the most revenue.
-- Use joins between the tables to calculate the total revenue
-- for each product category and display the top 5 categories.
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM amazon_brazil.products p
JOIN amazon_brazil.order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 5;



------------------------ANALYSIS-->3----------------------------
-- Q1: The marketing team wants to compare the total sales
-- between different seasons.
-- Use a subquery to calculate total sales for Spring, Summer,
-- Autumn, and Winter based on order purchase dates.
--
-- Spring: March, April, May
-- Summer: June, July, August
-- Autumn: September, October, November
-- Winter: December, January, February
SELECT
    season,
    ROUND(SUM(sales), 2) AS total_sales
FROM (
    SELECT
        CASE
            WHEN EXTRACT(MONTH FROM o.order_purchase_timestamp)
                 IN (3, 4, 5) THEN 'Spring'
            WHEN EXTRACT(MONTH FROM o.order_purchase_timestamp)
                 IN (6, 7, 8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM o.order_purchase_timestamp)
                 IN (9, 10, 11) THEN 'Autumn'
            ELSE 'Winter'
        END AS season,
        oi.price AS sales
    FROM amazon_brazil.orders o
    JOIN amazon_brazil.order_items oi
        ON o.order_id = oi.order_id
) AS seasonal_sales
GROUP BY season
ORDER BY total_sales DESC;

-- Q2: The inventory team wants to identify products that have
-- sales volumes above the overall average.
-- Use a subquery to filter products where the total quantity sold
-- is greater than the average quantity sold across all products.
SELECT
    product_id,
    total_quantity_sold
FROM (
    SELECT
        product_id,
        COUNT(*) AS total_quantity_sold
    FROM amazon_brazil.order_items
    GROUP BY product_id
) AS product_sales
WHERE total_quantity_sold > (
    SELECT AVG(total_quantity_sold)
    FROM (
        SELECT
            product_id,
            COUNT(*) AS total_quantity_sold
        FROM amazon_brazil.order_items
        GROUP BY product_id
    ) AS average_sales
)
ORDER BY total_quantity_sold DESC;

-- Q3: To understand seasonal sales patterns, the finance team is
-- analysing the monthly revenue trends for the year 2018.
-- Calculate the total revenue generated each month.
SELECT
    TO_CHAR(
        DATE_TRUNC('month', o.order_purchase_timestamp),
        'YYYY-MM'
    ) AS month,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM amazon_brazil.orders o
JOIN amazon_brazil.order_items oi
    ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY DATE_TRUNC('month', o.order_purchase_timestamp);

-- Q4: A loyalty program is being designed for Amazon India.
-- Create customer segments based on purchase frequency using a CTE.
--
-- Occasional: 1 to 2 orders
-- Regular: 3 to 5 orders
-- Loyal: More than 5 orders
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM amazon_brazil.customers c
    JOIN amazon_brazil.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),
customer_segments AS (
    SELECT
        customer_unique_id,
        CASE
            WHEN total_orders BETWEEN 1 AND 2 THEN 'Occasional'
            WHEN total_orders BETWEEN 3 AND 5 THEN 'Regular'
            WHEN total_orders > 5 THEN 'Loyal'
        END AS customer_type
    FROM customer_orders
)
SELECT
    customer_type,
    COUNT(*) AS count
FROM customer_segments
GROUP BY customer_type
ORDER BY count DESC;

-- Q5: Amazon wants to identify high-value customers for an
-- exclusive rewards program.
-- Calculate the average order value for each customer,
-- rank customers from highest to lowest, and display the top 20.

WITH customer_order_values AS (
    SELECT
        o.customer_id,
        o.order_id,
        SUM(op.payment_value) AS order_value
    FROM amazon_brazil.orders o
    JOIN amazon_brazil.order_payments op
        ON o.order_id = op.order_id
    GROUP BY
        o.customer_id,
        o.order_id
),
customer_avg AS (
    SELECT
        customer_id,
        AVG(order_value) AS avg_order_value
    FROM customer_order_values
    GROUP BY customer_id
)
SELECT
    customer_id,
    ROUND(avg_order_value, 2) AS avg_order_value,
    RANK() OVER (
        ORDER BY avg_order_value DESC
    ) AS customer_rank
FROM customer_avg
ORDER BY customer_rank
LIMIT 20;

-- Q6: Amazon wants to analyze sales growth trends for its key products
-- over their lifecycle.
-- Calculate monthly cumulative sales for each product from the date
-- of its first sale using a recursive CTE.
WITH RECURSIVE monthly_sales AS (
    SELECT
        oi.product_id,
        DATE_TRUNC('month', o.order_purchase_timestamp)::date AS sale_month,
        SUM(oi.price) AS monthly_sales
    FROM amazon_brazil.orders o
    JOIN amazon_brazil.order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        oi.product_id,
        DATE_TRUNC('month', o.order_purchase_timestamp)::date
),
sales_with_sequence AS (
    SELECT
        product_id,
        sale_month,
        monthly_sales,
        ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY sale_month
        ) AS month_num
    FROM monthly_sales
),
cumulative_sales AS (
    SELECT
        product_id,
        sale_month,
        monthly_sales AS total_sales,
        month_num
    FROM sales_with_sequence
    WHERE month_num = 1

    UNION ALL

    SELECT
        s.product_id,
        s.sale_month,
        c.total_sales + s.monthly_sales AS total_sales,
        s.month_num
    FROM cumulative_sales c
    JOIN sales_with_sequence s
        ON c.product_id = s.product_id
        AND s.month_num = c.month_num + 1
)

SELECT
    product_id,
    sale_month,
    ROUND(total_sales, 2) AS total_sales
FROM cumulative_sales
ORDER BY product_id, sale_month;

-- Q7: To understand how different payment methods affect monthly
-- sales growth, calculate the total monthly sales for each payment
-- method and the percentage change from the previous month for 2018.
WITH monthly_sales AS (
    SELECT
        op.payment_type,
        DATE_TRUNC(
            'month',
            o.order_purchase_timestamp
        )::date AS sale_month,
        SUM(op.payment_value) AS monthly_total
    FROM amazon_brazil.orders o
    JOIN amazon_brazil.order_payments op
        ON o.order_id = op.order_id
    WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
    GROUP BY
        op.payment_type,
        DATE_TRUNC('month', o.order_purchase_timestamp)::date
),
sales_with_previous AS (
    SELECT
        payment_type,
        sale_month,
        monthly_total,
        LAG(monthly_total) OVER (
            PARTITION BY payment_type
            ORDER BY sale_month
        ) AS previous_month_total
    FROM monthly_sales
)
SELECT
    payment_type,
    sale_month,
    ROUND(monthly_total, 2) AS monthly_total,
    ROUND(
        (
            (monthly_total - previous_month_total)
            / NULLIF(previous_month_total, 0)
        ) * 100,
        2
    ) AS monthly_change
FROM sales_with_previous
ORDER BY payment_type, sale_month;