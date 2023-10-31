<%@page import="com.jacaranda.model.Project"%>
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
	ArrayList<Company> companies = null;
	ArrayList<Project> projects = null;
	try{
		companies = (ArrayList<Company>) DbRepository.findAll(Company.class);
		projects = (ArrayList<Project>) DbRepository.findAll(Project.class);
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg="+ e.getMessage());
		return;
	}
%>
<div class="mainWrap">
<form>
  <div class="form-group row">
    <label for="text1" class="col-4 col-form-label">Company</label> 
    <div class="col-8">
      <select name="company">
    <%
    	for(Company c : companies){
    	
    %>		<option value="<%=c.getId()%>"><%=c.getName()%></option>
    	<% }
    %>
    	
    </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="text2" class="col-4 col-form-label">Project</label> 
    <div class="col-8">
      <select name="project">
    <%
    	for(Project p : projects){
    	
    %>		<option value="<%=p.getId()%>"><%=p.getName()%></option>
    	<% }
    %>
    	
    </select>
    </div>
  </div>
  <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">Begin</label> 
    <div class="col-8">
      <input id="begin" name="begin" type="date" class="form-control">
    </div>
  </div>
   <div class="form-group row">
    <label for="text5" class="col-4 col-form-label">End</label> 
    <div class="col-8">
      <input id="end" name="end" type="date" class="form-control">
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-success">Add companyProject</button>
    </div>
  </div>
</form>
</div>

	<%
	try{
		if(request.getParameter("submit") != null){
			Company company = DbRepository.find(Company.class, Integer.valueOf(request.getParameter("company")));
			Project project = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("project")));
			Date begin = null;
			Date end = null;
			try{
				begin = Date.valueOf(request.getParameter("begin"));
				end = Date.valueOf(request.getParameter("end"));
			}catch(Exception e){
				response.sendRedirect("error.jsp?msg=Error en la fecha introducida");
				return;
			}

			CompanyProject cp = new CompanyProject(company,project,begin,end);
			DbRepository.addEntity(cp);
		}
		
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg="+ e.getMessage());
		return;
	}
	%>
</body>
</html>