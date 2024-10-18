


WITH 

  

latest_transaction as (

select max(loaded_timestamp) as max_transaction  from "sales_dw"."dev"."staging_transactions_main"

),



trans_main AS (
  SELECT
    md5(cast(coalesce(cast(0 as TEXT), '') || '-' || coalesce(cast(customer_id as TEXT), '') as TEXT)) AS customer_key,
    customer_id,
    transaction_id,
    product_id,
    amount,
    qty,
    channel_id,
    bought_date,
    loaded_timestamp
  FROM
    "sales_dw"."import"."transactions"

  

  -- this filter will only be applied on an incremental run
  where loaded_timestamp > (SELECT max_transaction from latest_transaction LIMIT 1)

  

)

SELECT
  t.customer_key,
  transaction_id,
  e.product_key,
  C.channel_key,
  0 AS reseller_id,
  to_char(
    bought_date,
    'YYYYMMDD'
  ) :: INT AS bought_date_key,
  amount::numeric AS total_amount,
  qty,
  e.product_price::numeric,
  e.geography_key,
  NULL::numeric AS commissionpaid,
  NULL::numeric AS commissionpct,
  loaded_timestamp


FROM
  trans_main t
  JOIN "sales_dw"."dev"."dim_product" e
  ON t.product_id = e.product_key
  JOIN "sales_dw"."dev"."dim_channel" C
  ON t.channel_id = C.channel_key
  JOIN "sales_dw"."dev"."dim_customer"
  cu
  ON t.customer_key = cu.customer_key