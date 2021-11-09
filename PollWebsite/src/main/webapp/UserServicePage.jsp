<%@ page errorPage="errorPage.jsp" %>
<%@ page import="com.pollmanager.PollManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.pollmanager.Choice" %>
<%@ page import="com.pollmanager.PollManagerException" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    PollManager pollManager = null;
    String title = "";
    String question = "";
    ArrayList<Choice> choices = null;
    String message = "";

    if (request.getSession().getAttribute("voted") != null) {
        application.setAttribute("poll_manager", request.getSession().getAttribute("poll_manager"));
        message = (String) request.getSession().getAttribute("message");
        session.setAttribute("voted", null);
    }

    if(application.getAttribute("poll_manager") != null){
        pollManager = (PollManager) application.getAttribute("poll_manager");

        title = pollManager.getPoll().getTitle();
        question = pollManager.getPoll().getQuestion();
        choices = pollManager.getPoll().getChoices();
    }

%>
<%@ include file="chartService.jsp"%>