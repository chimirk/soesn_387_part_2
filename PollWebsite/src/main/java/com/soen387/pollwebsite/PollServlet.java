package com.soen387.pollwebsite;

import com.pollmanager.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Objects;

@WebServlet(name = "PollServlet", value = "/PollServlet")
public class PollServlet extends HttpServlet {
   private String message;

    public void init() {
        message = "";
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        PollManager pollManager = (PollManager) request.getSession().getAttribute("poll_manager");
        String poll_title = (String) request.getSession().getAttribute("poll_title");

        PrintWriter printWriter = response.getWriter();
        StringBuilder filename = new StringBuilder();

        try {
            pollManager.downloadPollDetails(printWriter, filename);
        } catch (PollManagerException e) {
            response.sendError(500, e.getMessage());
            return;
        }


        String name = filename.toString().substring(0, poll_title.length());

        if ((filename.toString().endsWith(".txt")) && (name.compareTo(poll_title) == 0)) {

            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"", filename.toString());
            response.setContentType("application/octet-stream");
            response.setHeader(headerKey, headerValue);
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
            response.setDateHeader("Expires", 0); // Proxies.

            printWriter.close();

            String destination = "/UserPage.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
            dispatcher.forward(request, response);

        } else {

            printWriter = null;
            response.sendError(500, "The filename does not match the title or the format string is not .txt");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PollManager pollManager = (PollManager) request.getSession().getAttribute("poll_manager");
        Poll poll = pollManager.getPoll();
        String sessionID = request.getParameter("sessionID");
        String choiceText = request.getParameter("choice");
        String description = "";

        if(Objects.isNull(choiceText) || choiceText.isEmpty()){
            response.sendError(500, "Please select a choice before submitting.");
            return;
        }

        //get description matching the choice text
        ArrayList<Choice> arrayList = poll.getChoices();
        for (int i = 0; i < arrayList.size(); i++) {
            Choice choice = arrayList.get(i);
            if (choice.getText().compareTo(choiceText) == 0) {
                description = choice.getDescription();
                break;
            }
        }

        Choice choice = new Choice(choiceText, description);

        if (!poll.isValidChoice(choice)) {
            response.sendError(500, "The selected choice is not valid");
        }
        else if (poll.getStatus().compareTo(PollStatus.RUNNING) != 0){
            response.sendError(500, "The poll is currently not running.");
        }
        else {
            try {
                pollManager.vote(sessionID, choice);
                message = "You voted for " + choiceText;
            } catch (PollManagerException e) {
                e.printStackTrace();
            }

            request.getSession().setAttribute("voted", "voted");
            request.getSession().setAttribute("message", message);
            request.getSession().setAttribute("poll_manager", pollManager);
            //request.getSession().setAttribute("poll", poll);

            String destination = "/UserPage.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
            dispatcher.forward(request, response);
        }

    }

}
