create stream outcome_discount
with(
    KAFKA_TOPIC='outcome_discount',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
)as
select 
'outcome' as type,
id as sales_id,
branch_id,
cast(null as string) as employee_id,
concat('Outcome Discount ', disc_name) as description,
order_date as date,
 cast((CAST(price AS DECIMAL(18,2)) * CAST(quantity AS DECIMAL(18,2))) * (CAST(disc AS DECIMAL(18,2)) / 100) as decimal(18,2)) as amount
from fact_sales
where disc is not null;