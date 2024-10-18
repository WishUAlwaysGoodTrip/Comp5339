
  create view "sales_dw"."dev"."src_customers__dbt_tmp"
    
    
  as (
    with raw_customers as (

    SELECT * from "sales_dw"."import"."customers"
)

select customer_id, first_name , last_name , email

from raw_customers
  );