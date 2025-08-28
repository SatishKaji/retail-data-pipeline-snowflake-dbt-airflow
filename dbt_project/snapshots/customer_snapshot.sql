{% snapshot customer_snapshot %}

{{
    config(
        target_schema='ANALYTICS',
        target_table='CUSTOMER_SNAPSHOT',

        unique_key='customer_id',

        strategy='check',
    
        check_cols=['customer_first_name', 'customer_last_name', 'customer_email', 'customer_city', 'customer_state'],
        


    )
}}

SELECT
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_email,
    customer_city,
    customer_state
FROM {{ ref('stg_customers') }}

{% endsnapshot %}