CREATE stream tbl_branch_raw (
    payload struct<
	id int,
	name string,
	location string,
	address string,
	email string,
	phone string,
	created_time string,
	modified_time string
    >
) with (
    KAFKA_TOPIC = 'table.public.tbl_branch',
    VALUE_FORMAT = 'JSON'
);