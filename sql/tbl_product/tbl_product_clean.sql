create stream tbl_product_clean 
with (
	KAFKA_TOPIC='tbl_product_clean',
	VALUE_FORMAT='JSON',
	KEY_FORMAT='JSON'
) AS
SELECT
	payload->ID as ID,
	payload->product_name,
	payload->category,
	payload->sub_category,
	payload->price,
	payload->profit,
	payload->stock,
	payload->created_time,
	payload->modified_time
from tbl_product_raw
PARTITION by payload->ID;