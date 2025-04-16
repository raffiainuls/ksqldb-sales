CREATE table tbl_promotions_table (
   id int,
   event_name string,
   disc int,
   time string primary key
) WITH (
    KAFKA_TOPIC='tbl_promotions_convert',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
);