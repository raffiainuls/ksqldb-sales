## KSQLDB Sales Streaming Data Pipeline 

#### Overview 
![flowchart_ksqldb-sales](https://github.com/user-attachments/assets/364a7b79-b44a-43f9-9db5-e42c9a9e6798)

This project is a streaming data pipeline project that use etl streaming from  postgres to postgres. This project using kafka for a real-time data streaming and KSQLDB for execute ETL streaming in kafka and then also there are some custome connector kafka coonect to sink data from kafka topics into postgres table.


#### Features 
- CDC Data: Connector debezium for cdc data from postgres into Kafka topics
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
   |-- last_id_backup              # backup list_id file
   |-- last_id.txt                 # this file save last_id that most_recent create in stream.py 
   |-- stream.py                   # file python that create data streaming and send into kafka 
</pre>

### Project Workflow 

1. CDC Data
   - In this project first source data from Postgres database so therefore we use debezium postgres source connector for CDC data from postgres into kafka topics.
2. KSQLDB For ETL Streaming
   - This project using KSQLDB for ETL streaming or execute query table like join, filter, windows function etc between some topics. but what needs to be known in KSQLDB there are some limitations functions. like in KSQLDB we cannot use union, does not support date related functions, do not support CTE, and in KSQLDB we cannot just join (there are several conditions that must be met)
3. Custom Connector Kafka Connect
   - this Connector works for sink data or topics results from ETL streaming in kSQLDB, to use this connector acctually same like general connector in kafka connect, the different just only the configuration
  
### Instalation & Setup 
#### Prerequisites 
- Docker
- Python
- Java


### Steps 
1. clone this repository
   ```bash
   https://github.com/raffiainuls/ksqldb-sales
2. In this project first we must have data in Postgres Database, you can import my data in th form of csv to postgres database in ```/ksqldb-sales/database```
3. if all table  ```tbl_order_status, tbl_payment_method, tb_payment_status, tbl_shipping_status, tbl_employee, tbl_promotions, tbl_sales, tbl_product, tbl_schedulle_emp, tbl_customers, and tbl_branch``` already available in postgres database we can start CDC step from postgres to kafka
4. first of all running all container in docker-compose
   ```bash
   docker-compose up
5. if all container already running correctly we must post connector sorce postgres (note in this docker compose already install plugins for connector debezium postgres source).
6. Post the configurations connector, the example of configurations it is in ```/ksqldb-sales/connector-configuration/postgres-source-connector.json``` you can post di configuration with postman or curl with this command
```bash
curl -X POST http://localhost:8083/connectors \
     -H "Content-Type: application/json" \
     -d @/connector-configuration/postgres-source-connector.json
```
  if you use this configuration, this connector will send all tables to kafka on the database specified in the configuration 
7. you can check is the topic for each table already available or not in kafka using control-center, go to ```localhost:9091``` to control center webserver 
8. if all topics for each table already available, now we can running streaming python script for generate data streaming and send to kafka, for your information this streaming only generate and send data to kafka for table tbl_sales only
9. run python streaming script 
```bash
python stream.py 
```
10. this file will generate data streaming into topic tbl_sales in kafka. in this python script there is some calculations metrics for generate value in some field, so the value that produce not too random.
11. 

    
    
    

  
