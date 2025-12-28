package com.example.sampleprojectjavaee.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static DBConnection dbConnection;
    private final Connection connection;

    private DBConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");

        //create a connection between with selected database..
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sanka_seafood", "root", "Anjana1212@");
    }

    public static DBConnection getDbConnection() throws SQLException, ClassNotFoundException {
        if (dbConnection == null) {
            dbConnection = new DBConnection();
        }
        return dbConnection;
    }

    public Connection getConnection() {
        return connection;
    }

}
