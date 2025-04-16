CREATE stream tbl_employee_raw (
    payload struct<
	id int,
	branch_id int,
	name string,
	salary int,
	active string,
	address string,
	phone string,
	email string,
	created_at string
    >
) with (
    KAFKA_TOPIC = 'table.public.tbl_employee',
    VALUE_FORMAT= 'JSON'
);