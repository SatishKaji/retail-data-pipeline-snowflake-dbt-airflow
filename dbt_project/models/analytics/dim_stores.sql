SELECT
    store_id,
    store_name,
    store_address,
    store_city,
    store_region
FROM {{ ref('stg_stores') }}