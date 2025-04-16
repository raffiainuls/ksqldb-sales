create table net_profit_branch_finance_performance
with (
    KAFKA_TOPIC='net_profit_branch_finance_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as 
select 
o.name as name,
(gp.amount - o.amount) as amount 
from outcome_branch_finance_performance o
left join gross_profit_branch_finance_performance gp 
on gp.name = o.name
emit changes;