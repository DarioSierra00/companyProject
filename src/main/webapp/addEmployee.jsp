<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./styleSheet.css">
</head>
<body>
<%
	ArrayList<Company> result = null;
	try{
		result = (ArrayList<Company>) DbRepository.findAll(Company.class);
	}catch(Exception e){
		
	}
%>
<div class="mainWrap">
<form>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">First name</label> 
    <div class="col-8">
      <input id="firstName" name="firstName" type="text" class="form-control" required>
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Last name</label> 
    <div class="col-8">
      <input id="lastName" name="lastName" type="text" class="form-control" required>
    </div>
  </div>
  <div class="form-group row">
    <label for="text3" class="col-4 col-form-label">Email</label> 
    <div class="col-8">
      <input id="email" name="email" type="text" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label for="text4" class="col-4 col-form-label">Gender</label> 
    <div class="col-8">
      <input id="gender" name="gender" type="text" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">DateOfBirth</label> 
    <div class="col-8">
      <input id="date" name="date" type="date" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    Compañia
    <select name="nameCompany">
    <%
    	for(Company c : result){
    	
    %>		<option><%=c.getName()%></option>
    	<% }
    %>
    	
    </select>
  </div> 
  	
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-success">Añadir empleado</button>
    </div>
  </div>
</form>
</div>

	<%
	
		if(request.getParameter("submit") != null){
			Employee e = new Employee(request.getParameter("firstName"),request.getParameter("lastName"),request.getParameter("email"), request.getParameter("gender"), Date.valueOf(request.getParameter("date")),DbRepository.getCompany(request.getParameter("nameCompany")));
			DbRepository.addEmployee(e);
		}
	%>
</body>
</html>