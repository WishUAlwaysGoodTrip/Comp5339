
  create view "sales_dw"."dev"."src_resellers__dbt_tmp"
    
    
  as (
    WITH raw_resellers AS (

    SELECT * FROM "sales_dw"."import"."resellers"
)

SELECT reseller_id, reseller_name, commission_pct , loaded_timestamp

FROM raw_resellers
  );