<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="PMServicePage.jsp"%>
<%@ include file="components/header.jsp"%>
<div class="container">
    <div class="row justify-content-center">
        <div class = "col-6">
            <div class="justify-content-center">
                <form class="form-horizontal w-100 border border-3 rounded-3 border-primary p-4" action="PollManagerPage.jsp" method="post">
                    <h1 class="text-center">Create Poll</h1>
                    <div class="form-group mt-2 mb-3">
                        <label class="control-label fs-3" for="poll_title" >Poll Title</label>
                        <input class="form-control" id="poll_title" type="text" placeholder="Enter Title" value="<%= title %>" name="poll_title" required />
                    </div>
                    <div class="form-group mb-3">
                        <label class="control-label fs-3"  >Poll Question</label>
                        <input class="form-control" type="text" placeholder="Enter Question" value="<%= question %>" name="poll_question" required />
                    </div>
                    <div id="choice-list" class="mb-5">
                        <div class="form-group mb-3">
                            <label class="control-label fs-4" >Choice 1 </label>
                            <input class="form-control m-1" type="text" placeholder="Enter Text" name="choice_text" value="<%= Objects.nonNull(listOfChoiceText) && listOfChoiceText.length>=1  ? listOfChoiceText[0]: ""%>" required  />
                            <input  class="form-control m-1" type="text" placeholder="Enter Description" name="description" value="<%= Objects.nonNull(listOfDescription) && listOfDescription.length>=1 ? listOfDescription[0]: "" %>" required />
                        </div>
                        <div class="form-group mb-3">
                            <label class="control-label fs-4"  >Choice 2 </label>
                            <input class="form-control m-1" type="text" placeholder="Enter Text" name="choice_text" value="<%= Objects.nonNull(listOfChoiceText) && listOfChoiceText.length>=2 ? listOfChoiceText[1]: "" %>" required >
                            <input class="form-control m-1" type="text" placeholder="Enter Description" name="description" value="<%= Objects.nonNull(listOfChoiceText) && listOfDescription.length>=2? listOfChoiceText[1]: "" %>"required >
                        </div>
                        <% if(Objects.nonNull(listOfChoiceText) && listOfChoiceText.length > 2){
                            for(int i = 2; i < listOfChoiceText.length; i++){ %>
                        <div class="form-group mb-3">
                            <label class="control-label fs-4"  >Choice <%= i + 1 %> </label>
                            <button type="button" class="btn-close" aria-label="Close" value="<%= i %>" onclick="removeChoice(event)"></button>
                            <input class="form-control m-1" type="text" placeholder="Enter Text" name="choice_text" value="<%= Objects.nonNull(listOfChoiceText) && listOfChoiceText.length >= i ? listOfChoiceText[i]: "" %>" required>
                            <input class="form-control m-1" type="text" placeholder="Enter Description" name="description" value="<%= Objects.nonNull(listOfChoiceText) && listOfDescription.length>=i? listOfChoiceText[i]: "" %>" required>
                        </div>
                        <% }
                        } %>
                    </div>
                    <button id="add" class="btn btn-primary"><i class="bi bi-plus-square"></i> Choice</button>
                    <br />
                    <br />
                    <div class="d-grid gap-2 col-6 mx-auto">
                        <button class="btn btn-lg btn-primary" type="submit" name="create" value="create"><span class="fs-3">Create</span></button>
                    </div>
                </form>
            </div>
        </div>
        <div class = "col text-center">
            <% polls = pollManager.getAllPollsByUser(userID); %>
                <form class="form-horizontal w-50 border border-3 rounded-3 border-primary p-4">
                        <% if (polls != null) { %>
                        <h1 class="text-center">List of Polls</h1>
                        <% for (int i = 0; i < polls.size(); i++) {%>
                        <a href="PollManagerViewPage.jsp?index=<%=i%>&userID=<%=userID%>"><%=polls.get(i).getTitle()%> (<%=polls.get(i).getStatus()%>)</a><br>
                        <%}
                        }%>
                </form>
        </div>
    </div>

</div>





<%@include file="components/footer.jsp"%>
