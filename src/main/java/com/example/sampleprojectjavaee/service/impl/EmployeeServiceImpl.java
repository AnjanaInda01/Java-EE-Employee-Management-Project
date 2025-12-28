package com.example.sampleprojectjavaee.service.impl;

import com.example.sampleprojectjavaee.db.DBConnection;
import com.example.sampleprojectjavaee.dto.EmployeeDto;
import com.example.sampleprojectjavaee.service.EmployeeService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;

public class EmployeeServiceImpl implements EmployeeService {
    public EmployeeDto saveEmployee(EmployeeDto employeeDto) {


        try {
            //load Driver class to RAM
            Connection connection = DBConnection.getDbConnection().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("insert into employee (emp_nic,emp_name,emp_age,salary) values (?, ?, ?, ?)");
            preparedStatement.setObject(1, employeeDto.getNic());
            preparedStatement.setObject(2, employeeDto.getName());
            preparedStatement.setObject(3, employeeDto.getAge());
            preparedStatement.setObject(4, employeeDto.getSalary());

            //added row count in i
            int i = preparedStatement.executeUpdate();
            if (i > 0) {
                return employeeDto;
            } else {
                return null;
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteEmployee(String nic) {
        try {
            //load Driver class to RAM
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            //create a connection between with selected database..
//            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sanka_seafood","root","Anjana1212@");
            Connection connection = DBConnection.getDbConnection().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("delete from employee where emp_nic=?");
            preparedStatement.setString(1, nic);

            int i = preparedStatement.executeUpdate();
            return i > 0;

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public List<EmployeeDto> getAllEmployee() {
        List<EmployeeDto> list = new ArrayList<>();
        try {
            //load Driver class to RAM
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            //create a connection between with selected database..
//            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sanka_seafood","root","Anjana1212@");
            Connection connection = DBConnection.getDbConnection().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("select emp_nic,emp_name,emp_age,salary from employee");


            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                EmployeeDto dto = new EmployeeDto(
                        resultSet.getString("emp_nic"),
                        resultSet.getString("emp_name"),
                        resultSet.getInt("emp_age"),
                        resultSet.getDouble("salary")
                );
                list.add(dto);
            }
            return list;

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public EmployeeDto searchEmployee(String nic) {
        try {
            //load Driver class to RAM
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            //create a connection between with selected database
//            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sanka_seafood","root","Anjana1212@");
            Connection connection = DBConnection.getDbConnection().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("select*from employee where emp_nic=?");
            preparedStatement.setObject(1, nic);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return new EmployeeDto(
                        resultSet.getString("emp_nic"),
                        resultSet.getString("emp_name"),
                        resultSet.getInt("emp_age"),
                        resultSet.getDouble("salary")
                );
            } else {
                return null;
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public EmployeeDto updateEmployee(EmployeeDto employeeDto) {
        try {
            //load Driver class to RAM
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            //create a connection between with selected database
//            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sanka_seafood","root","Anjana1212@");
            Connection connection = DBConnection.getDbConnection().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("update employee set emp_name=?,emp_age=?,salary=? where emp_nic=?");
            preparedStatement.setObject(1, employeeDto.getName());
            preparedStatement.setObject(2, employeeDto.getAge());
            preparedStatement.setObject(3, employeeDto.getSalary());
            preparedStatement.setObject(4, employeeDto.getNic());

            //added row count in i
            int i = preparedStatement.executeUpdate();
            if (i > 0) {
                return employeeDto;
            } else {
                return null;
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
