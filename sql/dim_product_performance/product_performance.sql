CREATE TABLE product_performance
WITH (
    KAFKA_TOPIC='product_performance',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) AS
SELECT
    fs2.product_id,
    tp.product_name AS product_name,
    SUM(quantity) AS SUM
FROM fact_sales fs2
LEFT JOIN tbl_product_table tp
ON tp.id = fs2.product_id
GROUP BY fs2.product_id, tp.product_name
EMIT CHANGES;
