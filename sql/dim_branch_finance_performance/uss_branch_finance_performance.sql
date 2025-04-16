create table uss_branch_finance_performance
with (
    KAFKA_TOPIC='uss_branch_finance_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as
select 
tb.name as name,
sum(quantity) as unit_sold
from fact_sales fs2
left join tbl_branch_table tb
on tb.id = fs2.branch_id 
group by tb.name EMIT CHANGES;