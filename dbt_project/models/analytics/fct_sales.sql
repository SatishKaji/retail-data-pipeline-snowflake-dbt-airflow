SELECT
    order_items.order_line_id,
    orders.order_id,
    orders.customer_id,
    orders.store_id,
    order_items.product_id,
    CAST(REPLACE(orders.order_date, '.', '') AS INTEGER) AS date_key,
    order_items.quantity,
    order_items.unit_price,
    order_items.discount_amount,
    orders.shipping_cost,
    order_items.gross_sales_amount,
    order_items.net_sales_amount
FROM {{ ref('stg_orders') }} AS orders
LEFT JOIN {{ ref('stg_order_items') }} AS order_items
    ON orders.order_id = order_items.order_id