<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
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
<%@include file="nav.jsp" %>
<%
	ArrayList<Company> result = null;
	try{
		result = (ArrayList<Company>) DbRepository.findAll(Company.class);
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg="+ e.getMessage());
		return;
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
    <label for="text5" class="col-4 col-form-label">Company</label> 
        <div class="col-8">
    
    <select name="nameCompany">
    <%
    	for(Company c : result){
    	
    %>		<option name="company" value="<%=c.getId()%>"><%=c.getName()%></option>
    	<% }
    %>
    	
    </select>
    </div>
  </div> 
  	<div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Password</label> 
    <div class="col-8">
      <input id="password" name="password1" type="text" placeholder="Introduzca su contraseña" class="form-control">
    </div>
  </div>
  	<div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Password</label> 
    <div class="col-8">
      <input id="password" name="password2" type="text" placeholder="Introduzca de nuevo su contraseña" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-success">Añadir empleado</button>
    </div>
  </div>
</form>
</div>

	<%
	try{
		if(request.getParameter("submit") != null){
			String name = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String gender = request.getParameter("gender");
			Date date = null;
			String password = request.getParameter("password1");
			String passwordValidate = request.getParameter("password2");
			String encriptPassword = null;
			try{
				date = Date.valueOf(request.getParameter("date"));
			}catch(Exception e){
				response.sendRedirect("error.jsp?msg=Error en la fecha introducida");
				return;
			}
			
			if(password.equals(passwordValidate)){
				try{
					encriptPassword = String.valueOf(DigestUtils.md5(password));
				}catch(Exception e){
					response.sendRedirect("error.jsp?msg=Error en la contraseña");
					return;
				}
				
			}
			int id = Integer.valueOf(request.getParameter("nameCompany"));
			
			Company c = DbRepository.find(Company.class, id);
			Employee e = new Employee(name,lastName,email,gender,date,encriptPassword,c);
			DbRepository.addEntity(e);
		}
		
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg="+ e.getMessage());
		return;
	}
	%>
</body>
</html>