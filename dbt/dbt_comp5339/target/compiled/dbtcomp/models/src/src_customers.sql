with raw_customers as (

    SELECT * from "sales_dw"."import"."customers"
)

select customer_id, first_name , last_name , email

from raw_customers