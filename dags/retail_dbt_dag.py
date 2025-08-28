
import pendulum
from airflow import DAG
from airflow.operators.bash import BashOperator
from pendulum import datetime




with DAG(
    dag_id='dbt_snowflake_etl',
    description='A DAG to run dbt models on Snowflake',
    schedule=None, 
    start_date = pendulum.datetime(2024, 1, 1, tz="Europe/Berlin"),
    catchup=False,
    tags=['dbt', 'snowflake', 'etl'],
) as dag:
    


    dbt_deps_task = BashOperator(
        task_id="dbt_deps",
        bash_command="dbt deps",
        cwd="/opt/airflow/dbt_project",
    )


    dbt_test_task = BashOperator(
        task_id="dbt_test",
        bash_command="dbt test",
        cwd="/opt/airflow/dbt_project",
    )


    dbt_seed_task = BashOperator(
        task_id="dbt_seed",
        bash_command="dbt seed --full-refresh",
        cwd="/opt/airflow/dbt_project",
    )


    dbt_snapshot_task = BashOperator(
        task_id='dbt_snapshot',
        bash_command='dbt snapshot',
        cwd='/opt/airflow/dbt_project',
    )

    dbt_run_staging = BashOperator(
        task_id="dbt_run_staging",
        bash_command="dbt run --models models/staging",
        cwd="/opt/airflow/dbt_project",
    )

 
    dbt_run_analytics = BashOperator(
        task_id="dbt_run_analytics",
        bash_command="dbt run --models models/analytics",
        cwd="/opt/airflow/dbt_project",
    )


    dbt_deps_task >> dbt_seed_task >> dbt_snapshot_task >> dbt_run_staging >> dbt_run_analytics >> dbt_test_task

