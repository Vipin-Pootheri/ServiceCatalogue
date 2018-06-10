
import java.sql.*;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loginRequest")
public class loginrequest extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String username = request.getParameter("username");
       String password = request.getParameter("password");
       PrintWriter pw=response.getWriter();
       response.setContentType("text/html");
    //    String username = "Vipin";
   //     String password = "Vipanchika012";
        
        String message=null;
        try {
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}
        try {
			Connection con =DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","API5AFS","api5afs");
			Statement stmt=con.createStatement();  
			PreparedStatement statement = con.prepareStatement("SELECT USERID, PASSWORD FROM USERS WHERE USERID = ? AND PASSWORD = ?");
            //setting the parameters
            statement.setString(1, username);
            statement.setString(2, password);
            //executing the prepared statement, which returns a ResultSet
            ResultSet rs = statement.executeQuery();
            if(rs.next()){
            	 RequestDispatcher rd=request.getRequestDispatcher("user.jsp");  
                 rd.include(request,response); 
            	
            }else{
            	pw.print("<div id=message>Sorry username or password error</div>");  
                RequestDispatcher rd=request.getRequestDispatcher("HomePage.html");  
                rd.include(request,response);  
            }
           
           
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
        
}
}