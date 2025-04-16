create stream income_offline_store
with (
    KAFKA_TOPIC='income_offline_store',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as 
SELECT 
    'income' AS type,
    id AS sales_id,
    branch_id,
    CAST(NULL AS STRING) AS employee_id,
    CONCAT(product_name, ' sales of ', CAST(quantity AS STRING)) AS description,
    order_date AS date,
    amount
FROM fact_sales
WHERE is_online_transaction = 'false';