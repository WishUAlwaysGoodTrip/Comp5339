# Import necessary libraries and modules
from datetime import timedelta, datetime
from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.sensors.external_task_sensor import ExternalTaskSensor
from airflow.operators.bash import BashOperator



# Define default arguments for the DAG
default_args = {
  'start_date': days_ago(1),  # Start date for the DAG
  'retries': 1,  # Number of retries
  'retry_delay': timedelta(minutes=5)  # Delay between retries
}

# Define the DAG
with DAG(dag_id='run_dbt_init_tasks', default_args=default_args, schedule_interval='@once', ) as dag:

  # Task to wait for the completion of 'import_main_data' DAG
  wait_for_main = ExternalTaskSensor(
    task_id='wait_for_main',
    external_dag_id='import_main_data',  # External DAG to wait for
    execution_date_fn=lambda x: days_ago(1),  # Execution date function
    timeout=300  # Timeout for the sensor
  )

  # Task to wait for the completion of 'import_reseller_data' DAG
  wait_for_resellers = ExternalTaskSensor(
    task_id='wait_for_resellers',
    external_dag_id='import_reseller_data',  # External DAG to wait for
    execution_date_fn=lambda x: days_ago(1),  # Execution date function
    timeout=300  # Timeout for the sensor
  )

  # Task to pull the most recent version of the dependencies listed in packages.yml from git
  dbt_deps = BashOperator(
    task_id='dbt_deps',
    bash_command='cd /usr/local/airflow/dbt && /usr/local/bin/dbt deps --add-package /usr/local/airflow/dbt-utils-main --source local'
  )


  # Task to seed the database with data defined in dbt seed files
  dbt_seed = BashOperator(
    task_id='dbt_seed',
    bash_command='cd /usr/local/airflow/dbt && /usr/local/bin/dbt seed'
  )

  # Define task dependencies
  wait_for_main >> wait_for_resellers >> dbt_deps >> dbt_seed
