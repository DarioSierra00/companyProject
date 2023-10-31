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
<body>
<%@include file="nav.jsp" %>
<%
	Employee e = null;
	Employee emp = null;
	ArrayList<Company> result = null;
	try{
		result = (ArrayList<Company>) DbRepository.findAll(Company.class);
	}catch(Exception e1){
		response.sendRedirect("error.jsp?msg="+ e1.getMessage());
		return;
	}
	
	try{
		emp = DbRepository.find(Employee.class, Integer.valueOf(request.getParameter("id")));
	}catch(Exception e2){
		response.sendRedirect("error.jsp?msg="+ e2.getMessage());
		return;
	}
	if(request.getParameter("submit") != null){
		try{
			String name = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String gender = request.getParameter("gender");
			int id = 0;
			
			try{
				id = Integer.valueOf(request.getParameter("nameCompany"));
			}catch(Exception e3){
				response.sendRedirect("error.jsp?msg= Id de compañia incorrecto");
				return;
			}
			Date date;
			
			try{
				date = Date.valueOf(request.getParameter("date"));
			}catch(Exception e4){
				response.sendRedirect("error.jsp?msg= Fecha erronea formato adecuado : yyyy-mm-dd");
				return;
			}
			
			Company c = DbRepository.find(Company.class,id);
			e = new Employee(Integer.valueOf(request.getParameter("id")),name,lastName,email,gender,date,c);
		}catch(Exception e5){
			response.sendRedirect("error.jsp?msg="+ e5.getMessage());
			return;
		}
		DbRepository.editEntity(e);
	}
	try{
		
	}catch(Exception e6){
		response.sendRedirect("error.jsp?msg= Id de compañia no correcto");
		return;
	}

%>
	<div class="mainWrap">
<form>
       <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">First name</label> 
    <div class="col-8">
      <input id="id" name="id" type="text" class="form-control" value="<%=request.getParameter("id")%>" hidden>
    </div>
  </div>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">First name</label> 
    <div class="col-8">
      <input id="firstName" name="firstName" type="text" class="form-control" value="<%=emp.getFirstName() %>" required>
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Last name</label> 
    <div class="col-8">
      <input id="lastName" name="lastName" type="text" class="form-control" value="<%=emp.getLastName() %>" required>
    </div>
  </div>
  <div class="form-group row">
    <label for="text3" class="col-4 col-form-label">Email</label> 
    <div class="col-8">
      <input id="email" name="email" type="text" class="form-control" value="<%=emp.getEmail() %>">
    </div>
  </div>
  <div class="form-group row">
    <label for="text4" class="col-4 col-form-label">Gender</label> 
    <div class="col-8">
      <input id="gender" name="gender" type="text" class="form-control" value="<%=emp.getGender() %>">
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">DateOfBirth</label> 
    <div class="col-8">
      <input id="date" name="date" type="date" class="form-control" value="<%=emp.getDateOfBirth() %>">
    </div>
  </div>
  <div class="form-group row">
    Compañia
    <select name="nameCompany">
    <%
    	for(Company c : result){
    		if(c.getId() == emp.getCompany().getId()){
    %>		<option value="<%=c.getId() %>" selected><%=c.getName()%></option>
    	<% 	}
    		else{
    		%>
    		<option><%=c.getName() %></option>
    		<% 
    	 }}
    %>
    	
    </select>
  </div> 
  	
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-success">Editar empleado</button>
    </div>
  </div>
</form>
</div>
</body>
</html>