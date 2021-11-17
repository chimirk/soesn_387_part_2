<%@ page import="com.pollmanager.*" %>
<%--<%@ page errorPage="errorPage.jsp" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="AccessServicePage.jsp"%>
<%@ include file="components/header.jsp"%>
<div class="container">
    <div class="d-flex align-items-center justify-content-center">
        <form class="form-horizontal w-50 border border-3 rounded-3 border-primary p-4" action="AccessServicePage.jsp" method="post">
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="pollID">Password</label>
                <input class="form-control" id="pollID" type="text" placeholder="Enter Poll ID" name="pollID" required />
            </div>
            <div class="form-group mt-2 mb-3">
                <label class="control-label fs-3" for="voterPin">Pin #</label>
                <input class="form-control" id="voterPin" type="text" placeholder="Enter you pin number" name="voterPin" />
            </div>
            <div class="d-grid gap-2 col-6 mx-auto">
                <button class="btn btn-primary" type="submit" name="access" value="access"><span class="fs-3">Access Poll</span></button>
            </div>
        </form>
    </div>
    <%@include file="components/footer.jsp"%>
