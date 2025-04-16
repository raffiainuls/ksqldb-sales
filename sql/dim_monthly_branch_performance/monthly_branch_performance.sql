create table monthly_branch_performance
with (
    KAFKA_TOPIC='monthly_branch_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as
SELECT
    fs2.branch_id,
    tb.name AS branch_name,
    concat(substring(cast(fs2.order_date as string),0,8),'01') AS MONTH,
    SUM(fs2.quantity) AS total_sales,
    SUM(fs2.amount) AS amount
FROM fact_sales fs2
LEFT JOIN tbl_branch_table tb
ON tb.id = fs2.branch_id
GROUP BY 
    fs2.branch_id, 
    tb.name, 
    concat(substring(cast(fs2.order_date as string),0,8),'01') EMIT CHANGES;