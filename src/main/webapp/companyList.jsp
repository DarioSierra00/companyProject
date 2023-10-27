<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.jacaranda.repository.DbRepository"%>
    <%@page import="com.jacaranda.model.Company"%>
     <%@page import="com.jacaranda.model.Employee"%>
     <%@page import="com.jacaranda.model.CompanyProject"%>
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
	ArrayList<Company> result = null;
	ArrayList<Employee> resultEmployee = null;
	try{
		result = (ArrayList<Company>) DbRepository.findAll(Company.class);
		ArrayList<CompanyProject> resulAux = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class); 
	}catch(Exception e){
		
	}
	%>
	<table class="table">
	<thead>
		<tr>
			<th scope="col">Id</th>
			<th scope="col">Nombre</th>
			<th scope="col">Address</th>
			<th scope="col">City</th>
			<th scope="col">Empleados</th>
		</tr>
	</thead>
	<% for (Company c: result){%>
			<tr>
				<td><%=c.getId() %></td>
				<td><%=c.getName() %></td>
				<td><%=c.getAddress() %></td>
				<td><%=c.getCity()%></td>
				<td><table class="table">
					<%
						for (Employee e: c.getListEmployee()){
						%>
						<tr>
						<td>
							<%=e.getFirstName()%>
						</td>
						<tr>
						<%}%>
					</table>	
					</tr>
		<%}%>			
	</table>
</body>
</html>