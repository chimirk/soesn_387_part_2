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
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ChangePassServlet", value = "/ChangePassServlet")
public class ChangePassServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("change_password_btn") != null) {
            String destination = "ChangePasswordPage.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
            dispatcher.forward(request, response);
        } else {
            UserAdministration userAdministration = new UserAdministration(new UserManagementImpl());
            User user = (User) request.getSession().getAttribute("loggedInUser");
            String userName = user.getUsername();
            String oldPassword = request.getParameter("cp_oldpassword");
            String passwordOne = request.getParameter("cp_password_one");
            String passwordTwo = request.getParameter("cp_password_two");

            ArrayList<String> errors = new ArrayList();
            ArrayList<String> messages = new ArrayList<>();

            if (passwordOne.isEmpty()) {
                errors.add("password one is required");
            }
            if (passwordTwo.isEmpty()) {
                errors.add("password two is required");
            }
            if (!(passwordOne.equals(passwordTwo))) {
                errors.add("password one and password two do not match");
            }

            if (errors.size() == 0) {
                try {
                    userAdministration.changePassword(userName, oldPassword, passwordOne);
                    messages.add("Password successfully changed. Please login again to continue.");
                    request.setAttribute("messages", messages);
                    request.getSession().removeAttribute("user");
                    String destination = "login_page.jsp";
                    RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
                    dispatcher.forward(request, response);
                } catch (Exception e) {
                    if (e.getMessage().equals("the old password and the new password are the same. please use a different new password")) {
                        errors.add("new password matches the old one. Enter a different password");
                    }
                    if (e.getMessage().equals("Provided combination of username and old password does not exist in database")) {
                        errors.add("Provided combination of username and old password does not exist in database");
                    }
                }
            }

        }
    }
}
