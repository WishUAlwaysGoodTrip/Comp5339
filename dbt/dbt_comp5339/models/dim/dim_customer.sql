{{
config(
materialized = 'table',
unique_key = 'customer_key'
)
}}

select  -- fill code here 
from {{ref('staging_customers')}}