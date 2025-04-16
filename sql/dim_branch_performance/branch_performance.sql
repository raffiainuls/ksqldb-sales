create table branch_performance
with (
    KAFKA_TOPIC='branch_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
 )as
select 
fs2.branch_id as branch_id,
tb.name  branch_name,
sum(quantity) as total_sales,
sum(amount) amount
from fact_sales fs2 
left join tbl_branch_table tb 
on tb.id = fs2.branch_id 
group by fs2.branch_id, tb.name;