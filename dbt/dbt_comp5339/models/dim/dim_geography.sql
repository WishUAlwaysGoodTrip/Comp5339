{{ config(
      materialized = 'table',
      unique_key = 'geography_key'
) }}

SELECT id AS geography_key, id AS original_geography_id , cityname AS city_name, countryname AS country_name, regionname AS region_name
       -- fill code here 
FROM
      {{ ref('geography') }}
