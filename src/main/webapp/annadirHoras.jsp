<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.jacaranda.model.EmployeeProject"%>
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
if(session.getAttribute("rol") != null){
	
	try{
		e = (Employee) session.getAttribute("employee");
	}catch(Exception e1){
		response.sendRedirect("error.jsp?msg="+ e1.getMessage());
		return;
	}
}
else{
	response.sendRedirect("./login.jsp");
}
%>
<%if(session.getAttribute("employee") !=null ){ 
	Map<Integer, LocalDateTime> inWork = new HashMap<Integer, LocalDateTime>();
%>

	<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Añadir horas</div>
		          </div>
		            <form method="get">
		            <div class="form-floating mb-3">
		    			<label for="exampleInputEmail1" class="form-label">Company</label>
		    			<input type="text" class="form-control" id="user" name="user" placeholder="Enter Id" value="<%=e.getCompany().getName() %>" readonly>
		            </div>
					<%if(request.getParameter("start")==null && session.getAttribute("time") == null) {
						%>						
			            <div class="form-floating mb-3">
			                <label for="exampleInputEmail1" class="form-label">Project</label>
			                <table class="table">
							<%
								for (CompanyProject c : e.getCompany().getCompanyProject()){
									if(c.getEnd().after(Date.valueOf(LocalDate.now()))){								
										%>
								 			 <tr>
								 			 	<td><%=c.getProject().getName()%></td>
								 			 	<%if(request.getParameter("start") == null){ %>
								 			 	<td><button class="btn btn-info btn-lg" id="start" type="submit" name="start" value="">Start work</button></td>
								 			 	<%}
								 			 	else if(request.getParameter("start") != null){%>
									 			 	<td><button class="btn btn-danger btn-lg" id="stop" type="submit" name="stop">Stop work</button></td>
								 			 	<%}
								 			 	%>
								 			 </tr>						
								 		<%}}%>
							</table>
			            </div>
			            </form>
			            
			            <%if(request.getParameter("start") != null){
			            	
			            }%>
						</div>
		            </div>
		        </div>
		      </div>
		    </div>
		    <%}} %>
</body>
</html>