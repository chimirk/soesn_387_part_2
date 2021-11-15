<%@ page import="java.util.ArrayList" %>
<%@ page import="com.pollmanager.*" %>
<%@ page import="com.generator.*" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.json.User" %>
<%@ page import="com.database.PollGateway" %>
<%@ page import="java.util.Enumeration" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
<%@page errorPage="errorPage.jsp" %>
--%>


<%
    String index = "";
    PollManager pollManager = new PollManager();
    String title = "";
    String question = "";
    String [] listOfChoiceText = null;
    String [] listOfDescription = null;
    ArrayList<Choice> choices = null;
    String userID = "";
    String pollID = "";
    Poll currentPoll;
    ArrayList<Poll> polls;


    //User user = (User) session.getAttribute("User");
    index = request.getParameter("index") != null ? request.getParameter("index") : (String)session.getAttribute("index");
    System.out.println(index);
    userID = request.getParameter("userID") != null ? request.getParameter("userID") : (String) session.getAttribute("userID");
    System.out.println(userID);
    polls = pollManager.getAllPollsByUser(userID);
    currentPoll = polls.get(Integer.parseInt(index));
    pollID = currentPoll.getPollID();
    title = currentPoll.getTitle();
    question = currentPoll.getQuestion();
    choices = currentPoll.getChoices();
    listOfChoiceText = new String[choices.size()];
    listOfDescription = new String[choices.size()];

    for(int i = 0; i< choices.size(); i++){
        listOfChoiceText[i] = choices.get(i).getText();
        listOfDescription[i] = choices.get(i).getDescription();
    }


    if (request.getParameter("update") != null) {

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            if (title.isEmpty()) {
                try {
                    throw new Exception("Please enter a title.");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            if (question.isEmpty()) {
                try {
                    throw new Exception("Please enter a question.");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            for (int i = 0; i < listOfChoiceText.length; i++) {
                if (listOfChoiceText[i].isEmpty())
                    try {
                        throw new Exception("Please enter a text for choice " + (i + 1));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
            }

            for (int i = 0; i < listOfDescription.length; i++) {
                if (listOfChoiceText[i].isEmpty())
                    try {
                        throw new Exception("Please enter a description for choice " + (i + 1));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
            }
        }

        pollID = Objects.requireNonNull(currentPoll).getPollID();
        title = request.getParameter("poll_title");
        question = request.getParameter("poll_question");
        listOfChoiceText = request.getParameterValues("choice_text");
        listOfDescription = request.getParameterValues("description");

        if(Objects.nonNull(listOfChoiceText) && listOfChoiceText.length>=2){
            choices = new ArrayList<>();
            for(int i=0; i< listOfChoiceText.length;i++){
                choices.add(new Choice(listOfChoiceText[i], listOfDescription[i]));
            }
        }

        try {
            pollManager.updatePoll(title, question, choices, pollID, userID);
        } catch (PollManagerException | PollException e) {
            e.printStackTrace();
        }

    } else if (request.getParameter("run") != null) {
        try {
            pollManager.runPoll(pollID);
        } catch (PollManagerException e) {
            e.printStackTrace();
        }
    } else if (request.getParameter("release") != null) {
        try {
            pollManager.releasePoll(pollID);
        } catch (PollManagerException e) {
            e.printStackTrace();
        }
    } else if (request.getParameter("unrelease") != null) {
        try {
            pollManager.unreleasePoll(pollID);
        } catch (PollManagerException e) {
            e.printStackTrace();
        }
    } else if (request.getParameter("clear") != null) {
        try {
            pollManager.clearPoll(pollID);
        } catch (PollManagerException e) {
            e.printStackTrace();
        }
    } else if (request.getParameter("close") != null) {
        try {
            pollManager.closePoll(pollID);
        } catch (PollManagerException e) {
            e.printStackTrace();
        }
    } else if (request.getParameter("delete") != null) {
        try {
            pollManager.deletePoll(userID, pollID);
            response.sendRedirect("PollManagerPage.jsp");
        } catch (PollManagerException e) {
            e.printStackTrace();
        }
    }

    session.setAttribute("index", index);
    session.setAttribute("userID", userID);
%>
