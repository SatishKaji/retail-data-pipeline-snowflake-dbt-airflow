
SELECT
    CAST(order_line_id AS INTEGER) AS order_line_id,
    CAST(order_id AS INTEGER) AS order_id,
    CAST(product_id AS INTEGER) AS product_id,
    CAST(quantity AS INTEGER) AS quantity,
    CAST(REPLACE(REPLACE(unit_price, '$', ''), '€', '') AS DECIMAL(10, 2)) AS unit_price,
    CAST(REPLACE(REPLACE(discount_amount, '$', ''), '€', '') AS DECIMAL(10, 2)) AS discount_amount,
    CAST((CAST(quantity AS INTEGER)* CAST(REPLACE(REPLACE(unit_price, '$', ''), '€', '') AS DECIMAL(10, 2)))AS DECIMAL(10, 2)) AS gross_sales_amount,
    CAST(((CAST(quantity AS INTEGER) * CAST(REPLACE(REPLACE(unit_price, '$', ''), '€', '') AS DECIMAL(10, 2))) - CAST(REPLACE(REPLACE(discount_amount, '$', ''), '€', '') AS DECIMAL(10, 2)))AS DECIMAL(10, 2)) AS net_sales_amount


FROM {{ source('RETAIL_DB', 'order_items') }}