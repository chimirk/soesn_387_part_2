<%@ page import="java.util.ArrayList" %>
<%@ page import="com.pollmanager.*" %>
<%@ page import="java.util.Objects" %>
<%--
<%@ page import="com.json.User" %>
--%>
<%--
<%@ page import="com.databaseUM.helper.User" %>
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
<%@page errorPage="errorPage.jsp" %>
--%>


<%
    PollManager pollManager = new PollManager();
    String title = "";
    String question = "";
    String [] listOfChoiceText = null;
    String [] listOfDescription = null;
    ArrayList<Choice> choices = null;
    String userID = "";
    String pollID = "";

    com.databaseUM.helper.User user = (com.databaseUM.helper.User) session.getAttribute("loggedInUser");
    //User user = (User) session.getAttribute("loggedInUser");
    if (user != null) {
        userID = user.getUsername();
    } else {
        response.sendRedirect("login_page.jsp");
        return;
    }


    ArrayList<Poll> polls = pollManager.getAllPollsByUser(userID);


    if(("POST".equalsIgnoreCase(request.getMethod()))){
        title = request.getParameter("poll_title") != null ? request.getParameter("poll_title") : "";
        question = request.getParameter("poll_question") != null ? request.getParameter("poll_question") : "";
        listOfChoiceText = request.getParameterValues("choice_text") != null ? request.getParameterValues("choice_text") : null;
        listOfDescription = request.getParameterValues("description") != null ? request.getParameterValues("description") : null;

        if(Objects.nonNull(listOfChoiceText) && listOfChoiceText.length>=2){
            choices = new ArrayList<>();
            for(int i=0; i< listOfChoiceText.length;i++){
                choices.add(new Choice(listOfChoiceText[i], Objects.requireNonNull(listOfDescription)[i]));
            }
        }

        if(title.isEmpty()){
            try {
                throw new Exception("Please enter a title.");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if(question.isEmpty()){
            try {
                throw new Exception("Please enter a question.");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        for (int i = 0; i < Objects.requireNonNull(listOfChoiceText).length; i++) {
            if (listOfChoiceText[i].isEmpty())
                try {
                    throw new Exception("Please enter a text for choice " + (i + 1));
                } catch (Exception e) {
                    e.printStackTrace();
                }
        }

        for (int i = 0; i < Objects.requireNonNull(listOfDescription).length; i++) {
            if (listOfChoiceText[i].isEmpty())
                try {
                    throw new Exception("Please enter a description for choice " + (i + 1));
                } catch (Exception e) {
                    e.printStackTrace();
                }
        }


        if (request.getParameter("create") != null) {
            try {
                pollManager.createPoll(title, question, choices, userID);
            } catch (PollManagerException | PollException e) {
                e.printStackTrace();
            }
        }

    }

%>
