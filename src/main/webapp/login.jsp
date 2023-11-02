<%@page import="com.jacaranda.exception.UserException"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="com.jacaranda.model.User" %>
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
<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Login</div>
		          </div>
		          <form>
            		<div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">User</label>
						<input type="text" class="form-control" id="user" name="user" placeholder="Enter your user" required>
		            </div>
		           	<div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Password</label>
						<input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
		            </div>          
		            <div class="d-grid">
		             	<button class="btn btn-success btn-lg" id="submitButton" value="login" type="submit" name="login">Login</button>
						<%
							if(request.getParameter("login") != null){
								User userFind = DbRepository.find(User.class, request.getParameter("user"));
								if(userFind != null && userFind.getPassword().equals(request.getParameter("password"))){
									session.setAttribute("rol", userFind.getRole());
									response.sendRedirect("./listEmployee.jsp");
								}else{
									%>
										<div class="errorMessage"></div>
									<%
								}
							}
						%>
		            </div>
		          </form>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
<body>
</html>