select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      select * from "sales_dw"."dev"."fact_sales"

where total_amount <= 0.00
      
    ) dbt_internal_test