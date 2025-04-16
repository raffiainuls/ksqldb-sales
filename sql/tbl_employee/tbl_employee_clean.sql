CREATE stream tbl_employee_clean
WITH (
	KAFKA_TOPIC='tbl_employee_clean',
	VALUE_FORMAT='JSON',
	KEY_FORMAT='JSON'
) AS 
SELECT 
	payload->id,
	payload->BRANCH_ID,
	payload->name,
	payload->salary,
	payload->active,
	payload->address,
	payload->phone,
	payload->email,
	payload->created_at
FROM tbl_employee_raw
PARTITION BY payload->id;