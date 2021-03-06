<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="AccessServicePage.jsp"%>
<%@ include file="components/header.jsp"%>
<%
    String errorMessage = (String) request.getSession().getAttribute("errorMessage");
    request.getSession().removeAttribute("errorMessage");
%>
<div class="container">
    <div class="d-flex align-items-center justify-content-center">
        <form class="form-horizontal w-50 border border-3 rounded-3 border-primary p-4" action="AccessServicePage.jsp" method="post">
            <% if (errorMessage != null) { %>
            <div class="alert alert-danger" role="alert">
                <ul>
                    <li><%= errorMessage%></li>
                </ul>
            </div>
            <% } %>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="pollID">Poll ID</label>
                <input class="form-control" id="pollID" type="text" placeholder="Enter Poll ID" name="pollID" required />
            </div>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="voterPin">Pin # (Optional)</label>
                <input class="form-control" id="voterPin" type="number" placeholder="Enter your pin number" name="voterPin" />
            </div>
            <div class="d-grid gap-2 col-6 mx-auto">
                <button class="btn btn-primary" type="submit" name="access" value="access"><span class="fs-3">Access Poll</span></button>
            </div>
        </form>
    </div>
    <%@include file="components/footer.jsp"%>
