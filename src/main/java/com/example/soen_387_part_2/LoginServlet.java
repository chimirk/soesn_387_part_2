package com.example.soen_387_part_2;

import com.json.JsonReader;
import com.json.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String parameterName = parameterNames.nextElement();
            String[] parameterValues = request.getParameterValues(parameterName);
            for (int i = 0; i < parameterValues.length; i++) {
                String parameterValue = parameterValues[i];
                if (parameterValue.equals("TRUE")) {
                    response.sendRedirect("Registration_Page_Step_One.jsp");
                    //response.sendError(500, "REGISTRATION IS NOT IMPLEMENTED YET. PLEASE TRY AGAIN LATER.");
                }
            }
        }*/
        String signUpRequest = request.getParameter("signup");
        String forgotPasswordRequest = request.getParameter("forgotPass");
        if (signUpRequest != null && signUpRequest.equals("TRUE")) {
            response.sendRedirect("Registration_Page_Step_One.jsp");
        } else if (forgotPasswordRequest != null && forgotPasswordRequest.equals("TRUE")) {
            response.sendRedirect("ForgotPasswordStepOne.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = this.getClass().getClassLoader().getResource("/users.json").getPath().replace("%20"," ");
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

            User[] users = JsonReader.readJsonFile(url);
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
                response.sendRedirect("PollManagerPage.jsp");
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

