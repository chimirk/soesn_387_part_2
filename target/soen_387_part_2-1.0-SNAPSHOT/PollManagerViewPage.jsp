<%@ page import="java.io.IOException" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="PMViewServicePage.jsp"%>
<%@ include file="components/header.jsp"%>
<%!
    public Choice getRealKey(Hashtable<Choice,Integer> hashtable, Choice someChoice) {
        for (Map.Entry<Choice, Integer> entry : hashtable.entrySet()) {
            Choice choice = entry.getKey();
            Integer integer = entry.getValue();
            if ((choice.getText().compareTo(someChoice.getText()) == 0)
                    && (choice.getDescription().compareTo(someChoice.getDescription()) == 0)) {
                return choice;
            };
        }
        return null;
    }

    public boolean isVoted(Poll poll, String userID){
        PollManager pollManager = new PollManager();
        Hashtable<Choice, Integer> results = new Hashtable<>();
        try {
            results = pollManager.getPollResults(poll.getPollID(),userID);
        } catch (PollManagerException e) {
            e.printStackTrace();
        }
        ArrayList<Choice> keys = poll.getChoices();
        Choice key = null;


        for(int i = 0; i < keys.size(); i++) {
            key = getRealKey(results, keys.get(i));
            Integer value = results.get(key);
            if(value>0){
                return true;
            }
        }

        return false;
    }
%>
<%
    polls = pollManager.getAllPollsByUser(userID);
    currentPoll = polls.get(Integer.parseInt(index));
    Hashtable<Choice, Integer> results = pollManager.getPollResults(currentPoll.getPollID(),userID);
    ArrayList<Choice> keys = currentPoll.getChoices();
    Choice key = null;
%>
<div class="container">
    <div class="row">
        <div class="col-0 justify-content-end">
            <a class="btn btn-primary display-4" href="PollManagerPage.jsp">Back</a>
        </div>
        <div class="col">
            <div class="d-flex align-items-center justify-content-center">
                <form class="form-horizontal w-50 border border-3 rounded-3 border-primary p-4" action="PollManagerViewPage.jsp" method="post">
                    <h1 class="text-center">Current Poll
                        <% if(!isVoted(currentPoll, userID)){ %>
                        <button class="btn btn-danger ms-2" type="submit" name="delete" value="delete"><i class="bi bi-trash"></i>Delete</button>
                        <% } %>
                    </h1>
                    <div class="form-group mt-2 mb-3">
                        <label class="control-label fs-3" for="poll_title">Poll Title</label>
                        <input class="form-control" id="poll_title" type="text" value="<%= title %>" name="poll_title" required />
                    </div>
                    <div class="form-group mb-3">
                        <label class="control-label fs-3">Poll Question</label>
                        <input class="form-control" type="text" value="<%= question %>" name="poll_question" required />
                    </div>
                    <div id="choice-list" class="mb-5">
                        <div class="form-group mb-3">
                            <label class="control-label fs-4" >Choice 1 </label>
                            <input class="form-control m-1" type="text" name="choice_text" value="<%= Objects.nonNull(listOfChoiceText) && listOfChoiceText.length>=1  ? listOfChoiceText[0]: ""%>" required  />
                            <input  class="form-control m-1" type="text" placeholder="Enter Description" name="description" value="<%= Objects.nonNull(listOfDescription) && listOfDescription.length>=1 ? listOfDescription[0]: "" %>" required />
                        </div>
                        <div class="form-group mb-3">
                            <label class="control-label fs-4"  >Choice 2 </label>
                            <input class="form-control m-1" type="text" placeholder="Enter Text" name="choice_text" value="<%= Objects.nonNull(listOfChoiceText) && listOfChoiceText.length>=2 ? listOfChoiceText[1]: "" %>" required >
                            <input class="form-control m-1" type="text" placeholder="Enter Description" name="description" value="<%= Objects.nonNull(listOfChoiceText) && listOfDescription.length>=2? listOfChoiceText[1]: "" %>"required >
                        </div>
                        <% if(Objects.nonNull(listOfChoiceText) && listOfChoiceText.length>2){
                            for(int i = 2;i < listOfChoiceText.length; i++){ %>
                        <div class="form-group mb-3">
                            <label class="control-label fs-4"  >Choice <%= i+1 %> </label>
                            <% System.out.println(currentPoll == null);
                                if(currentPoll == null || currentPoll.getStatus() != PollStatus.RELEASED && currentPoll.getStatus() != PollStatus.CLOSED){ %>
                            <button type="button" class="btn-close" aria-label="Close" value="<%= i %>" onclick="removeChoice(event)"></button>
                            <% } %>
                            <input class="form-control m-1" type="text" placeholder="Enter Text" name="choice_text" value="<%= Objects.nonNull(listOfChoiceText) && listOfChoiceText.length>=i ? listOfChoiceText[i]: "" %>" required>
                            <input class="form-control m-1" type="text" placeholder="Enter Description" name="description" value="<%= Objects.nonNull(listOfChoiceText) && listOfDescription.length>=i? listOfChoiceText[i]: "" %>" required>
                        </div>
                        <% }
                        } %>
                    </div>
                    <% if(currentPoll == null || currentPoll.getStatus() != PollStatus.RELEASED && currentPoll.getStatus() != PollStatus.CLOSED){ %>
                    <button id="add" class="btn btn-primary"><i class="bi bi-plus-square"></i> Choice</button>
                    <% } %>
                    <br />
                    <br />

                    <% if(Objects.nonNull(currentPoll) && currentPoll.getStatus() == PollStatus.CREATED) { %>
                    <button class="btn btn-warning" type="submit" name="update" value="update"><span class="fs-5">Update</span></button>
                    <button class="btn btn-success" type="submit"  name="run" value="run"><span class="fs-5">Run</span></button>
                    <% } else if (Objects.nonNull(currentPoll)  && currentPoll.getStatus() == PollStatus.RUNNING) {%>
                    <button class="btn btn-warning" type="submit" name="update" value="update"><span class="fs-5">Update</span></button>
                    <button class="btn btn-lg btn-info" type="submit" name="release" value="release"><span class="fs-5">Release</span></button>
                    <button class="btn btn-lg btn-danger" type="submit" name = "clear" value="clear"><span class="fs-5">Clear</span></button>
                    <% } else if (Objects.nonNull(currentPoll) &&  currentPoll.getStatus() == PollStatus.RELEASED) {%>
                    <button class="btn btn-lg btn-warning" type="submit" name="unrelease" value="unrelease"><span class="fs-5">Unrelease</span></button>
                    <button class="btn btn-lg btn-danger" type="submit" name = "clear" value="clear"><span class="fs-5">Clear</span></button>
                    <button class="btn btn-lg btn-danger" type="submit" name="close" value="close"><span class="fs-5">Close</span></button>
                    <% } else if (Objects.nonNull(currentPoll) &&  currentPoll.getStatus() == PollStatus.CLOSED) {%>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Choice</th>
                                    <th scope="col">Number of Votes</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                for(int i = 0; i < keys.size(); i++) {
                                    key = getRealKey(results, keys.get(i));
                                    Integer value = results.get(key);%>
                                <tr>
                                    <th scope="row"><%= key.getText() %></th>
                                    <th><%= value %></th>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    <% } %>
                </form>
            </div>
        </div>

    </div>

</div>


<%@include file="components/footer.jsp"%>
