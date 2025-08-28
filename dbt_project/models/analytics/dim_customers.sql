SELECT
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_first_name || ' ' || customer_last_name AS customer_full_name,
    customer_email,
    customer_city,
    customer_state,
    created_at,
    updated_at
FROM {{ ref('stg_customers') }}