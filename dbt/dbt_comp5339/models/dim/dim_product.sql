{{
config(
materialized = 'table',
unique_key = 'product_key'
)
}}


select -- fill code here 


FROM {{ref('staging_product')}}
