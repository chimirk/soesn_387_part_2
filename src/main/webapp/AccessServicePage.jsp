<%@ page errorPage="errorPage.jsp" %>
<%@ page import="com.pollmanager.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.generator.VoterPin" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("access")!= null){
        Poll poll = null;
        String pollID = request.getParameter("pollID").toUpperCase().trim();
        String pinEntered  = request.getParameter("voterPin");
        PollManager pollManager = new PollManager();
        try {
            poll = pollManager.accessPoll(pollID);
        } catch (PollManagerException e) {
            response.sendRedirect("AccessVotePage.jsp");
        }
        System.out.println(pinEntered);
        if(Objects.isNull(pinEntered)|| pinEntered.isEmpty()){
            session.setAttribute("voterPin", VoterPin.generatePin(pollID));
        }else if(VoterPin.pinExists(pollID,Integer.parseInt(pinEntered.trim()))){
            session.setAttribute("voterPin", Integer.parseInt(pinEntered.trim()));
        } else{
            throw new Exception("Pin not found for this poll.");
        }
        request.getSession().setAttribute("poll", poll);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("VotingPage.jsp");
        requestDispatcher.forward(request, response);
    }

%>
