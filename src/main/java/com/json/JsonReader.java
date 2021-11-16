package com.json;

import com.google.gson.Gson;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class JsonReader {
    public static User[] readJsonFile(String pathName) throws IOException {
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


}
