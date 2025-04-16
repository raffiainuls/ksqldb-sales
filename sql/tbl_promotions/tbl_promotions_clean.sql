CREATE STREAM tbl_promotions_clean
WITH (
    KAFKA_TOPIC='tbl_promotions_clean',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) AS
SELECT
    payload->ID AS ID,  
    payload->event_name AS EVENT_NAME,
    payload->DISC AS DISC,
    payload->TIME AS TIME
FROM tbl_promotions_raw
PARTITION BY payload->TIME;