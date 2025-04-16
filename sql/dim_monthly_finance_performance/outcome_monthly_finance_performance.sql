create table outcome_monthly_finance_performance
with (
  KAFKA_TOPIC='outcome_monthly_finance_performance',
  VALUE_FORMAT='JSON',
  KEY_FORMAT ='JSON'
)as 
select 
concat(substring(cast(st.date as string),0,8),'01') as month,
  SUM(CAST(amount AS DECIMAL(18,2)))  as amount
from sum_transactions st
where type = 'outcome'
group by 
concat(substring(cast(st.date as string),0,8),'01') EMIT CHANGES;