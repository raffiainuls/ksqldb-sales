create table uss_monthly_finance_performance
with (
  KAFKA_TOPIC='uss_monthly_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
) as 
select
concat(substring(cast(fs2.order_date as string),0,8),'01') AS month,
    sum(quantity) unit_sold
from fact_sales fs2
group by concat(substring(cast(fs2.order_date as string),0,8),'01') EMIT CHANGES;