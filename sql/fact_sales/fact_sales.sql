CREATE STREAM fact_sales
WITH (
    KAFKA_TOPIC='fact_sales',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) AS
SELECT
    ts.id as id,
    ts.product_id as product_id,
    ts.customer_id,
    ts.branch_id,
    ts.quantity,
    ts.payment_method,
    ts.order_date,
    ts.order_status,
    ts.payment_status,
    ts.shipping_status,
    ts.is_online_transaction,
    ts.delivery_fee,
    ts.is_free_delivery_fee,
    ts.created_at,
    ts.modified_at,
    tp.product_name,
    tp.category AS product_category,
    tp.sub_category AS sub_category_product,
    tp.price,
    tps.disc,
    tps.event_name AS disc_name,
    CAST(
        CASE
            WHEN tps.disc IS NOT NULL
            THEN (tp.price * ts.quantity) - (tp.price * ts.quantity) * COALESCE(tps.disc, 0) / 100
            ELSE tp.price * ts.quantity
        END AS BIGINT
    ) AS amount
FROM tbl_sales_clean ts
LEFT JOIN tbl_product_table tp
ON tp.id = ts.product_id
LEFT JOIN tbl_promotions_table tps
--ON tps.time =  trim(substring(TIMESTAMPTOSTRING(CAST(ts.order_date AS BIGINT) / 1000, 'yyyy-MM-dd HH:mm:ss', 'UTC'),0,10))
ON tps.time =  trim(substring(cast(order_date as string),0,10))
WHERE ts.order_status = 2
    AND ts.payment_status = 2
    AND (ts.shipping_status = 2 OR ts.shipping_status IS NULL)
PARTITION BY ts.id;


