
  create view "sales_dw"."dev"."src_products__dbt_tmp"
    
    
  as (
    WITH raw_products AS (

    SELECT * FROM "sales_dw"."import"."products"
)

SELECT product_id, name AS product_name, price AS product_price, city AS product_city, loaded_timestamp

FROM raw_products
  );