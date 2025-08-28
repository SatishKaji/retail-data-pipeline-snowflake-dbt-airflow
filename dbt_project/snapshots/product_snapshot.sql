{% snapshot product_snapshot %}

{{
    config(
        target_schema='ANALYTICS',
        target_table='PRODUCT_SNAPSHOT',

        unique_key='product_id',

        strategy='check',
        
        check_cols=['product_name', 'product_category', 'product_brand', 'product_cost', 'supplier_name'],


    )
}}

SELECT
    product_id,
    product_name,
    product_category,
    product_brand,
    product_cost,
    supplier_name
FROM {{ ref('stg_products') }}

{% endsnapshot %}