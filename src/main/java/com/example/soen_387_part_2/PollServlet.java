package com.example.soen_387_part_2;

import com.pollmanager.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
//
//        PollManager pollManager = (PollManager) request.getSession().getAttribute("poll_manager");
//        String poll_title = (String) request.getSession().getAttribute("poll_title");
//
//        PrintWriter printWriter = response.getWriter();
//        StringBuilder filename = new StringBuilder();
//        String pollID = request.getParameter("pollID");
//
//        try {
//            pollManager.downloadPollDetails(printWriter, filename, pollID);
//        } catch (PollManagerException e) {
//            response.sendError(500, e.getMessage());
//            return;
//        }
//
//
//        String name = filename.toString().substring(0, poll_title.length());
//
//        if ((filename.toString().endsWith(".txt")) && (name.compareTo(poll_title) == 0)) {
//
//            String headerKey = "Content-Disposition";
//            String headerValue = String.format("attachment; filename=\"%s\"", filename.toString());
//            response.setContentType("application/octet-stream");
//            response.setHeader(headerKey, headerValue);
//            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
//            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
//            response.setDateHeader("Expires", 0); // Proxies.
//
//            printWriter.close();
//
//            String destination = "/UserPage.jsp";
//            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
//            dispatcher.forward(request, response);
//
//        } else {
//
//            printWriter = null;
//            response.sendError(500, "The filename does not match the title or the format string is not .txt");
//        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PollManager pollManager = new PollManager();
        if(Objects.isNull(request.getParameter("pollID")) ||request.getParameter("pollID").isEmpty()){
            response.sendError(500, "Missing Poll ID");
            return;
        }
        if(Objects.isNull(request.getParameter("choice")) || request.getParameter("choice").isEmpty()){
            response.sendError(500, "Please select a choice before submitting.");
            return;
        }
        if(Objects.isNull(request.getParameter("voterPin")) || request.getParameter("voterPin").isEmpty()){
            response.sendError(500, "Missing Pin Number");
            return;
        }
        String pollID = (String) request.getParameter("pollID");
        int voterPin = Integer.parseInt(request.getParameter("voterPin"));
        int choiceID = Integer.parseInt(request.getParameter("choice"));
        Poll poll = null;
        try {
            poll = pollManager.accessPoll(pollID);
        } catch (PollManagerException e) {
            response.sendError(500, e.getMessage());
            return;
        }

        if (!poll.isValidChoice(choiceID)) {
            response.sendError(500, "The selected choice is not valid");
        }
        else if (poll.getStatus().compareTo(PollStatus.RUNNING) != 0){
            response.sendError(500, "The poll is currently not running.");
        }
        else {
            try {
                pollManager.vote(pollID,voterPin, choiceID);
                message = "Vote Successful for "+voterPin;
            } catch (PollManagerException e) {
                e.printStackTrace();
            }

            request.getSession().setAttribute("voted", "voted");
            request.getSession().setAttribute("message", message);
            request.getSession().setAttribute("voterPin", voterPin);
            request.getSession().setAttribute("poll", poll);

            String destination = "/VotingPage.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
            dispatcher.forward(request, response);
        }

    }

}
