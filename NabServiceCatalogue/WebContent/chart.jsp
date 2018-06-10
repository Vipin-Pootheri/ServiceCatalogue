<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*,java.text.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
 
<%
Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
String dataPoints = null;
 
try{
	Class.forName("oracle.jdbc.OracleDriver"); 
	
	Connection con =DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","API5AFS","api5afs");
	Statement stmt=con.createStatement();  
	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");  
	
	String xVal;
	double yVal;
	
	ResultSet resultSet = stmt.executeQuery("select prces_dte,sum((actual*point)) as throughput from transaction a, task b ,users c where a.task_id=b.task_id and a.user_id=c.user_id group by prces_dte order by prces_dte asc");
	
	while(resultSet.next()){
		xVal = df.format(resultSet.getDate(1));
		yVal = resultSet.getDouble(2);
		map = new HashMap<Object,Object>(); 
		map.put("label", xVal); 
		map.put("y", yVal);
		list.add(map);
		
		dataPoints = gsonObj.toJson(list);

	}
	con.close();
	
	
}
catch(SQLException e){
	out.println("<div  style='width: 50%; margin-left: auto; margin-right: auto; margin-top: 200px;'>Could not connect to the database. Please check if you have mySQL Connector installed on the machine - if not, try installing the same.</div>");
	
}
%>
 
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
window.onload = function() { 
 alert("HI")
<% if(dataPoints != null) { %>

var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	exportEnabled: true,
	title: {
		text: "Through Put "
	},
	data: [{
		type: "line", //change type to bar, line, area, pie, etc
		dataPoints: <% out.print(dataPoints);%>
	}]
});
chart.render();
<% } %> 
 
}
</script>
</head>
<body>
<div id="chartContainer" style="height: 370px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>