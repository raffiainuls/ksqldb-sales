create table outcome_daily_finance_performance
with (
  KAFKA_TOPIC='outcome_daily_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT='JSON'
) as
select 
 trim(substring(cast(st.date as string),0,10)) as date,
sum(cast(amount as decimal(18,2))) as amount
from sum_transactions st 
where type ='outcome'
group by 
 trim(substring(cast(st.date as string),0,10)) EMIT CHANGES;