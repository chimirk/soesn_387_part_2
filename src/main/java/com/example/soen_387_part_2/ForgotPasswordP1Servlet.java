package com.example.soen_387_part_2;

import com.useradm.UserAdministration;
import com.usermanagementlayer.UserManagementImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ActivateAccountForgetPassword", value = "/ActivateAccountForgetPassword")
public class ForgotPasswordP1Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("thisToken");
        String userName = request.getParameter("thisUserName");
        request.setAttribute("forgotPassToken", token);
        request.setAttribute("userName", userName);
        String destination = "ForgotPasswordStepTwo.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserAdministration userAdministration = new UserAdministration(new UserManagementImpl());
        ArrayList<String> errors = new ArrayList();
        ArrayList<String> messages = new ArrayList<>();

        String fp_email = request.getParameter("fp_email");
        if (fp_email.isEmpty()) {
            errors.add("Email is required");
        }
        if (errors.size() == 0) {
            try {
                userAdministration.forgotPassword(fp_email);
                messages.add("Please verify your email to get a new password.");
                request.setAttribute("messages", messages);
                String destination = "login_page.jsp";
                RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
                dispatcher.forward(request, response);
            } catch (Exception e) {
                if (e.getMessage().equals("the provided email is not registered in the system.")){
                    errors.add("There is no account associated with this email");
                    String destination = "ForgotPasswordStepOne.jsp";
                    RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
                    dispatcher.forward(request, response);
                    return;
                }
                e.printStackTrace();
            }
        } else {
            request.setAttribute("errors", errors);
            String destination = "ForgotPasswordStepOne.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
            dispatcher.forward(request, response);
        }
    }
}
