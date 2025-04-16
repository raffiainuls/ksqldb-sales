the main sql is daily_finance_performance.sql, the other SQL actually a vonversion from CTE, 
because in KSQLDB not support CTE, therefore need to make table first, and then actually we need to union all cte, but
in KSQLDB not support union, therefore, the logic is replaced by first creating the stream and kafka topic, then using the insert into logic