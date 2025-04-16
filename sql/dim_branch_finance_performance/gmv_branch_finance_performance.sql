create table gmv_branch_finance_performance 
with (
    KAFKA_TOPIC='gmv_branch_finance_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as 
select 
tb.name as name, 
sum(cast(quantity * price as decimal(18,2))) as amount
from fact_sales fs2
left join tbl_branch_table tb
on tb.id = fs2.branch_id 
group by tb.name
EMIT CHANGES;