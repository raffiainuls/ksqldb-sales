CREATE stream fact_employee
WITH(
    KAFKA_TOPIC='fact_employee',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) AS
SELECT 
id,
branch_id,
name,
salary
from tbl_employee_clean
where active = 'true';