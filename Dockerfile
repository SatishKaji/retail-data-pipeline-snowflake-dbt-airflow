FROM apache/airflow:2.9.2

USER airflow
RUN pip install --no-cache-dir dbt-snowflake

EXPOSE 8080
