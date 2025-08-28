SELECT
    CAST(customer_id AS INTEGER) AS customer_id,
    TRIM(first_name) AS customer_first_name,
    TRIM(last_name) AS customer_last_name,
    TRIM(email) AS customer_email,
    TRIM(city) AS customer_city,
    TRIM(state) AS customer_state,
    CAST(created_at AS TIMESTAMP) AS created_at,
    CAST(updated_at AS TIMESTAMP) AS updated_at
FROM {{ source('RETAIL_DB', 'customers') }}