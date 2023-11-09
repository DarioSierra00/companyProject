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
/*Primeramente comprobamos que el usuario que acceda a la pagina tenga rol, si tiene rol, asignamos al empleado la
session del empleado, si no tiene rol, te redirige al login para iniciar sesion*/
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
<%
	/*Creamos un mapa con una key Integer, que será la clave primaria del proyecto y de valor el tiempo.
	Cuando la session del mapWork sea diferente de nulo, al mapa le asignamos la session de mapWork y el mapa tendrá
	los valores de los proyectos en los que estemos trabajando*/

	Map<Integer, LocalDateTime> inWork = new HashMap<Integer, LocalDateTime>();
	if(session.getAttribute("mapWork") != null){
		inWork = (HashMap<Integer,LocalDateTime>) session.getAttribute("mapWork");
	}
	
	/*Cuando pulsemos el botón de start de un proyecto, haremos un put al mapa para introducir los valores del proyecto.
	Le asignamos el id del proyecto en el que estamos trabajando y el tiempo, el del momento en el que pulso el boton.
	Luego la session de mapWork, la actualizo con el mapa que tiene el proyecto introducido*/
	
	if(request.getParameter("start") != null){
		try{
	        inWork.put(Integer.valueOf(request.getParameter("start")), LocalDateTime.now());
	        session.setAttribute("mapWork", inWork);
		}catch(Exception e1){
			response.sendRedirect("./error.jsp?error="+e1.getMessage());
			return;
		}
    }
	
	/*Cuando pulsemos el boton de stop en algun proyecto, inicializamos las variables que nos haran falta para
	crear o editar el employeeProject*/
	else if(request.getParameter("stop") != null){
		Project project = null;
		int sec = 0;
		EmployeeProject emp;
			
		/*A la variable de segundos le hacemos el calculo entre el tiempo que tiene el proyecto que hemos pulsado
		(Lo comprobamos en el mapa, haciendo un get), y el tiempo de ahora. Esto nos dará los segundos que hay
		entre el momento en el que pulso el boton de start y el de stop, tambien busco el proyecto y creo el EmployeeProject*/
			try{
				sec = (int) ChronoUnit.SECONDS.between(inWork.get(Integer.valueOf(request.getParameter("stop"))), LocalDateTime.now());
				project = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("stop")));
				emp = new EmployeeProject(project,e,sec);
			}catch(Exception e1){
				response.sendRedirect("./error.jsp?error="+e1.getMessage());
				return;
			}
			/*Cuando encuentre el EmployeeProject, le asignamos al EmployeeProject los segundos a los que ya tiene
			y editamos el EmployeeProject, y si no encuentra el EmployeeProject lo añadimos*/
			if(DbRepository.find(emp) != null){
				emp.setMinutes(DbRepository.find(emp).getMinutes()+sec);
				DbRepository.editEntity(emp);
			}
			else{
				DbRepository.addEntity(emp);
			}
			//Borramos el atributo de la session
			session.removeAttribute("sec");
			
			try{
				inWork.remove(Integer.valueOf(request.getParameter("stop")));
				session.setAttribute("mapWork", inWork);
			}catch(Exception e1){
				response.sendRedirect("./error.jsp?error="+e1.getMessage());
				return;
			}
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
		            <form method="get">
		            <div class="form-floating mb-3">
		    			<label for="exampleInputEmail1" class="form-label">Company</label>
		    			<input type="text" class="form-control" id="user" name="user" placeholder="Enter Id" value="<%=e.getCompany().getName() %>" readonly>
		            </div>			
			            <div class="form-floating mb-3">
			                <label for="exampleInputEmail1" class="form-label">Project</label>
			                <table class="table">
							<%
								for (CompanyProject c : e.getCompany().getCompanyProject()){
									if(c.getEnd().after(Date.valueOf(LocalDate.now()))){								
										%>
								 			 <tr>
								 			 	<td><%=c.getProject().getName()%></td>
								 			 	<%if(!inWork.containsKey(c.getProject().getId())){ %>
								 			 	<td><button class="btn btn-info btn-lg" id="start" type="submit" name="start" value="<%=c.getProject().getId() %>">Start work</button></td>
								 			 	<%}
								 			 	else{
								 			 	%>
									 			 	<td><button class="btn btn-danger btn-lg" id="stop" type="submit" name="stop" value="<%=c.getProject().getId() %>">Stop work</button></td>
								 			 	<%}
								 			 	%>
								 			 </tr>						
								 		<%}}%>
							</table>
			            </div>
			            </form>
						</div>
		            </div>
		        </div>
		      </div>
		    </div>
</body>
</html>