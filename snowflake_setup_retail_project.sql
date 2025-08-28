Create warehouse Retail_ETL
    WITH WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE;



CREATE DATABASE RETAIL_DB; 


USE DATABASE RETAIL_DB;


CREATE SCHEMA RAW_DATA;

CREATE SCHEMA STAGING_DATA;

CREATE SCHEMA ANALYTICS;

CREATE OR REPLACE TABLE RAW_DATA.CUSTOMERS (
    customer_id VARCHAR,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    city VARCHAR,
    state VARCHAR,
    created_at VARCHAR,
    updated_at VARCHAR
);


CREATE OR REPLACE TABLE RAW_DATA.PRODUCTS (
    product_id VARCHAR,
    product_name VARCHAR,
    category VARCHAR,
    brand VARCHAR,
    supplier_name VARCHAR,
    cost_price VARCHAR,
    created_at VARCHAR,
    updated_at VARCHAR
);

CREATE OR REPLACE TABLE RAW_DATA.STORES (
    store_id VARCHAR,
    store_name VARCHAR,
    store_address VARCHAR,
    city VARCHAR,
    region VARCHAR
);


CREATE OR REPLACE TABLE RAW_DATA.ORDERS (
    order_id VARCHAR,
    customer_id VARCHAR,
    store_id VARCHAR,
    order_date VARCHAR,
    shipping_cost VARCHAR,
    is_online_order VARCHAR
);


CREATE OR REPLACE TABLE RAW_DATA.ORDER_ITEMS (
    order_line_id VARCHAR,
    order_id VARCHAR,
    product_id VARCHAR,
    quantity VARCHAR,
    unit_price VARCHAR,
    discount_amount VARCHAR
);


CREATE OR REPLACE FILE FORMAT CSV_FILE_FORMAT
  TYPE = 'CSV'
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = TRUE
  FIELD_OPTIONALLY_ENCLOSED_BY = '"' ;