create table uss_daily_finance_performance
with (
  KAFKA_TOPIC='uss_daily_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
) as  
select 
 trim(substring(cast(fs2.order_date as string),0,10)) as date,
sum(quantity) unit_sold
from fact_sales fs2
group by  trim(substring(cast(fs2.order_date as string),0,10)) EMIT CHANGES;