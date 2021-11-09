<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Map" %>

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
%>
<% if(application.getAttribute("poll_manager") != null) {
        pollManager = (PollManager) application.getAttribute("poll_manager");
    if(pollManager.getPoll()!=null && pollManager.getPoll().getStatus() == PollStatus.RELEASED){

        Poll poll = pollManager.getPoll();
        Hashtable<Choice, Integer> results = pollManager.getPollResults();
        ArrayList<Choice> keys = poll.getChoices();
        Choice key = null;

%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        const data = google.visualization.arrayToDataTable([
            ["Choice", "Number of Votes"],
            <%
            for(int i = 0; i < keys.size(); i++) {
                key = getRealKey(results, keys.get(i));
                Integer value = results.get(key);%>
                ["<%= key.getText()%>", <%= value %>],
            <% } %>
        ]);

        const options = {
            title:'<%= poll.getTitle() %>',
            subtitle: '<%= poll.getQuestion() %>',
            chartArea: {width: '50%'},
            legend: { position: 'none' },
            bars: 'horizontal',
            hAxis: {
                title: 'Number of Votes',
                baseline: 0,
                minValue: 0,
                textStyle: {
                    fontSize: 14,
                    bold: true,
                    color: '#848484'
                },
                titleTextStyle: {
                    fontSize: 14,
                    bold: true,
                    color: '#848484',
                    textAlign: 'center'
                }
            },
            vAxis: {
                title: 'Choice',
                textStyle: {
                    fontSize: 14,
                    bold: true,
                    color: '#848484'
                },
                titleTextStyle: {
                    fontSize: 14,
                    bold: true,
                    color: '#848484'
                }
            },
            titleTextStyle: {
                bold: true,
                fontSize: 18,
                color: '#4d4d4d'
            }
        };

        const chart = new google.visualization.BarChart(document.getElementById('piechart'));

        chart.draw(data, options);
    }
</script>
<% } } %>