<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*,java.text.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<html>
<head>
<title>Through Put</title>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
<%
Gson gsonObj = new Gson();
Map<Object,Object> mapyear = null;
List<Map<Object,Object>> listyear = new ArrayList<Map<Object,Object>>();
String dataPointsyear = null;

Map<Object,Object> mapday = null;
List<Map<Object,Object>> listsday = new ArrayList<Map<Object,Object>>();
String dataPointsday = null;

ArrayList<String> listday=new ArrayList<String>();
ResultSet resultSet=null;
Statement stmt = null;
Connection con=null;
DateFormat df = new SimpleDateFormat("dd/MM/yyyy");  

String xVal;
double yVal;
int i=0;
try{
	Class.forName("oracle.jdbc.OracleDriver"); 
    con =DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","API5AFS","api5afs");
    stmt=con.createStatement();  
	
	String year;
	String month;
	double thruputyear;
	resultSet = stmt.executeQuery("with abc as (select to_char(prces_dte,'YYYY') as year, to_char(prces_dte,'Mon') as month, prces_dte,sum((actual*point)) as throughput from transaction a, task b ,users c where a.task_id=b.task_id and a.user_id=c.user_id group by prces_dte order by prces_dte asc) select year,month ,sum(throughput) from  abc group by year,month order by year,month asc");
	while(resultSet.next()){
		
		year=resultSet.getString(1);
		month=resultSet.getString(2);
		thruputyear=resultSet.getDouble(3);
		listday.add(month+year);		
		mapyear = new HashMap<Object,Object>(); 
		mapyear.put("label", month+year); 
		mapyear.put("y", thruputyear);
		mapyear.put("name", month+year); 
		listyear.add(mapyear);
		dataPointsyear = gsonObj.toJson(listyear);
	}	
}
catch(SQLException e){
	out.println("<div  style='width: 50%; margin-left: auto; margin-right: auto; margin-top: 200px;'>Could not connect to the database. Please check if you have mySQL Connector installed on the machine - if not, try installing the same.</div>");
		
}

%>
<script>
$(document).ready(function(){
var throughputdata = {
	"ThroughputYear": [{
		click: visitorsChartDrilldownHandler,
		cursor: "pointer",
		explodeOnClick: false,
		legendMarkerType: "square",
		name: "Through Put-Yearly",
		showInLegend: true,
		type: "line",
		dataPoints:<% out.print(dataPointsyear);%>
	}]
	
<% for( i=0;i<listday.size();i++){ %>	
	<% out.print(","+listday.get(i));%>: [{
		color: "#E7823A",
		name: <%  out.print("\""+listday.get(i)+"\"");%>,
		type: "line",
		xValueFormatString: "MMM YYYY",
		dataPoints: <%
		PreparedStatement ps = con.prepareStatement("select  prces_dte, sum((actual*point)) as throughput from transaction a, task b ,users c where a.task_id=b.task_id and a.user_id=c.user_id and to_char(prces_dte,'YYYY')=? and to_char(prces_dte,'Mon')=?  group by prces_dte order by prces_dte asc");
		String x=listday.get(i).substring(0,3);
		String y=listday.get(i).substring(3,7);
		ps.setString(2, x);
		ps.setString(1, y);
		resultSet = ps.executeQuery();
		while(resultSet.next()){
		 xVal = df.format(resultSet.getDate(1));
		 yVal = resultSet.getDouble(2);
		
		 mapday = new HashMap<Object,Object>(); 
			mapday.put("label", xVal); 
			mapday.put("y", yVal);
			listsday.add(mapday);
			dataPointsday = gsonObj.toJson(listsday);
		}
		
		%><% out.print(dataPointsday); %>
	}]
	<%}%>
};

var newVSReturningVisitorsOptions = {
	animationEnabled: true,
	theme: "light2",
	title: {
		text: "Through Put"
	},
	subtitles: [{
		text: "Click on Any Segment to Drilldown",
		backgroundColor: "#2eacd1",
		fontSize: 16,
		fontColor: "white",
		padding: 5
	}],
	legend: {
		fontFamily: "calibri",
		fontSize: 14,
		
	},
	data: []
};

var visitorsDrilldownedChartOptions = {
	animationEnabled: true,
	theme: "light2",
	axisX: {
		labelFontColor: "#717171",
		lineColor: "#a2a2a2",
		tickColor: "#a2a2a2"
	},
	axisY: {
		gridThickness: 0,
		includeZero: false,
		labelFontColor: "#717171",
		lineColor: "#a2a2a2",
		tickColor: "#a2a2a2",
		lineThickness: 1
	},
	data: []
};

newVSReturningVisitorsOptions.data = throughputdata["ThroughputYear"];
$("#chartContainer").CanvasJSChart(newVSReturningVisitorsOptions);

function visitorsChartDrilldownHandler(e) {
	e.chart.options = visitorsDrilldownedChartOptions;
	e.chart.options.data = throughputdata[e.dataPoint.name];
	e.chart.options.title = { text: e.dataPoint.name }
	e.chart.render();
	$("#backButton").toggleClass("invisible");
}

$("#backButton").click(function() { 
	$(this).toggleClass("invisible");
	newVSReturningVisitorsOptions.data = throughputdata["ThroughputYear"];
	$("#chartContainer").CanvasJSChart(newVSReturningVisitorsOptions);
});
})


</script>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
<style>
	#backButton {
		border-radius: 4px;
		padding: 8px;
		border: none;
		font-size: 16px;
		background-color: #2eacd1;
		color: white;
		position: absolute;
		top: 10px;
		right: 10px;
		cursor: pointer;
	}
	.invisible {
		display: none;
	}
</style>
</head>
<body>

<div id="chartContainer" style="height: 300px; width: 100%;"></div>
<button class="btn invisible" id="backButton">< Back</button>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
</body>
</html>