create table daily_finance_performance 
with (
  KAFKA_TOPIC='daily_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
) as
select 
u.date as date,
u.unit_sold,
g.amount as gmv,
o.amount as outcome,
r.amount as revenue,
gp.amount as gross_profit,
np.amount as nett_profit
from uss_daily_finance_performance u
left join gmv_daily_finance_performance g
on g.date = u.date
left join outcome_daily_finance_performance o
on o.date = u.date
left join revenue_daily_finance_performance r
on r.date = u.date
left join gross_profit_daily_finance_performance gp 
on gp.date = u.date 
left join net_profit_daily_finance_performance np 
on np.date = u.date;