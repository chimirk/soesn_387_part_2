package com.example.soen_387_part_2;

import com.databaseEG.helper.User;
import com.useradm.UserAdministration;
import com.usermanagementlayer.UserManagementImpl;

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
import java.util.Locale;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String signUpRequest = request.getParameter("signup");
        String forgotPasswordRequest = request.getParameter("forgotPass");
        if (signUpRequest != null && signUpRequest.equals("TRUE")) {
            response.sendRedirect("RegistrationPageStepOne.jsp");
        } else if (forgotPasswordRequest != null && forgotPasswordRequest.equals("TRUE")) {
            response.sendRedirect("ForgotPasswordStepOne.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserAdministration userAdministration = new UserAdministration(new UserManagementImpl());
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
                    String temp = Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1);
                    sb.append(temp.toUpperCase(Locale.ROOT));
                }
                userpassword = sb.toString();
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }

            User loggedInUser = userAdministration.userLogin(username, userpassword);
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
            }
        } else {
            request.setAttribute("errors", errors);
            String destination = "login_page.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
            dispatcher.forward(request, response);
        }
    }
}

