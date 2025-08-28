SELECT
    CAST(store_id AS INTEGER) AS store_id,
    TRIM(store_name) AS store_name,
    TRIM(store_address) AS store_address,
    TRIM(city) AS store_city,
    CASE
        WHEN region = 'online_region' THEN 'Online'
        ELSE TRIM(region)
    END AS store_region

FROM {{ source('RETAIL_DB', 'stores') }}