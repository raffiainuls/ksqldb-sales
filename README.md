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
  <pre>  flink-sales/
   |-- clickhouse/                       # directory configurasi docker clickhouse
       |-- config.xml                    
       |-- schema.sql                    
       |-- setup apache superset on docker.txt                
       |-- zookeeper-servers.xml 
  
