create table  net_profit_monthly_finance_performance
with (
  KAFKA_TOPIC='net_profit_monthly_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
)as
select 
gp.month as month,
(gp.amount - o.amount) as amount
from gross_profit_monthly_finance_performance gp
left join outcome_monthly_finance_performance o
on  o.month = gp.month;