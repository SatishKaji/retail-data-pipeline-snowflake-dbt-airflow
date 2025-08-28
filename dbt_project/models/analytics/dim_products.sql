SELECT
    product_id,
    product_name,
    product_category,
    product_brand,
    product_cost,
    supplier_name,
    created_at,
    updated_at
FROM {{ ref('stg_products') }}