<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<%@ include file="components/header.jsp"%>
<div class="container">
    <div class="d-flex align-items-center justify-content-center">
        <div class="card">
            <div class="card-body">
                <h1 class="display-1 text-danger">Sorry an error occurred!!!</h1>
            </div>
            <div class="card-body">
                <% if(request.getAttribute("javax.servlet.error.message") != null) { %>
                <h1 class="display-6 text-danger"> <%= request.getAttribute("javax.servlet.error.message")  %></h1>
                <% }else { %>
                <h1 class="display-6 text-danger"> <%= exception.getMessage()  %></h1>
                <% } %>
            </div>
        </div>
        <br/>
    </div>
</div>
<%@ include file="components/footer.jsp"%>