<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
	<h3>Sign In</h3>
        <div>
            <form class="col" action="checkLoginDetails.jsp" method="POST">
                    <input class="field" type="text" id="username" name="username" placeholder="Username">
                    <input class="field" type="text" id="password" name="password" placeholder="Password">
                    <input type="submit" value="Submit"/>
            </form>
        </div>
        <a href="./Register.jsp">
            Create new account
        </a>
</body>
</html>