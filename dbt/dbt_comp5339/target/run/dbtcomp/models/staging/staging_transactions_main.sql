
      insert into "sales_dw"."dev"."staging_transactions_main" ("customer_key", "transaction_id", "product_key", "channel_key", "reseller_id", "bought_date_key", "total_amount", "qty", "product_price", "geography_key", "commissionpaid", "commissionpct", "loaded_timestamp")
    (
        select "customer_key", "transaction_id", "product_key", "channel_key", "reseller_id", "bought_date_key", "total_amount", "qty", "product_price", "geography_key", "commissionpaid", "commissionpct", "loaded_timestamp"
        from "staging_transactions_main__dbt_tmp044905164154"
    )


  