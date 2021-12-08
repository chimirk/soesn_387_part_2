<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList errors = (ArrayList) request.getAttribute("errors");
    String userName = null;
    if (session.getAttribute("loggedInUser") != null) {
        userName = (String) session.getAttribute("loggedInUser");
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
            <h1 class=" display-5 text-center">Change Password Page</h1>
            <% if (userName != null) { %>
            <input type="hidden" name="userName" value="<%= userName%>">
            <% } %>

            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="cp_oldpassword">Old Password</label>
                <input class="form-control" id="cp_oldpassword" type="password" placeholder="Enter the old password" name="cp_oldpassword" required/>
            </div>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="cp_password_one">Password</label>
                <input class="form-control" id="cp_password_one" type="password" placeholder="Enter new password" name="cp_password_one" required/>
            </div>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="cp_password_two">Repeat Password</label>
                <input class="form-control" id="cp_password_two" type="password" placeholder="Repeat Password" name="cp_password_two" required/>
            </div
            <div class="d-grid gap-2 col-6 mx-auto">
                <button class="btn btn-primary" type="submit" name="save_password_btn" >Complete Registration</button>
            </div>
            <br/>
        </form>
    </div>
</div>
<%@include file="components/footer.jsp"%>