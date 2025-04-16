CREATE table tbl_customers_table (
	id int primary key,
	name string,
	address string,
	phone string,
	email string,
	created_at string,
	modified_at string
) with (
    KAFKA_TOPIC = 'tbl_customers_clean',
    VALUE_FORMAT = 'JSON',
	KEY_FORMAT='JSON'
);