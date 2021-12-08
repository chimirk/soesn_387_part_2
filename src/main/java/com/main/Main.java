package com.main;

import com.pollmanager.PollManagerException;
import com.useradm.UserAdministration;
import com.usermanagementlayer.UserManagementImpl;

import javax.xml.bind.JAXBException;
import java.io.IOException;



public class Main {

    public static void main(String[] args) throws PollManagerException, JAXBException, IOException {
        /*PollResults pollResultsXML = new PollResults();
        PollManager pollManager = new PollManager();
        Poll poll = com.database.PollGateway.selectPollById("2MSR7YKQNV");
        Hashtable<Choice, Integer> pollResults = pollManager.getPollResults("2MSR7YKQNV");


        pollResultsXML.setTitle(poll.getTitle());
        pollResultsXML.setQuestion(poll.getQuestion());

        Enumeration<Choice> keys =  pollResults.keys();
        Collection<Integer> values =  pollResults.values();

        Hashtable<String, Integer> ht = new Hashtable<>();
        while(keys.hasMoreElements()) {

            String choice = keys.nextElement().getText();
            Integer vote = values.iterator().next();
            ht.put(choice, vote);
        }
        pollResultsXML.setChoiceAndTotalVote(ht);

        JAXBContext jaxbContext = null;
        try {
            //jaxbContext = JAXBContextFactory.newInstance(PollResults.class);
            jaxbContext = org.eclipse.persistence.jaxb.JAXBContextFactory
                    .createContext(new Class[]{PollResults.class}, null);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            jaxbMarshaller.marshal(pollResultsXML, new File("results2.xml"));

        } catch (jakarta.xml.bind.JAXBException e) {
            e.printStackTrace();
        }

        System.out.println(poll.getTitle());

        try(Writer writer = new FileWriter("Output.json")) {
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            gson.toJson(pollResultsXML, writer);
        }*/


        UserAdministration userAdministration = new UserAdministration(new UserManagementImpl());
        try {
            userAdministration.signUp("mike", "mike lopez", "chirca.mircea@gmail.com" );
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


}
