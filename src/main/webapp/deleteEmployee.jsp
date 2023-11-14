<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
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
<%if(session.getAttribute("rol") == null){
	response.sendRedirect("./login.jsp");
}%>
<body>
<%@include file="nav.jsp" %>
<%

	Employee emp = null;
	try{
		emp = DbRepository.find(Employee.class, Integer.valueOf(request.getParameter("id")));
	}catch(Exception e2){
		response.sendRedirect("error.jsp?msg="+ e2.getMessage());
		return;
	}
	if(request.getParameter("submit") != null){
		DbRepository.deleteEntity(Employee.class, Integer.valueOf(request.getParameter("id")));
		
	try{
		
	}catch(Exception e6){
		response.sendRedirect("error.jsp?msg= Id de compañia no correcto");
		return;
	}}

%>
	<div class="mainWrap">
<form>
       <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">First name</label> 
    <div class="col-8">
      <input id="id" name="id" type="text" class="form-control" value="<%=request.getParameter("id")%>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">First name</label> 
    <div class="col-8">
      <input id="firstName" name="firstName" type="text" class="form-control" value="<%=emp.getFirstName() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Last name</label> 
    <div class="col-8">
      <input id="lastName" name="lastName" type="text" class="form-control" value="<%=emp.getLastName() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text3" class="col-4 col-form-label">Email</label> 
    <div class="col-8">
      <input id="email" name="email" type="text" class="form-control" value="<%=emp.getEmail() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text4" class="col-4 col-form-label">Gender</label> 
    <div class="col-8">
      <input id="gender" name="gender" type="text" class="form-control" value="<%=emp.getGender() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">DateOfBirth</label> 
    <div class="col-8">
      <input id="date" name="date" type="date" class="form-control" value="<%=emp.getDateOfBirth() %>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Company</label> 
    <div class="col-8">
      <input id="company" name="company" type="text" class="form-control" value="<%=emp.getCompany().getName()%>" readonly>
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-success">Borrar empleado</button>
    </div>
  </div>
</form>
</div>
</body>
</html>