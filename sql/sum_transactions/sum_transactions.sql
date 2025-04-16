create stream sum_transactions
with (
    KAFKA_TOPIC='sum_transactions',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) as
select 
type,
sales_id,
branch_id,
employee_id,
description,
date,
amount 
from income_offline_store;



INSERT INTO sum_transactions
SELECT 
    SALES_ID, 
    TYPE, 
    BRANCH_ID, 
    EMPLOYEE_ID, 
    DESCRIPTION, 
    DATE, 
    CAST(AMOUNT AS BIGINT)  as amount
FROM income_online_store 
EMIT CHANGES;


INSERT INTO sum_transactions
SELECT 
    SALES_ID, 
    TYPE, 
    BRANCH_ID, 
    EMPLOYEE_ID, 
    DESCRIPTION, 
    DATE, 
    CAST(AMOUNT AS BIGINT) as amount
FROM outcome_delivery 
EMIT CHANGES;


INSERT INTO sum_transactions
SELECT 
    SALES_ID, 
    TYPE, 
    BRANCH_ID, 
    EMPLOYEE_ID, 
    DESCRIPTION, 
    DATE, 
    CAST(AMOUNT AS BIGINT) as amount
FROM outcome_discount 
EMIT CHANGES;


