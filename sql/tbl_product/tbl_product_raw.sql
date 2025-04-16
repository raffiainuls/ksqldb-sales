CREATE stream tbl_product_raw(
    payload STRUCT<
	id int,
	product_name string ,
	category string,
	sub_category string ,
	price int ,
	profit int,
	stock int ,
	created_time string ,
	modified_time string
    >
) with (
    KAFKA_TOPIC = 'table.public.tbl_product',
    VALUE_FORMAT = 'JSON'
);