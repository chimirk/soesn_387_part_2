package com.example.soen_387_part_2;

import com.useradm.UserAdministration;
import com.usermanagementlayer.UserManagementImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ActivateAccountNewUser", value = "/ActivateAccountNewUser")
public class SignUpP1Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("thisToken");
        String userName = request.getParameter("thisUserName");
        request.setAttribute("signUpToken", token);
        request.setAttribute("userName", userName);
        String destination = "RegistrationPageStepTwo.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
        dispatcher.forward(request, response);


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserAdministration userAdministration = new UserAdministration(new UserManagementImpl());
        ArrayList<String> errors = new ArrayList();
        ArrayList<String> messages = new ArrayList<>();

        String newUserName = request.getParameter("new_username");
        String newUserEmail = request.getParameter("new_user_email");
        String newUserFullName = request.getParameter("new_user_full_name");
        if (newUserName.isEmpty()) {
            errors.add("New Username is required");
        }
        if (newUserEmail.isEmpty()) {
            errors.add("New User Email is required");
        }
        if (newUserFullName.isEmpty()) {
            errors.add("New Full Name is required");
        }
        if (errors.size() == 0) {
            try {
                userAdministration.signUp(newUserName, newUserFullName, newUserEmail);
                messages.add("Please verify your email to continue registration.");
                request.setAttribute("messages", messages);
                String destination = "login_page.jsp";
                RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
                dispatcher.forward(request, response);
                return;
            } catch (Exception e) {
                if (e.getMessage().equals("This username is already registered")){
                    errors.add("This username is already registered");
                    String destination = "RegistrationPageStepOne.jsp";
                    RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
                    dispatcher.forward(request, response);
                    return;
                }
                e.printStackTrace();
            }
        } else {
            request.setAttribute("errors", errors);
            String destination = "RegistrationPageStepOne.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
            dispatcher.forward(request, response);
        }
    }

}

