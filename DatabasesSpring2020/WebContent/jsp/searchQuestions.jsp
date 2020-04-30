<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search Questions</title>
</head>
<body>
	<h3>Search Questions</h3>
	<form action="getQuestions.jsp" method="POST">
		<input type="text" id="search" name="search" placeholder="Search...">
		<input type="submit" value="Submit"/>
	</form>
</body>
</html>