/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Raffi
 */
package com.mycompany.postgres_sink;

import org.apache.kafka.connect.sink.SinkRecord;
import org.apache.kafka.connect.sink.SinkTask;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class PostgresSinkTask extends SinkTask {
    private static final Logger logger = LoggerFactory.getLogger(PostgresSinkTask.class);
    private Connection connection;
    private String tableName;
    private Map<String, String> keyFields;
    private Map<String, String> valueFields;
    private String singleKeyField;

    @Override
    public String version() {
        return "1.0";
    }

    @Override
    public void start(Map<String, String> props) {
        try {
            logger.info("Starting PostgresSinkTask...");

            String jdbcUrl = props.get("connection.url");
            String user = props.get("connection.user");
            String password = props.get("connection.password");
            tableName = props.get("table.name");

            keyFields = parseFields(props.get("key.fields.types"));
            valueFields = parseFields(props.get("value.fields.types"));

            // Jika hanya ada satu key, ambil langsung namanya
            if (keyFields.size() == 1) {
                singleKeyField = keyFields.keySet().iterator().next();
                logger.info("Single key field detected: {}", singleKeyField);
            }

            logger.info("Connecting to PostgreSQL at: {}", jdbcUrl);
            connection = DriverManager.getConnection(jdbcUrl, user, password);
            createTableIfNotExists();

        } catch (Exception e) {
            logger.error("Error starting PostgresSinkTask", e);
            throw new RuntimeException(e);
        }
    }

    private Map<String, String> parseFields(String fieldsConfig) {
        Map<String, String> fields = new HashMap<>();
        if (fieldsConfig != null) {
            String[] entries = fieldsConfig.split(",");
            for (String entry : entries) {
                String[] keyValue = entry.trim().split("=");
                if (keyValue.length == 2) {
                    fields.put(keyValue[0].trim(), keyValue[1].trim());
                }
            }
        }
        return fields;
    }

    private void createTableIfNotExists() {
        try (Statement stmt = connection.createStatement()) {
            StringBuilder createTableQuery = new StringBuilder("CREATE TABLE IF NOT EXISTS " + tableName + " (");

            for (Map.Entry<String, String> entry : keyFields.entrySet()) {
                createTableQuery.append(entry.getKey()).append(" ").append(entry.getValue()).append(", ");
            }

            for (Map.Entry<String, String> entry : valueFields.entrySet()) {
                createTableQuery.append(entry.getKey()).append(" ").append(entry.getValue()).append(", ");
            }

//            if (keyFields.size() > 1) {
//                createTableQuery.append("PRIMARY KEY (");
//                for (String keyField : keyFields.keySet()) {
//                    createTableQuery.append(keyField).append(", ");
//                }
//                createTableQuery.setLength(createTableQuery.length() - 2);
//                createTableQuery.append("));");
//            } else {
//                createTableQuery.setLength(createTableQuery.length() - 2);
//                createTableQuery.append(");");
//            }
        // Tambahkan PRIMARY KEY
            if (keyFields.size() == 1) {
                createTableQuery.append("PRIMARY KEY (").append(singleKeyField).append("));");
            } else if (keyFields.size() > 1) {
                createTableQuery.append("PRIMARY KEY (");
                for (String keyField : keyFields.keySet()) {
                    createTableQuery.append(keyField).append(", ");
                }
                createTableQuery.setLength(createTableQuery.length() - 2);
                createTableQuery.append("));");
            } else {
                createTableQuery.setLength(createTableQuery.length() - 2);
                createTableQuery.append(");");
            }          

            logger.info("Executing query: {}", createTableQuery);
            stmt.execute(createTableQuery.toString());

        } catch (Exception e) {
            logger.error("Error creating table", e);
            throw new RuntimeException(e);
        }
    }

    @Override
    public void put(Collection<SinkRecord> records) {
        for (SinkRecord record : records) {
            try {
                Map<String, Object> keyMap;
                if (record.key() instanceof Map) {
                    keyMap = (Map<String, Object>) record.key();
                } else {
                    keyMap = singleKeyField != null ? Map.of(singleKeyField, record.key()) : Map.of();
                }

                Map<String, Object> valueMap = record.value() instanceof Map ? (Map<String, Object>) record.value() : Map.of();

                for (String field : valueFields.keySet()) {
                    if (valueFields.get(field).equalsIgnoreCase("TIMESTAMP") && valueMap.containsKey(field)) {
                        valueMap.put(field, Timestamp.valueOf(valueMap.get(field).toString()));
                    }
                }

                String sql = generateUpsertQuery(keyMap, valueMap);
                try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                    int index = 1;

                    for (String keyField : keyFields.keySet()) {
                        pstmt.setObject(index++, keyMap.get(keyField));
                    }
                    for (String valueField : valueFields.keySet()) {
                        pstmt.setObject(index++, valueMap.get(valueField));
                    }

                    pstmt.executeUpdate();
                    logger.info("Upserted record into {}", tableName);
                }
            } catch (Exception e) {
                logger.error("Error upserting record into database", e);
            }
        }
    }

    private String generateUpsertQuery(Map<String, Object> keyValues, Map<String, Object> valueValues) {
        StringBuilder sql = new StringBuilder("INSERT INTO " + tableName + " (");

        for (String keyField : keyFields.keySet()) {
            sql.append(keyField).append(", ");
        }
        for (String valueField : valueFields.keySet()) {
            sql.append(valueField).append(", ");
        }

        sql.setLength(sql.length() - 2);
        sql.append(") VALUES (");

        StringBuilder logValues = new StringBuilder(" VALUES (");

        for (String keyField : keyFields.keySet()) {
            Object keyValue = keyValues.getOrDefault(keyField, "NULL");
            sql.append("?, ");
            logValues.append("'").append(keyValue).append("', ");
        }
        for (String valueField : valueFields.keySet()) {
            Object value = valueValues.getOrDefault(valueField, "NULL");
            sql.append("?, ");
            logValues.append("'").append(value).append("', ");
        }

        sql.setLength(sql.length() - 2);
        sql.append(") ON CONFLICT (");

        logValues.setLength(logValues.length() - 2);
        logValues.append(")");

        for (String keyField : keyFields.keySet()) {
            sql.append(keyField).append(", ");
        }

        sql.setLength(sql.length() - 2);
        sql.append(") DO UPDATE SET ");

        for (String valueField : valueFields.keySet()) {
            sql.append(valueField).append(" = EXCLUDED.").append(valueField).append(", ");
        }

        sql.setLength(sql.length() - 2);
        sql.append(";");

        logger.info("Generated UPSERT SQL: {}{}", sql, logValues);
        return sql.toString();
    }

    @Override
    public void stop() {
        try {
            if (connection != null) {
                connection.close();
            }
            logger.info("PostgresSinkTask stopped.");
        } catch (Exception e) {
            logger.error("Error closing database connection", e);
        }
    }
}
