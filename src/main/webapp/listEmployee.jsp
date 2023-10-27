<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.jacaranda.repository.DbRepository"%>
    <%@page import="com.jacaranda.model.Employee"%>
    <%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>

<%
	ArrayList<Employee> result = null;
	try{
		result = (ArrayList<Employee>) DbRepository.findAll(Employee.class);
	}catch(Exception e){
		
	}
	%>
	<table class="table">
	<thead>
		<tr>
			<th scope="col">Id</th>
			<th scope="col">Nombre</th>
			<th scope="col">Apellidos</th>
			<th scope="col">Email</th>
			<th scope="col">Género</th>
			<th scope="col">Fecha de nacimiento</th>
			<th scope="col">Nombre compañia</th>
		</tr>
	</thead>
	<% for (Employee e: result){%>
			<tr>
				<td><%=e.getId() %></td>
				<td><%=e.getFirstName() %></td>
				<td><%=e.getLastName() %></td>
				<td><%=e.getEmail()%></td>
				<td><%=e.getGender() %></td>
				<td><%=e.getDateOfBirth() %></td>
				<td><%=e.getCompany().getName()%></td>
				</tr>
	<% }%>
</table>
</body>
</html>