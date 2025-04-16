create table gross_profit_daily_finance_performance 
with (
  KAFKA_TOPIC='gross_profit_daily_finance_performance',
  KEY_FORMAT='JSON',
  VALUE_FORMAT='JSON'
)as
select 
 trim(substring(cast(fs2.order_date as string),0,10)) as date,
sum(cast((fs2.price * tp.profit / 100) * fs2.quantity as decimal(18,2))) as amount
from fact_sales fs2
left join tbl_product_table tp 
on tp.id = fs2.product_id
group by 
 trim(substring(cast(fs2.order_date as string),0,10)) emit changes;