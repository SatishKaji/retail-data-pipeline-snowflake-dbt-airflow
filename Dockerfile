FROM apache/airflow:2.9.2
USER root
RUN apt-get update && apt-get install -y git


USER airflow
RUN pip install --no-cache-dir dbt-snowflake

EXPOSE 8080
