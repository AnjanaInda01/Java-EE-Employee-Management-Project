package com.example.sampleprojectjavaee.service;

import com.example.sampleprojectjavaee.dto.EmployeeDto;

import java.util.List;

public interface EmployeeService {
    EmployeeDto saveEmployee(EmployeeDto employeeDto);

    boolean deleteEmployee(String nic);

    List<EmployeeDto> getAllEmployee();

    EmployeeDto searchEmployee(String nic);

    EmployeeDto updateEmployee(EmployeeDto employeeDto);
}
