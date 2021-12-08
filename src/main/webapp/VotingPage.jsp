<%@ page import="com.pollmanager.*" %>
<%@ page import="java.security.Timestamp" %>
<%@ page import="java.util.*" %>
<%--
<%@ page errorPage="errorPage.jsp" %>
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="components/header.jsp"%>
<%@ include file="chartService.jsp"%>
<div class="container">
    <div class="col-0 justify-content-end">
        <a class="btn btn-primary" href="AccessVotePage.jsp">Back</a>
    </div>
    <div class="d-flex align-items-center justify-content-center">

        <% if(request.getSession().getAttribute("poll") != null){ %>
        <%
            String message = "";
            if(request.getSession().getAttribute("voted") != null){
                message = (String) session.getAttribute("message");
            }
            Poll poll = (Poll) request.getSession().getAttribute("poll");
            String pt = poll.getTitle() + "-" + poll.getReleasedAt() + ".xml";
        %>
        <% if(poll.getStatus() == PollStatus.RUNNING) { %>
        <form class="w-100 d-flex justify-content-center" action="${pageContext.request.contextPath}/PollServlet" method="post">
            <div class="card" style="width: 50%;">
                <div class="card-body">
                    <% if(!message.isEmpty()) { %>
                    <div class="alert alert-success" role="alert">
                        <%= message %>
                    </div>
                    <% } %>
                    <h1 class="card-title display-4 text-center"><%= poll.getTitle() %></h1>
                    <h1 class="card-text display-6"><%= poll.getQuestion() %></h1>
                </div>
                <ul class="list-group list-group-flush">
                    <% for (int i = 0; i < poll.getChoices().size(); i++) { %>
                    <li class="list-group-item">
                        <input class="form-check-input" type="radio" id = "choice_<%= i + 1%>" value="<%= poll.getChoices().get(i).getChoiceID() %>" name="choice">
                        <label class="form-check-label fs-5" for="choice_<%= i + 1%>">
                            <%= poll.getChoices().get(i).getText()%>
                            <br />
                            <p><small><%= poll.getChoices().get(i).getDescription() %></small></p>
                        </label>

                    </li>
                    <% } %>
                </ul>
                <div class="card-body d-grid gap-2 col-6 mx-auto">
                    <input type="hidden" value="<%= session.getAttribute("voterPin")%>" name="voterPin">
                    <input type="hidden" value="<%= poll.getPollID() %>" name="pollID">
                    <button class="btn btn-primary" type="submit" name="vote" value="vote">Vote</button>
                    <br/>
                    <p class="display-6">Your PIN: <%= session.getAttribute("voterPin") %></p>
                </div>
            </div>
        </form>
        <% }else if(poll.getStatus() == PollStatus.RELEASED) { %>
        <div class="card">
            <div class="card-body">
                <div id="piechart" style="width: 900px; height: 500px;"></div>
            </div>
            <div class="card-body ">
                <div class="d-flex justify-content-around">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/PollServlet?dataFormat=txt" download>Download As Plain Text</a>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/PollServlet?dataFormat=xml" download="<%= pt%> ">Download As XML</a>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/PollServlet?dataFormat=json" download>Download As JSON</a>
                </div>
            </div>
        </div>
        <% } }else{ %>
        <h1>Currently there is no poll running</h1>
        <% } %>
    </div>
</div>
<%@include file="components/footer.jsp"%>


