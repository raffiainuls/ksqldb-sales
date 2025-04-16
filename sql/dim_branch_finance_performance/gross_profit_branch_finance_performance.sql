create table gross_profit_branch_finance_performance 
with (
    KAFKA_TOPIC='gross_profit_branch_finance_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as
select 
tb.name name,
sum(cast((fs2.price * tp.profit / 100) * fs2.quantity as decimal(18,2))) as amount 
from fact_sales fs2
left join tbl_product_table tp
on tp.id = fs2.product_id 
left join tbl_branch_table tb 
on tb.id = fs2.branch_id 
group by tb.name 
EMIT CHANGES;