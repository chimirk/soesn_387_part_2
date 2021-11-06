package com.main;

import com.dao.PollDAO;
import com.pollmanager.Choice;
import com.pollmanager.Poll;
import com.pollmanager.PollException;
import com.pollmanager.PollStatus;

import java.util.ArrayList;

public class Main {
    public static void main(String[] args) throws PollException {
        Choice choice1 = new Choice("text1", "description1");
        Choice choice2 = new Choice("text2", "description2");

        ArrayList<Choice> choices = new ArrayList<>();
        choices.add(choice1);
        choices.add(choice2);

        Poll poll = new Poll("Title1", "Question1");
        poll.setStatus(PollStatus.CREATED);
        poll.setChoices(choices);

        PollDAO pollDAO = new PollDAO();
        pollDAO.insertPoll(poll);

        poll.setTitle("title2");
        poll.setQuestion("question4");
        Choice choice3 = new Choice("text_updated10", "description_updated10");
        Choice choice4 = new Choice("text_updated20", "description_updated20");
        choices = new ArrayList<>();
        choices.add(choice3);
        choices.add(choice4);
        poll.setChoices(choices);

        pollDAO.updatePoll(poll, 11);

        pollDAO.deletePoll(6);

        Poll poll_selected = pollDAO.selectPollById(5);
        //System.out.println(poll_selected.getTitle());






    }
}
