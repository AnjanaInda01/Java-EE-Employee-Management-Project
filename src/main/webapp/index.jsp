<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Management</title>

    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
        }

        .card {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>

<body>

<div class="container mt-5">

    <h2 class="text-center mb-4">Employee Management</h2>

    <!-- ADD EMPLOYEE -->
    <div class="card p-4 mb-4">
        <h5>Add Employee</h5>

        <div class="row g-3 mt-2">
            <div class="col-md-3">
                <input type="text" id="nic" class="form-control" placeholder="NIC">
            </div>
            <div class="col-md-3">
                <input type="text" id="name" class="form-control" placeholder="Name">
            </div>
            <div class="col-md-2">
                <input type="number" id="age" class="form-control" placeholder="Age">
            </div>
            <div class="col-md-2">
                <input type="number" id="salary" class="form-control" placeholder="Salary">
            </div>
            <div class="col-md-2 d-grid">
                <button type="button" class="btn btn-primary" onclick="saveEmployee()">
                    Save
                </button>
            </div>
        </div>
    </div>

    <!-- SEARCH WITH BUTTON -->
    <div class="row mb-3">
        <div class="col-md-10">
            <input type="text" id="searchNic" class="form-control"
                   placeholder="Search by NIC">
        </div>
        <div class="col-md-2 d-grid">
            <button type="button" class="btn btn-secondary"
                    onclick="searchEmployee()">
                Search
            </button>
        </div>
    </div>

    <!-- EMPLOYEE TABLE -->
    <div class="card p-3">
        <table class="table table-bordered table-hover text-center">
            <thead class="table-dark">
            <tr>
                <th>NIC</th>
                <th>Name</th>
                <th>Age</th>
                <th>Salary</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="employeeTable">
            </tbody>
        </table>
    </div>

</div>

<!-- UPDATE MODAL -->
<div class="modal fade" id="updateModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Update Employee</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <input type="hidden" id="updateIndex">

                <div class="mb-2">
                    <label>NIC</label>
                    <input type="text" id="updateNic" class="form-control" disabled>
                </div>

                <div class="mb-2">
                    <label>Name</label>
                    <input type="text" id="updateName" class="form-control">
                </div>

                <div class="mb-2">
                    <label>Age</label>
                    <input type="number" id="updateAge" class="form-control">
                </div>

                <div class="mb-2">
                    <label>Salary</label>
                    <input type="number" id="updateSalary" class="form-control">
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"
                        data-bs-dismiss="modal">Cancel
                </button>
                <button type="button" class="btn btn-success"
                        onclick="updateEmployee()">Update
                </button>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
</script>

<script>
    var employees = JSON.parse(localStorage.getItem("employees")) || [];

    function saveEmployee() {
        var nic = document.getElementById("nic").value.trim();
        var name = document.getElementById("name").value.trim();
        var age = document.getElementById("age").value.trim();
        var salary = document.getElementById("salary").value.trim();

        if (!nic || !name || !age || !salary) {
            alert("Please fill all fields");
            return;
        }

        for (var i = 0; i < employees.length; i++) {
            if (employees[i].nic === nic) {
                alert("NIC already exists");
                return;
            }
        }

        employees.push({nic: nic, name: name, age: age, salary: salary});
        localStorage.setItem("employees", JSON.stringify(employees));

        clearForm();
        renderTable(employees);
    }

    function renderTable(data) {
        var table = document.getElementById("employeeTable");
        table.innerHTML = "";

        if (data.length === 0) {
            table.innerHTML =
                "<tr><td colspan='5' class='text-muted'>No records found</td></tr>";
            return;
        }

        for (var i = 0; i < data.length; i++) {
            table.innerHTML +=
                "<tr>" +
                "<td>" + data[i].nic + "</td>" +
                "<td>" + data[i].name + "</td>" +
                "<td>" + data[i].age + "</td>" +
                "<td>" + data[i].salary + "</td>" +
                "<td>" +
                "<button class='btn btn-warning btn-sm me-1' onclick='openUpdate(" + i + ")'>Update</button>" +
                "<button class='btn btn-danger btn-sm' onclick='deleteEmployee(" + i + ")'>Delete</button>" +
                "</td>" +
                "</tr>";
        }
    }

    function deleteEmployee(index) {
        if (!confirm("Delete this employee?")) return;

        employees.splice(index, 1);
        localStorage.setItem("employees", JSON.stringify(employees));
        renderTable(employees);
    }

    function searchEmployee() {
        var value = document.getElementById("searchNic").value.trim().toLowerCase();

        if (value === "") {
            renderTable(employees);
            return;
        }

        var filtered = [];
        for (var i = 0; i < employees.length; i++) {
            if (employees[i].nic.toLowerCase().indexOf(value) !== -1) {
                filtered.push(employees[i]);
            }
        }

        renderTable(filtered);
    }

    function openUpdate(index) {
        var emp = employees[index];

        document.getElementById("updateIndex").value = index;
        document.getElementById("updateNic").value = emp.nic;
        document.getElementById("updateName").value = emp.name;
        document.getElementById("updateAge").value = emp.age;
        document.getElementById("updateSalary").value = emp.salary;

        new bootstrap.Modal(
            document.getElementById("updateModal")
        ).show();
    }

    function updateEmployee() {
        var index = document.getElementById("updateIndex").value;

        employees[index].name =
            document.getElementById("updateName").value;
        employees[index].age =
            document.getElementById("updateAge").value;
        employees[index].salary =
            document.getElementById("updateSalary").value;

        localStorage.setItem("employees", JSON.stringify(employees));
        renderTable(employees);

        bootstrap.Modal.getInstance(
            document.getElementById("updateModal")
        ).hide();
    }

    function clearForm() {
        document.getElementById("nic").value = "";
        document.getElementById("name").value = "";
        document.getElementById("age").value = "";
        document.getElementById("salary").value = "";
    }

    // INITIAL LOAD
    renderTable(employees);
</script>

</body>
</html>
