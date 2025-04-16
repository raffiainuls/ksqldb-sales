-- monthly_product_performance 
create table monthly_product_performance
with (
    KAFKA_TOPIC='monthly_product_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as 
select 
fs2.product_id,
tp.product_name as product_name,
-- concat(TRIM(SUBSTRING(
--         TIMESTAMPTOSTRING(CAST(fs2.order_date AS BIGINT) / 1000, 'yyyy-MM-dd HH:mm:ss', 'UTC'),
--         0,8
--     )), '01') as bulan,
concat(substring(cast(order_date as string),0,8),'01') as month,
sum(quantity) sum
from fact_sales fs2 
left join tbl_product_table tp 
on tp.id  = fs2.product_id 
group by 
fs2.product_id,
tp.product_name,
concat(substring(cast(order_date as string),0,8),'01') EMIT CHANGES;
