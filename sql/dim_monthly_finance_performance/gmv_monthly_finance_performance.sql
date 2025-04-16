create table gmv_monthly_finance_performance
with (
  KAFKA_TOPIC='gmv_monthly_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
) as 
select 
  -- concat(TRIM(SUBSTRING(
  --       TIMESTAMPTOSTRING(CAST(fs2.order_date AS BIGINT) / 1000, 'yyyy-MM-dd HH:mm:ss', 'UTC'),
  --       0,8
  --   )), '01') AS month,
concat(substring(cast(fs2.order_date as string),0,8),'01') as month,
    SUM(CAST(quantity * price AS DECIMAL(18,2))) as amount
from fact_sales fs2
group by concat(substring(cast(fs2.order_date as string),0,8),'01') 
EMIT CHANGES;