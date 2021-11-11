package com.main;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import java.io.FileWriter;


public class Main {

    public static void main(String[] args) {
        JsonObject jsonObject1 = Json.createObjectBuilder()
                .add("username", "username1")
                .add("password", "password1")
                .build();

        JsonObject jsonObject2 = Json.createObjectBuilder()
                .add("username", "username2")
                .add("password", "password2")
                .build();

        JsonArray jsonArray = Json.createArrayBuilder()
                .add(jsonObject1)
                .add(jsonObject2)
                .build();

        try(FileWriter file = new FileWriter("users.json")) {
            file.write(jsonArray.toString());
            file.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }



    }


}
