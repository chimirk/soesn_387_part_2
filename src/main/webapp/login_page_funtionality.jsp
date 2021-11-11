<%@ page import="java.util.ArrayList" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%
    String username = "";
    String userpassword = "";
    ArrayList<String> errors = new ArrayList();

    if("POST".equals(request.getMethod())) {
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
                }catch (NoSuchAlgorithmException e) {
                        e.printStackTrace();
                    }

                //read from JSON file and see if username and password match.

                //login
                if (true) {

                } else {
                    errors.add("Wrong username/password combination");
                }

            }  //end no errors
        }
    }

%>