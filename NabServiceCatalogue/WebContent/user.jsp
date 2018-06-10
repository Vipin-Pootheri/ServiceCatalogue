<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div id=message>Hello <%=request.getParameter("username") %></div>
<%
String username=request.getParameter("username");
Class.forName("oracle.jdbc.OracleDriver");
Connection con =DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","API5AFS","api5afs");
Statement stmt=con.createStatement();  
PreparedStatement statement = con.prepareStatement("with fulldate as( select to_date('28-may-2018','dd-mon-yyyy') + rownum -1 as curr_dates from all_objects where rownum <= to_date(to_char(sysdate,'dd-mon-yyyy'),'dd-mon-yyyy')-to_date('28-may-2018','dd-mon-yyyy')+1 )select curr_dates from fulldate where MOD(TO_CHAR(curr_dates, 'J'), 7) + 1 not in (6,7) minus select prces_dte from transaction where user_id=(select user_id from users where userid=?)");
//setting the parameters
statement.setString(1, username);
ResultSet rs1 = statement.executeQuery();

%>
<select name=dates>
<%	
while(rs1.next()){
	rs1.next();
%>
<option value=<%=rs1.getDate(1) %>><%=rs1.getDate(1) %></option><br>

<%	
}
con.close();
%>
</select>


</body>
</html>