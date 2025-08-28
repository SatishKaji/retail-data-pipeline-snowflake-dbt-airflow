SELECT
    CAST(product_id AS INTEGER) AS product_id,
    TRIM(REGEXP_REPLACE(product_name, '[0-9]+', '')) AS product_name,
    TRIM(category) AS product_category,
    TRIM(brand) AS product_brand,
    CAST(REPLACE(REPLACE(cost_price, '$', ''), '€', '') AS DECIMAL(10, 2)) AS product_cost,
    TRIM(supplier_name) AS supplier_name,
    CAST(created_at AS TIMESTAMP) AS created_at,
    CAST(updated_at AS TIMESTAMP) AS updated_at

FROM {{ source('RETAIL_DB', 'products') }}