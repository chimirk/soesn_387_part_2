<%@ page import="java.util.ArrayList" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.google.gson.Gson" %>
<%
    String username = "";
    String userpassword = "";
    ArrayList<String> errors = new ArrayList();
    String pathName = "../webapps/soen_387_part_2_war/WEB-INF/users.json";

    if ("POST".equals(request.getMethod())) {
        if (request.getParameter("login_btn") != null) {
            username = request.getParameter("username");
            if (username.isEmpty()) errors.add("Username is required");
            userpassword = request.getParameter("userpassword");
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

                //read from JSON file and see if username and password match.
                User[] users = readJsonFile(pathName);

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
                    %><h1>Logged In!</h1><%
                } else {
                    errors.add("Wrong username/password combination");
                }

            }  //end no errors
        }
    }
%>
<%!
    private static User[] readJsonFile(String pathName) throws IOException {
        String jsonText = "";

        try (BufferedReader br = new BufferedReader(new FileReader(pathName))) {
            StringBuilder sb = new StringBuilder();
            String line = br.readLine();

            while (line != null) {
                sb.append(line);
                sb.append(System.lineSeparator());
                line = br.readLine();
            }
            jsonText = sb.toString();
        }

        //parse jsonText to array of objects
        Gson g = new Gson();
        User[] users = g.fromJson(jsonText, User[].class);

        return users;
        //parse jsonText to array of objects

    }

    public class User {
        public String id;
        public String fullName;
        public String email;
        public String hashedPassword;
    }
%>