<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList errors = (ArrayList) request.getAttribute("errors");
%>
<%@ include file="components/header.jsp"%>
<div class="container">
    <div class="d-flex align-items-center justify-content-center">
        <form class="form-horizontal w-50 border border-3 rounded-3 border-primary p-4" action="${pageContext.request.contextPath}/ActivateAccountForgetPassword" method="post">
            <% if (errors != null) { %>
            <div class="alert alert-danger" role="alert">
                <ul>
                    <% for (int i = 0; i < errors.size(); i++) { %>
                    <li><%= errors.get(i)%></li>
                    <% } %>
                </ul>
            </div>
            <% } %>
            <h1 class=" display-5 text-center">Forgot Password Page Step 1</h1>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="fp_email">Email</label>
                <input class="form-control" type="email" placeholder="Enter the email related to your account" id="fp_email" name="fp_email" required />
            </div>
            <div class="d-grid gap-2 col-6 mx-auto">
                <button class="btn btn-primary" type="submit" name="fp_step_one_btn" >Submit</button>
            </div>
            <br/>
        </form>
    </div>
</div>
<%@include file="components/footer.jsp"%>