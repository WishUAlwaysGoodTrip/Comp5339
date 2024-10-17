{{ config(
      materialized = 'table',
      unique_key = 'geographykey'
) }}

SELECT
       -- fill code here 
FROM
      {{ ref('geography') }}
