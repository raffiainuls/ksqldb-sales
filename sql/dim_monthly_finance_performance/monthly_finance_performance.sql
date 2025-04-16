create table monthly_finance_performance
with(
  KAFKA_TOPIC='monthly_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
)as
select 
u.month as month,
u.unit_sold,
g.amount as gmv,
o.amount as outcome,
r.amount as revenue,
gp.amount as gross_profit,
np.amount as nett_profit
from uss_monthly_finance_performance u
left join gmv_monthly_finance_performance g
on g.month = u.month
left join outcome_monthly_finance_performance o
on o.month = u.month
left join revenue_monthly_finance_performance r
on r.month = u.month
left join gross_profit_monthly_finance_performance gp 
on gp.month = u.month 
left join net_profit_monthly_finance_performance np 
on np.month = u.month;