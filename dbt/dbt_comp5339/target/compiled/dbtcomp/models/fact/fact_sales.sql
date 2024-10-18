

SELECT
    customer_key,
	product_key,
	channel_key,
	bought_date_key,
	geography_key,
    reseller_id,
    total_amount
     -- fill code here 
FROM
    "sales_dw"."dev"."staging_transactions"