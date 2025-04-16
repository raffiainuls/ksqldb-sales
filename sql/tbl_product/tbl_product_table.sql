create table tbl_product_table(
	id int primary key,
	product_name string ,
	category string,
	sub_category string ,
	price int ,
	profit int,
	stock int ,
	created_time string ,
	modified_time string
) with (
	KAFKA_TOPIC='tbl_product_clean',
	VALUE_FORMAT= 'JSON',
	KEY_FORMAT= 'JSON'
);
