CREATE STREAM tbl_sales_raw (
payload STRUCT<
id INT,
product_id INT,
customer_id INT,
branch_id INT,
quantity INT,
payment_method INT,
order_date STRING,
order_status INT,
payment_status INT,
shipping_status INT,
is_online_transaction string,
delivery_fee INT,
is_free_delivery_fee string,
created_at STRING,
modified_at STRING
>
) WITH (
KAFKA_TOPIC = 'table.public.tbl_sales',
VALUE_FORMAT = 'JSON'
);