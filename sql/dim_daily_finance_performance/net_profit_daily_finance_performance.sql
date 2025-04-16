create table net_profit_daily_finance_performance 
with (
  KAFKA_TOPIC='net_profit_daily_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
) as
select 
gp.date as date,
(gp.amount - o.amount) as amount
from gross_profit_daily_finance_performance gp 
left join outcome_daily_finance_performance o 
on o.date = gp.date emit changes;