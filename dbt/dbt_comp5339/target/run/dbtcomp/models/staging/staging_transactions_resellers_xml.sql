
      insert into "sales_dw"."dev"."staging_transactions_resellers_xml" ("customer_key", "transaction_id", "product_key", "channel_key", "reseller_id", "bought_date_key", "total_amount", "no_purchased_postcards", "product_price", "geography_key", "commisionpaid", "commission_pct", "loaded_timestamp")
    (
        select "customer_key", "transaction_id", "product_key", "channel_key", "reseller_id", "bought_date_key", "total_amount", "no_purchased_postcards", "product_price", "geography_key", "commisionpaid", "commission_pct", "loaded_timestamp"
        from "staging_transactions_resellers_xml__dbt_tmp044905161571"
    )


  