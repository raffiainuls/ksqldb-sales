create stream tbl_sales_clean
with (
    KAFKA_TOPIC='tbl_sales_clean',
    VALUE_FORMAT='JSON',
    KEY_FORMAT= 'JSON'
) as 
select 
payload->ID,
payload->product_id,
payload->customer_id,
payload->branch_id,
payload->quantity,
payload->payment_method,
payload->order_date,
payload->order_status,
payload->payment_status,
payload->shipping_status,
payload->is_online_transaction,
payload->delivery_fee,
payload->is_free_delivery_fee,
payload->created_at,
payload->modified_at
from tbl_sales_raw
PARTITION by payload->ID;