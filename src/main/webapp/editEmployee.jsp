<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
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
<%if(session.getAttribute("employee") == null){
	response.sendRedirect("./login.jsp");
	return;
}%>
<%Employee emp1 = (Employee) session.getAttribute("employee"); %>
<body>
<%@include file="nav.jsp" %>
<%
	Employee emp = null;
	ArrayList<Company> result = null;
	Boolean form = false;
	boolean password = false;
	
	if(emp1.getRole().toString().equalsIgnoreCase("Admin") || String.valueOf(emp1.getId()).equals(request.getParameter("id")) || !password){
		
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
		password = true;
	}
	if(request.getParameter("submit") != null){
		try{
			String name = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String gender = request.getParameter("gender");
			int id = 0;
			if(request.getParameter("password") != ""){
				emp.setPassword(request.getParameter("password"));
			}
			String role = request.getParameter("role");
			
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
			emp = new Employee(Integer.valueOf(request.getParameter("id")),name,lastName,email,gender,date,emp1.getPassword(),role,c);
		}catch(Exception e5){
			response.sendRedirect("error.jsp?msg="+ e5.getMessage());
			return;
		}
		DbRepository.editEntity(emp);
		
	}
%>

<%if(request.getParameter("comprobar") == null && request.getParameter("submit") == null){
	%>
	<div class="mainWrap">
	<form>
	<div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Old password</label> 
    <div class="col-8">
      <input id="oldPass" name="oldPass" type="text" class="form-control" required>
      <input id="id" name="id" type="text" class="form-control" value="<%=request.getParameter("id")%>" hidden>
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="comprobar" type="submit" class="btn btn-success">Comprobar</button>
    </div>
  </div>
	</form>
	</div>
<%}
else if(DigestUtils.md5Hex(request.getParameter("oldPass")).equals(emp.getPassword())){
%>
<div class="mainWrap">
<form>
       <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Id</label> 
    <div class="col-8">
      <input id="id" name="id" type="text" class="form-control" value="<%=request.getParameter("id")%>" readonly>
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
      <input id="email" name="email" type="text" class="form-control" value="<%=emp.getEmail() %>" readonly>
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
      <input id="date" name="date" type="date" class="form-control" value="<%=emp.getDateOfBirth()%>">
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Compañía</label> 
    <div class="col-8">
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
  </div> 
  	<div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Password</label> 
    <div class="col-8">
      <input id="date" name="password" type="password" class="form-control" placeholder="******">
    </div>
  </div>
  <%if(emp1.getRole().toString().equalsIgnoreCase("Admin")){%>
	  
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Role</label> 
    <div class="col-8">
      <input id="date" name="role" type="text" class="form-control" value="<%=emp1.getRole()%>">
    </div>
  </div>
 <%}else{%>
	  <div class="form-group row">
	    <label for="text5" class="col-4 col-form-label">Role</label> 
	    <div class="col-8">
	      <input id="date" name="role" type="text" class="form-control" value="<%=emp1.getRole()%>" readonly>
	    </div>
	  </div>
  <%}%>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-success">Editar empleado</button>
    </div>
  </div>
</form>
</div>
<%}
else{
	%>
	<div class="errorMessage">contraseña incorrecta</div>
<%
}

%>
</body>
</html>