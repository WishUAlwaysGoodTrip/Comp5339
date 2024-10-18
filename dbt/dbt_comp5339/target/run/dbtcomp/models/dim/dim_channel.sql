
  
    

  create  table "sales_dw"."dev"."dim_channel__dbt_tmp"
  
  
    as
  
  (
    


select channel_key, original_channel_id, channel_name
from "sales_dw"."dev"."staging_channels"
  );
  