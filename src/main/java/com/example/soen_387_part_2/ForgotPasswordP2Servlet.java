package com.example.soen_387_part_2;

import com.useradm.UserAdministration;
import com.usermanagementlayer.UserManagementException;
import com.usermanagementlayer.UserManagementImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ForgotPasswordP2Servlet", value = "/ForgotPasswordP2Servlet")
public class ForgotPasswordP2Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserAdministration userAdministration = new UserAdministration(new UserManagementImpl());
        ArrayList<String> errors = new ArrayList();
        ArrayList<String> messages = new ArrayList<>();

        String userName = request.getParameter("userName");
        String forgotPassToken = request.getParameter("forgotPassToken");
        String passwordOne = request.getParameter("fp_password_one");
        String passwordTwo = request.getParameter("fp_password_two");

        //verify passwords
        if (passwordOne.isEmpty()) {
            errors.add("password one value is required");
        } else if (passwordTwo.isEmpty()) {
            errors.add("password two value is required");
        } else if (!passwordOne.equals(passwordTwo)) {
            errors.add("password one and password two don't match");
        }
        if (errors.size() == 0) {
            try {
                userAdministration.emailVerificationForForgotPassword(forgotPassToken, passwordOne);
                messages.add("New Password set up completed successfully");
                request.setAttribute("messages", messages);
                String destination = "login_page.jsp";
                RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
                dispatcher.forward(request, response);
            } catch (UserManagementException e) {
                if (e.getMessage().equals("password or username is empty or null")) {
                    errors.add("password or username is empty or null");
                    request.setAttribute("errors", errors);
                    String destination = "ForgotPasswordStepTwo.jsp";
                    RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
                    dispatcher.forward(request, response);
                    return;
                }
                e.printStackTrace();
            }
        } else {
            request.setAttribute("errors", errors);
            String destination = "ForgotPasswordStepTwo.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
            dispatcher.forward(request, response);
        }
    }
}
