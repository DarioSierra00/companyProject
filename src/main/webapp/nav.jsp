<!DOCTYPE html>
<html lang="en">
<head>
  <title>Nav</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="javascript:void(0)">EmployeeCompany</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mynavbar">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class=" nav-link" href="./listEmployee.jsp">List Employee</a>
        </li>
        <li class="nav-item">
          <a class=" nav-link" href="./companyList.jsp">List Company</a>
        </li>
        <li class="nav-item">
          <a class=" nav-link" href="./listCompanyProject.jsp">List CompanyProject</a>
        </li>
        <li class="nav-item">
          <a class=" nav-link" href="./addEmployee.jsp">Add Employee</a>
        </li>
        <li class="nav-item">
          <a class=" nav-link" href="./addCompanyProject.jsp">Add CompanyProject</a>
        </li>
        <li class="nav-item">
          <a class=" nav-link" href="./annadirHoras.jsp">Add Hours</a>
        </li>
      </ul>
      <form class="d-flex">
        <button class="btn btn-danger" type="button">LogOut</button>
      </form>
    </div>
  </div>
</nav>
</body>
</html>