package com.example.soen_387_part_2;

import com.json.JsonReader;
import com.json.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Enumeration;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String parameterName = parameterNames.nextElement();
            String[] parameterValues = request.getParameterValues(parameterName);
            for (int i = 0; i < parameterValues.length; i++) {
                String parameterValue = parameterValues[i];
                if (parameterValue.equals("TRUE")) {
                    response.sendError(500, "REGISTRATION IS NOT IMPLEMENTED YET. PLEASE TRY AGAIN LATER.");
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        URL url = this.getClass().getClassLoader().getResource("/users.json");
        String username = "";
        String userpassword = "";
        ArrayList<String> errors = new ArrayList();

        username = request.getParameter("username");
        userpassword = request.getParameter("userpassword");

        if (username.isEmpty()) errors.add("Username is required");
        if (userpassword.isEmpty()) errors.add("Password is required");

        if (errors.size() == 0) {
            //calculate MD5 hash of password
            MessageDigest md = null;
            try {
                md = MessageDigest.getInstance("MD5");
                md.update(userpassword.getBytes());
                byte[] bytes = md.digest();
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < bytes.length; i++) {
                    sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
                }
                userpassword = sb.toString();
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }

            User[] users = JsonReader.readJsonFile(url.getPath());
            //check if we have a user match
            User loggedInUser = null;
            for (int i = 0; i < users.length; i++) {
                if (users[i].id.equals(username) &&
                        users[i].hashedPassword.equals(userpassword)) {
                    loggedInUser = users[i];
                    break;
                }
            }
            //if loggedInUser is not null, we are logged in
            if (loggedInUser != null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("loggedInUser", loggedInUser);
                response.sendRedirect("UserPage.jsp");
            } else {
                errors.add("Wrong username/password combination");
                request.setAttribute("errors", errors);
                String destination = "login_page.jsp";
                RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
                dispatcher.forward(request, response);

                //response.sendRedirect("login_page.jsp");
            }
        } else {
            request.setAttribute("errors", errors);
            String destination = "login_page.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
            dispatcher.forward(request, response);
        }
    }
}

