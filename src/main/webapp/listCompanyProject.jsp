<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%@include file="nav.jsp" %>
<%
	ArrayList<Company> result = null;
	ArrayList<CompanyProject> result2 = null;
			try{
				result = (ArrayList<Company>) DbRepository.findAll(Company.class);
				result2 = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);
			
	
	%>
	<table class="table">
		<thead>
			<tr>
				<th scope="col">Nombre</th>
				<th scope="col">Num empleados</th>
				<th scope="col">Num proyectos</th>
			</tr>
		</thead>
		<%
		for (Company c: result){
		%>
				<tr>
					<td><%=c.getName()%></td>
					<td><%=c.getEmployees().size()%></td>
					<td><%=c.getCompanyProject().size()%></td>
					<tr>
					<table class="table">
					<td><b>Empleados</b></td></tr>
						<%
							for (Employee e: c.getEmpleados()){
						%>
						<tr>
						<td><%=e.getFirstName()%></td>
						<td><%=e.getLastName()%></td>
						<%}%>
						<tr><td><b>Proyectos</b></td></tr>
						<%
							for(CompanyProject cp : c.getCompanyProject()){
								%>
								<tr>
								<td><%=cp.getProject().getName()%></td>
								<td><%=cp.getProject().getBudget()%></td>
								<%}%>
						
					</table>	
					<td>
		<%}%>			
	</table>
	<%}catch(Exception e){
		response.sendRedirect("error.jsp?msg="+ e.getMessage());
		return;
		
	 } %>
</body>
</html>