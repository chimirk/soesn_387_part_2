<%@ page import="com.pollmanager.*" %>
<%@ page errorPage="errorPage.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="UserServicePage.jsp"%>
<%@ include file="components/header.jsp"%>

<div class="container">
    <div class="d-flex align-items-center justify-content-center">

        <% if(application.getAttribute("poll_manager") != null && pollManager.getPoll().getStatus() != PollStatus.CREATED){ %>
        <%
            request.getSession().setAttribute("poll_manager", pollManager);
            request.getSession().setAttribute("poll", pollManager.getPoll());

            session.setAttribute("poll_manager", pollManager);
            session.setAttribute("poll_title", pollManager.getPoll().getTitle());
        %>
        <% if(pollManager.getPoll().getStatus() == PollStatus.RUNNING) { %>
            <form class="w-100 d-flex justify-content-center" action="${pageContext.request.contextPath}/PollServlet" method="post">
                <div class="card" style="width: 50%;">
                    <div class="card-body">
                        <% if(!message.isEmpty()) { %>
                        <div class="alert alert-success" role="alert">
                            <%= message %>
                        </div>
                        <% } %>
                        <h1 class="card-title display-4 text-center"><%= title %></h1>
                        <h1 class="card-text display-6"><%= question %></h1>
                    </div>
                    <ul class="list-group list-group-flush">
                        <% for (int i = 0; i < choices.size(); i++) { %>
                        <li class="list-group-item">
                            <input class="form-check-input" type="radio" id = "choice_<%= i + 1%>" value="<%= choices.get(i).getText() %>" name="choice">
                            <label class="form-check-label fs-5" for="choice_<%= i + 1%>">
                                <%= choices.get(i).getText()%>
                                <br />
                                <p><small><%= choices.get(i).getDescription() %></small></p>
                            </label>

                        </li>
                        <% } %>
                    </ul>
                    <div class="card-body d-grid gap-2 col-6 mx-auto">
                        <input type="hidden" value="<%= session.getId()%>" name="sessionID">
                        <button class="btn btn-primary" type="submit" name="vote" value="vote">Vote</button>
                    </div>
                </div>
            </form>
        <% }else if(pollManager.getPoll().getStatus() == PollStatus.RELEASED) { %>
        <div class="card">
            <div class="card-body">
                <div id="piechart" style="width: 900px; height: 500px;"></div>
            </div>
            <div class="card-body d-grid gap-2 col-6 mx-auto">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/PollServlet">Download Results</a>
            </div>
        </div>
        <% } }else{ %>
        <h1>Currently there is no poll running</h1>
        <% } %>
    </div>
</div>
<%@include file="components/footer.jsp"%>


