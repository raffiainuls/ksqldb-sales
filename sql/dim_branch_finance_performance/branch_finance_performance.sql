create table branch_finance_performance 
with (
    KAFKA_TOPIC='branch_finance_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
)as
SELECT 
u.name as name, 
o.amount as outcome, 
g.amount as gmv, 
r.amount as revenue, 
gp.amount as gross_profit, 
np.amount as net_profit
from uss_branch_finance_performance u
left join outcome_branch_finance_performance o
on o.name = u.name
left join gmv_branch_finance_performance g 
on g.name = u.name 
left join revenue_branch_finance_performance r 
on r.name = u.name 
left join gross_profit_branch_finance_performance gp 
on gp.name = u.name
left join net_profit_branch_finance_performance np 
on np.name = u.name
emit changes;