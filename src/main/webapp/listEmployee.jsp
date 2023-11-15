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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./styleSheet.css">
</head>
<%if(session.getAttribute("employee") == null){
	response.sendRedirect("./login.jsp");
	return;
}%>
<body>
<%@include file="nav.jsp" %>
<%
	ArrayList<Employee> result = null;
	Employee emp = (Employee) session.getAttribute("employee");
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
				<%if(emp.getRole().toString().equalsIgnoreCase("Admin")){ %>
				<td><a href="editEmployee.jsp?id=<%=e.getId()%>"><button type="button">Edit</button></a></td>
				<td><a href="deleteEmployee.jsp?id=<%=e.getId()%>"><button type="button">Delete</button></a></td>
				</tr>
				<% }else{
					if(e.getId() == emp.getId()){%>
						<td><a href="editEmployee.jsp?id=<%=e.getId()%>"><button type="button">Edit</button></a></td>
						</tr>
					<%}
				}
				
	}%>
</table>
</body>
</html>