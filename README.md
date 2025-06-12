## KSQLDB Sales Streaming Data Pipeline 

#### Overview 
![flowchart_ksqldb-sales](https://github.com/user-attachments/assets/364a7b79-b44a-43f9-9db5-e42c9a9e6798)

This project is a streaming data pipeline project that use etl streaming from  postgres to postgres. This project using kafka for a real-time data streaming and KSQLDB for execute ETL streaming in kafka and then also there are some custome connector kafka coonect to sink data from kafka topics into postgres table.


#### Features 
- Connector Source Kafka: Connector source Postgres in Kafka Connecto to send data in postgres to Kafka topics
- KSQLDB Query For ETL Streaming: there are some query for ETL Streaming, this query like join, filter, etc in kafka topics
- Custom Connector Sink Kafka Connect: Custom Connector in Kafka Connect which is can sink data in kafka topics into postgres table

#### Technologies Used 
- Python
- Apache Kafka
- Zookeeper
- Debezium
- KSQLDB
- Custom Connector Sink Postgres
- Docker

  ### Project Structure
  <pre>  ksqldb-sales/
   |-- connector-java/                        # directory volumes mapping for plugins connector Kafka connect
       |-- PostgresSinkConnector-1.0-SNAPSHOT.jar          # jar custom connector kafka-connect    
     |-- helper/    
       |-- package.py                          # library python for help run all etl ksqldb
   |-- insert_sum_transaction/                 # directory for add sum value for table sum_transactions
         |-- dockerfile                  
         |-- insert_load_sum_transactions.py
     |-- postgres-db-volume/                   # directory volumes mapping for postgres
     |-- PostgresSinkConnector/                # directory code java for custom connector sink postgres
     |-- sql/                                  # directory etl or sql that will be execute at ksqldb 
       |-- dim_branch_finance_performance/     # directory sql for table dim_branch_finance_performance
            |-- branch_finance_performance.sql
            |-- gmv_branch_finance_performance.sql
            |-- gross_profit_branch_finance_performance.sql
            |-- net_profit_branch_finance_performance.sql
            |-- outcome_branch_finance_performance.sql
            |-- revenue_branch_finance_performance.sql
            |-- uss_branch_finance_performance.sql
            |-- config.yaml                              # file configuration for execute in ksqldb
            |-- readme.txt                               # read this for explanation about sql and flow for dim_branch_finance_performance
       |-- dim_branch_performance/   
            |-- ....../
       |-- dim_daily_finance_performance/   
            |-- ....../
       |-- dim_monthly_branch_performance/   
            |-- ....../
       |-- dim_monthly_finance_performance/   
            |-- ....../
       |-- dim_monthly_product_performance/   
            |-- ....../
       |-- fact_employee/   
            |-- ....../
       |-- fact_sales/   
            |-- ....../
       |-- sum_transactions/   
            |-- ....../
       |-- tbl_branch/   
            |-- ....../
       |-- tbl_customers/   
            |-- ....../
       |-- tbl_employee/   
            |-- ....../
       |-- tbl_product/   
            |-- ....../
       |-- tbl_promotions/   
            |-- ....../
       |-- tbl_sales/   
            |-- ....../
       |-- config.yaml
       |-- run_all.py
     |-- database/  
       |-- ......
     |-- docker-compose.yaml                # file docker-compose
     |-- stream_data.py                     # python script for generate and streaming data into kafka 

    
    
    

  
