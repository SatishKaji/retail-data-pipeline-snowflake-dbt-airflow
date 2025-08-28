
SELECT
    CAST(order_id AS INTEGER) AS order_id,
    CAST(customer_id AS INTEGER) AS customer_id,
    CAST(store_id AS INTEGER) AS store_id,
    TO_VARCHAR(
        COALESCE(
            TRY_TO_DATE(order_date, 'YYYY-MM-DD'),
            TRY_TO_DATE(order_date, 'MM-DD-YYYY'),
            TRY_TO_DATE(order_date, 'DD-MM-YYYY'),
            TRY_TO_DATE(order_date, 'DD/MM/YYYY')
        ),
        'DD.MM.YYYY'
    ) AS order_date,

    CAST(REPLACE(REPLACE(shipping_cost, '$', ''), '€', '') AS DECIMAL(10, 2)) AS shipping_cost,

    CASE
        WHEN is_online_order IN ('TRUE', 'true', '1') THEN TRUE
        ELSE FALSE
    END AS is_online_order

FROM {{ source('RETAIL_DB', 'orders') }}