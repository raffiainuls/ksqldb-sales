
CREATE STREAM tbl_promotions_convert
WITH (
    KAFKA_TOPIC='tbl_promotions_convert',
    VALUE_FORMAT='JSON',
    KEY_FORMAT='JSON'
) AS
SELECT
    id,  
    event_name,
    disc,
    time
    -- trim(substring(TIMESTAMPTOSTRING(CAST(time AS BIGINT) / 1000, 'yyyy-MM-dd HH:mm:ss', 'UTC'),0,10)) time
FROM tbl_promotions_clean
-- PARTITION BY trim(substring(TIMESTAMPTOSTRING(CAST(time AS BIGINT) / 1000, 'yyyy-MM-dd HH:mm:ss', 'UTC'),0,10));
PARTITION BY TIME;
