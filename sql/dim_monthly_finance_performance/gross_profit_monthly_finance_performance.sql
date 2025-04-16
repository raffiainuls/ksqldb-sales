create table gross_profit_monthly_finance_performance 
with (
  KAFKA_TOPIC='gross_profit_monthly_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
) as 
select 
concat(substring(cast(fs2.order_date as string),0,8),'01') as month,
SUM(CAST((fs2.price * tp.profit / 100) * fs2.quantity AS DECIMAL(18,2))) AS amount  -- cast decimal because integer overflow 
from fact_sales fs2 
left join tbl_product_table tp 
on tp.id = fs2.product_id
group by 
concat(substring(cast(fs2.order_date as string),0,8),'01')   EMIT CHANGES;