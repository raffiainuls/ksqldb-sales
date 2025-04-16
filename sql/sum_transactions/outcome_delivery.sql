create stream outcome_delivery
with (
    KAFKA_TOPIC='outcome_delivery',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as
select 
'outcome' as type,
id as sales_id,
branch_id,
cast(null as string) as employee_id,
'Outcome Delivery' as description,
order_date as date,
delivery_fee as amount
from fact_sales
where is_free_delivery_fee = 'true';