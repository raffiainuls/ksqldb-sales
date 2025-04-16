create stream income_online_store
with(
    KAFKA_TOPIC='income_online_store',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
)as
select 
'income' as type,
id as sales_id,
branch_id as branch_id,
cast(null as string) as employee_id,
CONCAT(product_name, ' sales of ', CAST(quantity AS STRING)) AS description,
order_date as date,
(price * quantity) as amount
from fact_sales 
where is_online_transaction = 'true';