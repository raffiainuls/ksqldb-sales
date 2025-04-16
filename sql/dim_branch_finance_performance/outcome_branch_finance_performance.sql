create table outcome_branch_finance_performance 
with (
    KAFKA_TOPIC='outcome_branch_finance_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
)as 
select 
tb.name name, 
sum(cast(amount as decimal(22,2))) as amount
from sum_transactions st
left join tbl_branch_table tb 
on tb.id = st.branch_id 
where type ='outcome'
group by tb.name
EMIT CHANGES;