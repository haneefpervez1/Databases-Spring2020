<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Register</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<a href="./Login.jsp">
        Login
    </a>
    <h3>Register</h3>
    <form class="col" action="sendRegistrationDetails.jsp" method="POST"> 
            <input class="field" type="text" id="username" name="username" placeholder="Username">
            <input class="field" type="text" id="password" name="password" placeholder="Password">
            <select id="role" name="role">
            	<option value="Customer">Customer</option>
            	<option value="Customer Representative">Customer Representative</option>
            	<option value="Manager">Manager</option>
            </select>
            <input type="submit" value="Submit"/>
    </form>
</body>
</html>