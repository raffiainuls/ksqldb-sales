CREATE STREAM tbl_promotions_raw (
    payload struct<
	id int,
	event_name string,
	disc int,
	time string,
	created_at string
    >
) WITH (
    KAFKA_TOPIC='table.public.tbl_promotions',
    VALUE_FORMAT='JSON'
);