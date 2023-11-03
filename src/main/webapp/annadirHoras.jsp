<%@page import="java.time.chrono.ChronoLocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="org.hibernate.boot.model.relational.Database"%>
<%@page import="java.time.Duration"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.jacaranda.exception.UserException"%>
<%@page import="com.jacaranda.model.Project"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
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

	try{
		e = (Employee) session.getAttribute("employee");
	}catch(Exception e1){
		response.sendRedirect("error.jsp?msg="+ e1.getMessage());
		return;
	}
%>
	<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">A�adir horas</div>
		          </div>
		          <form>
            		<div class="form-floating mb-3">
						<select>
						Projects
						<% 
						for(CompanyProject cp : e.getCompany().getCompanyProject()){
							
						
							if(cp.getEnd().compareTo(Date.valueOf(LocalDate.now()))==1){
							%>
							
							<option value="<%=cp.getProject().getId()%>"><%=cp.getProject().getName()%></option>
							<%}} %>
						</select>
	
		            </div>
		            <div class="d-grid">
		            <% 
		            if(request.getParameter("login") == null){%>
		             	<button class="btn btn-success btn-lg" id="submitButton" value="login" type="submit" name="login">Go</button>
						<%} 
		            else{%>
		            	<% 
		            	LocalDateTime dateBegin = LocalDateTime.now();
		            	session.setAttribute("time", dateBegin);%>
			             	<button class="btn btn-warning btn-lg" id="submitButton" value="stop" type="submit" name="stop">Stop</button>
			             	
		           <% }
		            if(session.getAttribute("time") != null){
		            	
		            	int sec = (int) ChronoUnit.SECONDS.between((LocalDateTime) session.getAttribute("time"), LocalDateTime.now());
		            	out.println(sec);
		            }
						%>
						</div>
						</form>
		            </div>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
</body>
</html>