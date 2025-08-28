
# Retail Data Transformation Pipeline

This project is a modern data stack pipeline designed to transform raw retail data into a clean, query-ready star schema. It leverages **dbt (data build tool)** for all data transformations and is orchestrated using **Airflow**.

## Architecture

The pipeline follows a layered architecture, moving data from raw sources to a final, analytical data mart.

- **Raw Data**: Unprocessed data files (.csv) are loaded directly into Snowflake.
- **Staging Layer**: Raw data is cleaned, standardized, and cast to the correct data types.
- **Analytics Layer**: Cleaned data is transformed into a star schema with dimension and fact tables, optimized for business intelligence and reporting.

## Technologies Used

- **dbt (data build tool)**: Used for all SQL-based data transformations.
- **Snowflake**: The cloud data warehouse where all data is stored and transformations are executed.
- **Airflow**: Used for orchestrating and scheduling the entire data pipeline.
- **Docker**: Used for containerizing the dbt project and Airflow, ensuring a consistent and portable environment.

## Setup and Installation

### Prerequisites

- A Snowflake account with the necessary permissions.
- dbt Core installed locally.
- Airflow installed (either locally or on a server).
- Docker installed.

### Snowflake Setup

Before running this project, set up the required Snowflake objects. Use the `snowflake_setup_retail_project.sql` script to create the necessary warehouse, database, and schemas.

Navigate to the Snowflake UI and run the commands from `snowflake_setup_retail_project.sql` to create the `RETAIL_DB`, `RETAIL_ETL_WH`, and three schemas (`RAW_DATA`, `STAGING_DATA`, `ANALYTICS`).

### dbt Configuration

Clone this repository:
```

git clone [your-repo-url]
cd [your-project-directory]

```

Configure your Snowflake connection in your `~/.dbt/profiles.yml` file.

```


# ~/.dbt/profiles.yml

retail_project:
target: dev
outputs:
dev:
type: snowflake
account: [your-snowflake-account]
user: [your-snowflake-user]
password: [your-snowflake-password]
role: [your-snowflake-role]
database: [your-snowflake-database]
warehouse: [your-snowflake-warehouse]
schema: [your-snowflake-schema]
threads: 4

```

## Project Structure

The project follows a standard dbt structure:

```

.
├── models/
│   ├── staging/
│   └── analytics/
│
├── snapshots/
│
├── .gitignore
│
└── dbt_project.yml

```

- **models/**: Contains all SQL files for transformations.
  - **staging/**: Models that clean and standardize raw data.
  - **analytics/**: Final tables that build the star schema.
- **snapshots/**: Contains snapshot models to track changes in dimension tables.

## Data Transformations

### Staging Models

These models are the first layer of transformation, directly referencing raw data sources.

- `stg_customers.sql`: Cleans customer data.
- `stg_products.sql`: Cleans product data, removes currency symbols from `cost_price`, and removes extraneous characters from `product_name`.
- `stg_stores.sql`: Standardizes the store data.
- `stg_orders.sql`: Parses and standardizes different `order_date` formats and cleans `shipping_cost`.
- `stg_order_items.sql`: Standardizes and cleans numeric fields like `quantity`, `unit_price`, and `discount_amount`.

### Analytics Models

These models build our final star schema.

- `dim_customers.sql`: Creates a clean customer dimension table from `stg_customers`.
- `dim_products.sql`: Creates the final product dimension table from `stg_products`.
- `dim_stores.sql`: Creates the store dimension table from `stg_stores`.
- `dim_dates.sql`: A generated model that creates a `dim_dates` table with a row for every day between 2024 and 2025.
- `fact_sales.sql`: The central fact table. It joins `stg_orders` and `stg_order_items` and includes foreign keys to all dimension tables.

## Data Quality & Testing

This project uses dbt's built-in testing framework to ensure data quality. Schema tests are defined in `schema.yml` files within the `staging/` and `analytics/` folders.

- **unique**: Ensures no duplicate values in a column.
- **not_null**: Ensures no missing values.
- **relationships**: Validates that foreign key relationships between models are sound.

## Data Snapshots

We use dbt snapshot to track historical changes in our customer data. The `customer_snapshot.sql` model creates a new row in a snapshot table every time a customer's details (e.g., email, city) are changed in the source data.

## Orchestration

This dbt project is designed to be orchestrated by an external tool like Airflow. A typical Airflow DAG (`retail_dbt_dag.py`) would look something like this:

- **Extract**: A task to load the raw data files into the Snowflake RAW_DATA schema.
- **dbt Run**: A task to run the entire dbt project (`dbt run`).
- **dbt Test**: A task to run all tests (`dbt test`) to ensure data integrity.
- **dbt Snapshot**: A task to run the snapshots (`dbt snapshot`).



