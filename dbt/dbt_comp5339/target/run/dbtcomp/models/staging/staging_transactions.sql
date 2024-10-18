
  
    

  create  table "sales_dw"."dev"."staging_transactions__dbt_tmp"
  
  
    as
  
  (
    


SELECT * FROM "sales_dw"."dev"."staging_transactions_main"

UNION ALL

SELECT * FROM "sales_dw"."dev"."staging_transactions_resellers_xml"
  );
  