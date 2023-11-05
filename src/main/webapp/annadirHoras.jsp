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
		            <div class="h1 fw-light">Añadir horas</div>
		          </div>
		          <form>
		          <!-- Cuando no hayamos pulsado el boton de start entrará -->
		          <%if(request.getParameter("start") == null){ %>
            		<div class="form-floating mb-3">
            		Projects
						<select name="project">
						
						<% 
						//Recorremos la lista de proyectos en los que está el empleado
						for(CompanyProject cp : e.getCompany().getCompanyProject()){
							
						//Si el proyecto ya ha finalizado no nos aparecerá
							if(cp.getEnd().after(Date.valueOf(LocalDate.now()))){
							%>
							<!-- Aqui nos apareceran los proyectos no finalizados -->
							<option value="<%=cp.getProject().getId()%>"><%=cp.getProject().getName()%></option>
							<%}} %>
						</select>
		            </div>
		            
		            <%
		            //Cuando pulsemos el boton de start
		          }else if(request.getParameter("start") != null){
		        	  //Nos buscará el proyecto que hemos seleccionado en el desplegable
		            	Project p = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("project")));
		            	%>
		            	<!-- Aqui ponemos un input readonly para ver que proyecto hemos elegido -->
		            	<input type="text" name="nameProject" id="nameProject" value="<%=p.getName()%>" readonly>
		            	<!-- Aqui ponemos un input hidden para coger el id de ese proyecto -->
		            	<input type="text" name="idProject" id="idProject" value="<%=p.getId()%>" hidden>
		            	<% 
		            	
		            }
		            %>
		            <div class="d-grid">
		            <% 
		            //Cuando no hayamos pulsado el start saldrá este botón para empezar a contar
		            if(request.getParameter("start") == null){%>
		             	<button class="btn btn-success btn-lg" id="submitButton" value="start" type="submit" name="start">Start</button>
						<%} 
		            else{%>
		            	<% 
		            	//En el momento que le demos al botón de start, asignamos a una variable el valor del tiempo en el momento de pulsar el boton
		            	LocalDateTime dateBegin = LocalDateTime.now();
		            	//Asignamos a la session time, la variable anterior
		            	session.setAttribute("time", dateBegin);
		            	//Asignamos a la session cont el valor 0
		            	session.setAttribute("cont", 0);
		            	//Creamos el botón save
		            	%>
			             	<button class="btn btn-warning btn-lg" id="submitButton" value="save" type="submit" name="save">Save</button>
			             	
		           <% }
		            //Cuando la session time tenga un valor y hayamos pulsado el boton de save, entrará
		            if(session.getAttribute("time") != null && request.getParameter("save") != null){
		            	
		            	//Asignamos a una variable el tiempo que hay entre el valor de la session que guardamos antes en time y el valor del tiempo de ahora
		            	int sec = (int) ChronoUnit.SECONDS.between((LocalDateTime) session.getAttribute("time"), LocalDateTime.now());
		            	//Asignamos a la session cont el valor de sec
		            	session.setAttribute("cont", sec);
						
		            	//Asignamos a una variable de project 
		            	Project project = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("idProject")));
		            	int min = (int) session.getAttribute("cont");
		            	
		            	int trueMin = min * 60;
		            	
		            	
		            	
		            	EmployeeProject emp = new EmployeeProject(project,e,trueMin);
		            	if(DbRepository.find(emp) != null){
		            		emp.setMinutes(DbRepository.find(emp).getMinutes()+trueMin);
		            		DbRepository.editEntity(emp);
		            	}
		            	else{
		            		DbRepository.addEntity(emp);
		            	}
		
		            	session.removeAttribute("cont");
		            	session.removeAttribute("time");
		            }
						%>
						</div>
						</form>
		            </div>
		        </div>
		      </div>
		    </div>
		  </div>
</body>
</html>