<%--
  Created by IntelliJ IDEA.
  User: tigerrrr
  Date: 11/10/2021
  Time: 4:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="login_page_funtionality.jsp"%>
<html>
<head>
    <title>Login Page</title>
</head>
<body>

<div>
    <h1>Please login to continue</h1>
</div>

<form class="" method="post" id="" action="login_page.jsp">
    <div class="" role="alert">
        <%--Display error--%>
        <% for (int i = 0; i < errors.size(); i++) { %>
        <p><%= errors.get(i)%></p>
        <% } %>

    </div>

    <div class="">
        <label class="" for="username">Username</label>
        <input type="text" id="username" class="" name="username">
    </div>

    <div class="">
        <label class="" for="userpassword">Password</label>
        <input type="password" id="userpassword" name="userpassword">
    </div>

    <div class="">
        <button type="submit" class="" name="login_btn">Login</button>
    </div>

    <p class="">
        Not yet a member? <a href="">Sign up</a>
    </p>

</form>
</body>
</html>
