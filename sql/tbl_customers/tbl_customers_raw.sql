CREATE stream tbl_customers_raw (
    payload struct <
	id int,
	name string,
	address string,
	phone string,
	email string,
	created_at string,
	modified_at string
    >
) with (
    KAFKA_TOPIC = 'table.public.tbl_customers',
    VALUE_FORMAT = 'JSON'
);