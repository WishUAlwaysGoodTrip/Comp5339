
  create view "sales_dw"."dev"."staging_channels__dbt_tmp"
    
    
  as (
    with staging_channels as (
select channel_id, channel_name
from "sales_dw"."dev"."src_channels"
)
select channel_id as channel_key, channel_id as original_channel_id, channel_name
from staging_channels
  );