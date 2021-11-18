<%--
<%@ page errorPage="errorPage.jsp" %>
--%>
<%@ page import="com.pollmanager.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.generator.VoterPin" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    session.removeAttribute("poll");
    session.removeAttribute("voterPin");
    session.removeAttribute("voted");
    session.removeAttribute("message");
    if("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("access")!= null){
        Poll poll = null;
        String pollID = request.getParameter("pollID").toUpperCase().trim();
        String pinEntered  = request.getParameter("voterPin");
        PollManager pollManager = new PollManager();
        try {
            poll = pollManager.accessPoll(pollID);
            if (poll.getStatus().equals(PollStatus.RELEASED)) {
                request.getSession().setAttribute("errorMessage", "The poll has been RELEASED. Cannot vote on it anymore.");
                response.sendRedirect("AccessVotePage.jsp");
                return;
            } else if (poll.getStatus().equals(PollStatus.CLOSED)) {
                request.getSession().setAttribute("errorMessage", "The poll has been CLOSED. Cannot vote on it anymore.");
                response.sendRedirect("AccessVotePage.jsp");
                return;
            }
        } catch (PollManagerException e) {
            request.getSession().setAttribute("errorMessage", "Entered POLL ID does not exist in the system");
            response.sendRedirect("AccessVotePage.jsp");
            return;
        }
        System.out.println(pinEntered);
        if(Objects.isNull(pinEntered)|| pinEntered.isEmpty()){
            session.setAttribute("voterPin", VoterPin.generatePin(pollID));
        }else if(VoterPin.pinExists(pollID,Integer.parseInt(pinEntered.trim()))){
            session.setAttribute("voterPin", Integer.parseInt(pinEntered.trim()));
        } else{
            request.getSession().setAttribute("errorMessage", "Entered PIN does not exist in the system");
            response.sendRedirect("AccessVotePage.jsp");
            return;

        }
        request.getSession().setAttribute("poll", poll);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("VotingPage.jsp");
        requestDispatcher.forward(request, response);
    }

%>
