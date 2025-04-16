create stream tbl_branch_clean 
with (
	KAFKA_TOPIC='tbl_branch_clean',
	VALUE_FORMAT='JSON',
	KEY_FORMAT='JSON'
) as 
select 
	payload->id,
	payload->name,
	payload->location,
	payload->address,
	payload->email,
	payload->phone,
	payload->created_time,
	payload->modified_time
from tbl_branch_raw
PARTITION BY payload->id;