create table tbl_branch_table (
	id int primary key, 
	name string, 
	location string,
	address string, 
	email string, 
	phone string, 
	created_time string, 
	modified_time string
) with (
	KAFKA_TOPIC='tbl_branch_clean',
	VALUE_FORMAT='JSON',
	KEY_FORMAT='JSON'
);