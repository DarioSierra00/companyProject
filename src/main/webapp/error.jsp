<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="nav.jsp" %>
	<h1 class="text-info" align="center"><%=request.getParameter("msg") %></h1>
</body>
</html>