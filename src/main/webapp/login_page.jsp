<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList errors = (ArrayList) request.getAttribute("errors");
%>

<html>
<head>
    <title>Login Page</title>
</head>
<body>

<div>
    <h1>Please login to continue</h1>
</div>

<form class="" method="post" id="" action="${pageContext.request.contextPath}/LoginServlet">
    <div class="" role="alert">
        <%--Display error--%>
        <% if (errors != null) { %>
        <% for (int i = 0; i < errors.size(); i++) { %>
        <p><%= errors.get(i)%></p>
        <% } %>
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
        Not yet a member? <a href="${pageContext.request.contextPath}/LoginServlet?signup=TRUE">Sign up</a>
    </p>

</form>
</body>
</html>