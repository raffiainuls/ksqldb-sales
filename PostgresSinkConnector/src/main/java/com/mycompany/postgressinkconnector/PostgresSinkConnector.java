/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.postgressinkconnector;

import org.apache.kafka.common.config.ConfigDef;
import org.apache.kafka.connect.connector.Task;
import org.apache.kafka.connect.sink.SinkConnector;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;

/**
 *
 * @author Raffi
 */
public class PostgresSinkConnector extends SinkConnector{
    
    private static final Logger logger = LoggerFactory.getLogger(PostgresSinkConnector.class);
    private Map<String, String> configProps;
    
    @Override
    public String version() {
        return "1.0";
    }

    @Override
    public void start(Map<String, String> props) {
        logger.info("Starting PostgresSinkConnector....");
        configProps = props;
        
        //Logging Configuration for debug 
        logger.info("Loaded configuration:");
        props.forEach((key, value) -> logger.info("{} = {}", key, value));
    }

    @Override
    public Class<? extends Task> taskClass() {
        return com.mycompany.postgres_sink.PostgresSinkTask.class;
    }

    @Override
    public List<Map<String, String>> taskConfigs(int maxTasks) {
        List<Map<String, String>> configs = new ArrayList<>();
        for (int i = 0; i < maxTasks; i ++) {
            configs.add(configProps);
        }
        return configs;
    }

    @Override
    public void stop() {
        logger.info("Stopping PostgresSinkConnector....");
    }

    @Override
    public ConfigDef config() {
        return new ConfigDef()
                .define("connection.url", ConfigDef.Type.STRING, ConfigDef.Importance.HIGH, "PostgreSQL JDBC URL")
                .define("connection.user", ConfigDef.Type.STRING,ConfigDef.Importance.HIGH,"PostgreSQL User")
                .define("connection.password", ConfigDef.Type.STRING,ConfigDef.Importance.HIGH,"PostgreSQL Password")
                .define("topics", ConfigDef.Type.STRING,ConfigDef.Importance.HIGH,"Kafka Topic to Consume")
                .define("table.name", ConfigDef.Type.STRING,ConfigDef.Importance.HIGH,"Target PostgreSQL Table")
                .define("key.fields", ConfigDef.Type.STRING,ConfigDef.Importance.HIGH,"Key Fields")
                .define("key.fields.types", ConfigDef.Type.STRING,ConfigDef.Importance.HIGH,"Key Fields Types")
                .define("value.fields", ConfigDef.Type.STRING,ConfigDef.Importance.HIGH,"Value Fields")
                .define("value.fields.types", ConfigDef.Type.STRING,ConfigDef.Importance.HIGH,"Value Fields Types");
        
    }
}
