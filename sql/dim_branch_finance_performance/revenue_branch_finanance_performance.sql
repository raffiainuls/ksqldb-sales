create table revenue_branch_finance_performance 
with (
    KAFKA_TOPIC='revenue_branch_finance_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as
select 
tb.name as name,
sum(cast(amount as decimal(18,2))) as amount
from sum_transactions st 
left join tbl_branch_table tb 
on tb.id=st.branch_id
where type = 'income' and sales_id is not null
group by  tb.name
EMIT CHANGES;