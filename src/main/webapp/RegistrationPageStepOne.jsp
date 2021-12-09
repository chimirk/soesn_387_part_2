<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList errors = (ArrayList) request.getAttribute("errors");
%>
<%@ include file="components/header.jsp"%>
<div class="container">
    <div class="d-flex align-items-center justify-content-center">
        <form class="form-horizontal w-50 border border-3 rounded-3 border-primary p-4" action="${pageContext.request.contextPath}/SignUpP1Servlet" method="post">
            <% if (errors != null) { %>
            <div class="alert alert-danger" role="alert">
                <ul>
                    <% for (int i = 0; i < errors.size(); i++) { %>
                    <li><%= errors.get(i)%></li>
                    <% } %>
                </ul>
            </div>
            <% } %>
            <h1 class=" display-5 text-center">Registration Page Step 1</h1>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="new_username">Username</label>
                <input class="form-control" type="text" placeholder="Enter new username" id="new_username" name="new_username" required />
            </div>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="new_user_email">Email</label>
                <input class="form-control" type="email" placeholder="Enter email" id="new_user_email" name="new_user_email" required />
            </div>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="new_user_full_name">Full Name</label>
                <input class="form-control" type="text" placeholder="Enter full name" id="new_user_full_name" name="new_user_full_name" required />
            </div>
            <div class="d-grid gap-2 col-6 mx-auto">
                <button class="btn btn-primary" type="submit" name="register_step_one_btn" >Register</button>
            </div>
            <br/>
        </form>
    </div>
</div>
<%@include file="components/footer.jsp"%>