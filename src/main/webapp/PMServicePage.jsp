<%@ page import="java.util.ArrayList" %>
<%@ page import="com.pollmanager.*" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page errorPage="errorPage.jsp" %>


<%
    PollManager pollManager = new PollManager();
    String title;
    String question;
    String [] listOfChoiceText;
    String [] listOfDescription;
    ArrayList<Choice> choices = null;

    if(request.getParameter("login") != null && request.getParameter("password") != null && "POST".equalsIgnoreCase(request.getMethod())){
        String password = request.getParameter("password");
        if(password.equals("SOEN387")) {
            session.setAttribute("auth", "SOEN387");
            session.removeAttribute("password");
        }
        else{
            session.setAttribute("password", "invalid");
        }
    }

    if(application.getAttribute("poll_manager")!=null && !("POST".equalsIgnoreCase(request.getMethod()))){
        pollManager = (PollManager) application.getAttribute("poll_manager");
        Poll poll = pollManager.getPoll();
        title = poll.getTitle();
        question = poll.getQuestion();
        choices = poll.getChoices();
        listOfChoiceText = new String[choices.size()];
        listOfDescription = new String[choices.size()];
        for(int i = 0; i< choices.size(); i++){
            listOfChoiceText[i] = choices.get(i).getText();
            listOfDescription[i] = choices.get(i).getDescription();
        }
    }else{
        title = request.getParameter("poll_title") != null && request.getParameter("close") == null ? request.getParameter("poll_title") : "";
        question = request.getParameter("poll_question") != null && request.getParameter("close") == null ? request.getParameter("poll_question") : "";
        listOfChoiceText = request.getParameterValues("choice_text") != null && request.getParameter("close") == null ? request.getParameterValues("choice_text") : null;
        listOfDescription = request.getParameterValues("description") != null && request.getParameter("close") == null ? request.getParameterValues("description") : null;

        if(Objects.nonNull(listOfChoiceText) && listOfChoiceText.length>=2){
            choices = new ArrayList<>();
            for(int i=0; i< listOfChoiceText.length;i++){
                choices.add(new Choice(listOfChoiceText[i], listOfDescription[i]));
            }
        }
    }

    if(session.getAttribute("auth") != null && session.getAttribute("auth").toString().equals("SOEN387")){

        if (request.getParameter("login") == null &&"POST".equalsIgnoreCase(request.getMethod())) {
            if(title.isEmpty() && request.getParameter("close") == null){
                throw new Exception("Please enter a title.");
            }

            if(question.isEmpty() && request.getParameter("close") == null){
                throw new Exception("Please enter a question.");
            }

            if(question.isEmpty() && request.getParameter("close") == null){
                throw new Exception("Please enter a question.");
            }

            if(request.getParameter("close") == null) {
                for (int i = 0; i < listOfChoiceText.length; i++) {
                    if (listOfChoiceText[i].isEmpty() && request.getParameter("close") == null)
                        throw new Exception("Please enter a text for choice " + (i + 1));
                }
            }
            if(request.getParameter("close") == null) {
                for (int i = 0; i < listOfDescription.length; i++) {
                    if (listOfChoiceText[i].isEmpty() && request.getParameter("close") == null)
                        throw new Exception("Please enter a description for choice " + (i + 1));
                }
            }

            if (request.getParameter("create") != null) {
                pollManager.createPoll(title, question, choices);
                application.setAttribute("poll_manager", pollManager);

            } else if (request.getParameter("update") != null) {

                pollManager = (PollManager) application.getAttribute("poll_manager");
                pollManager.updatePoll(title, question, choices);
                application.setAttribute("poll_manager", pollManager);

            } else if (request.getParameter("run") != null) {

                pollManager = (PollManager) application.getAttribute("poll_manager");

                pollManager.runPoll();

                application.setAttribute("poll_manager", pollManager);

            } else if (request.getParameter("release") != null) {

                pollManager = (PollManager) application.getAttribute("poll_manager");

                pollManager.releasePoll();

                application.setAttribute("poll_manager", pollManager);



            } else if (request.getParameter("unrelease") != null) {

                pollManager = (PollManager) application.getAttribute("poll_manager");

                pollManager.unreleasePoll();

                application.setAttribute("poll_manager", pollManager);

            } else if (request.getParameter("clear") != null) {

                pollManager = (PollManager) application.getAttribute("poll_manager");
                pollManager.clearPoll();
                application.setAttribute("poll_manager", pollManager);

            } else if (request.getParameter("close") != null) {
                pollManager = (PollManager) application.getAttribute("poll_manager");
                pollManager.closePoll();
                application.removeAttribute("poll_manager");
            }
        }
    }
%>
