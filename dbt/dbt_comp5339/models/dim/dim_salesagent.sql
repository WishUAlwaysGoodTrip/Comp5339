{{
config(
materialized = 'table',
unique_key = 'sales_agent_key'
)
}}


SELECT
     -- fill code here 
FROM
    {{ ref('staging_resellers') }}
UNION ALL
SELECT
    0 AS sales_agent_key,
    NULL AS original_reseller_id,
    'Direct Sales' AS reseller_name,
    NULL AS commission_pct
