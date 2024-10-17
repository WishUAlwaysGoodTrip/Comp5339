{{ config(
    materialized = 'table',
    unique_key = ['customer_key', 'product_key', 'channel_key', 'bought_date_key', 'geography_key']
) }}

SELECT
    customer_key,
     -- fill code here 
FROM
    {{ ref('staging_transactions') }}
