<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="login_page_funtionality.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
</head>
<body>

<div>
    <h1>Please login to continue</h1>
</div>

<form class="" method="post" id="" action="index.jsp">
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
<%--<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>--%>
</body>
</html>