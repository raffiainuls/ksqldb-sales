create table tbl_employee_table (
    id int primary key,
    branch_id int,
    name string, 
    salary BIGINT
) with (
    KAFKA_TOPIC= 'tbl_employee_clean',
	VALUE_FORMAT = 'JSON',
	KEY_FORMAT = 'JSON'
);
