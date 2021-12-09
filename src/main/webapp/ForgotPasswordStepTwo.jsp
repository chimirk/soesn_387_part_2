<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList errors = (ArrayList) request.getAttribute("errors");
    String userName;
    String token = null;
    if (request.getAttribute("userName") != null) {
        userName = (String) request.getAttribute("userName");
    } else {
        userName = request.getParameter("userName");
    }
    if (request.getAttribute("forgotPassToken") != null) {
        token = (String) request.getAttribute("forgotPassToken");
    }
%>
<%@ include file="components/header.jsp"%>
<div class="container">
    <div class="d-flex align-items-center justify-content-center">
        <form class="form-horizontal w-50 border border-3 rounded-3 border-primary p-4" action="${pageContext.request.contextPath}/ForgotPasswordP2Servlet" method="post">
            <% if (errors != null) { %>
            <div class="alert alert-danger" role="alert">
                <ul>
                    <% for (int i = 0; i < errors.size(); i++) { %>
                    <li><%= errors.get(i)%></li>
                    <% } %>
                </ul>
            </div>
            <% } %>
            <h1 class=" display-5 text-center">Forgot Password: Enter New Password</h1>
            <% if (userName != null) { %>
            <input type="hidden" name="userName" value="<%= userName%>">
            <% } %>
            <% if (token != null) { %>
            <input type="hidden" name="forgotPassToken" value="<%= token%>">
            <% } %>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="fp_password_one">Password</label>
                <input class="form-control" id="fp_password_one" type="password" placeholder="Enter new password" name="fp_password_one" required/>
            </div>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="fp_password_two">Repeat Password</label>
                <input class="form-control" id="fp_password_two" type="password" placeholder="Repeat Password" name="fp_password_two" required/>
            </div>
            <div class="d-grid gap-2 col-6 mx-auto">
                <button class="btn btn-primary" type="submit" name="save_password_btn" >Register New Password</button>
            </div>
            <br/>
        </form>
    </div>
</div>
<%@include file="components/footer.jsp"%>