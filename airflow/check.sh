#!/bin/bash

DBT_PACKAGES_DIR="/usr/local/airflow/dbt/dbt_packages"

if [ -d "$DBT_PACKAGES_DIR" ]; then
  echo "Removing $DBT_PACKAGES_DIR..."
  rm -rf "$DBT_PACKAGES_DIR"
  echo "Removed."
else
  echo "$DBT_PACKAGES_DIR does not exist."
fi

DBT_LOGS_DIR="/usr/local/airflow/dbt/logs"

if [ -d "DBT_LOGS_DIR" ]; then
  echo "Removing DBT_LOGS_DIR..."
  rm -rf "DBT_LOGS_DIR"
  echo "Removed."
else
  echo "DBT_LOGS_DIR does not exist."
fi
