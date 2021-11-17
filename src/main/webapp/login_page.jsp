<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList errors = (ArrayList) request.getAttribute("errors");
%>
<%@ include file="components/header.jsp"%>
<div class="container">
    <div class="d-flex align-items-center justify-content-center">
        <form class="form-horizontal w-50 border border-3 rounded-3 border-primary p-4" action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <% if (errors != null) { %>
            <div class="alert alert-danger" role="alert">
                <ul>
                <% for (int i = 0; i < errors.size(); i++) { %>
                <li><%= errors.get(i)%></li>
                <% } %>
                </ul>
            </div>
            <% } %>
            <h1 class=" display-5 text-center">Login to Manage Polls</h1>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="username">Username</label>
                <input class="form-control" type="text" placeholder="Enter your username" id="username" name="username" required />
            </div>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="userpassword">Password</label>
                <input class="form-control" id="userpassword" type="password" placeholder="Enter your password" name="userpassword" required/>
            </div>
            <div class="d-grid gap-2 col-6 mx-auto">
                <button class="btn btn-primary" type="submit" name="login_btn" >Login</button>
            </div>
        </form>
    </div>
</div>
<%@include file="components/footer.jsp"%>