create stream tbl_customers_clean
with (
	KAFKA_TOPIC='tbl_customers_clean',
	VALUE_FORMAT='JSON',
	KEY_FORMAT='JSON'
) as
select 
	payload->id,
	payload->name,
	payload->address,
	payload->email,
	payload->phone,
	payload->created_at,
	payload->modified_at
from tbl_customers_raw
PARTITION BY payload->id;