create table gmv_daily_finance_performance
with(
  KAFKA_TOPIC='gmv_daily_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
)as 
select 
 trim(substring(cast(fs2.order_date as string),0,10)) as date,
sum(cast(quantity * price as decimal(18,2))) as amount
from fact_sales fs2
group by 
 trim(substring(cast(fs2.order_date as string),0,10)) emit CHANGES;