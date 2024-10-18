
  create view "sales_dw"."dev"."src_transactions__dbt_tmp"
    
    
  as (
    WITH raw_transactions AS (

    SELECT * FROM "sales_dw"."import"."transactions"
)

SELECT customer_id, product_id, amount, qty, channel_id, bought_date, transaction_id, loaded_timestamp

FROM raw_transactions
  );