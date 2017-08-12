<%@ page import="hadesED.*"%>
<%@ page import ="java.sql.*" %>

<%
if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) 
{ %>
			<jsp:include page="loginpage.jsp" />
<%} 
else 
{
//get uname nd pub key from db
	database dobj=new database();
	String username="";
	String PublicKey="";
	ResultSet rs;
		
		try
		{
		   if (!dobj.connect("localhost","HADES","root","toor"))
			out.println("Database Connection Refused!");
		int total=dobj.count("select * from members;");
		if(total>0)
		{%>
			<jsp:include page="header.jsp" />
			<div class="fullbody">
			<html>
			<head>
			 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title>Public Keyy of Users</title>
			<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
			</head>
			<body>
			<center>
			 <h2><br /> To Encrypt for a Specific USER, use His/Her respective Public key. <br />(Only the respective user can decrypt the file later)</h2>			
			<table style="width: 70%; ">
			<thead align="center"><tr><td><a style="color: #02c2f7; font-size: 150%;"><u>User Name</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Public Key</u></a></td></tr></thead>
		<%
			rs=dobj.select("select uname,e from members;");
			while(rs.next())
				{
				username=rs.getString("uname");
				PublicKey=rs.getString("e");
				%>
			<tr align="center">
			<td style="font-size: 140%; color: #ff3300;"><%=username%> </td> <td><input type='text' value='<%=PublicKey%>' readonly /></td><br /> 
			</tr>
<%
				}//end of while				
%>
			</table>
			</center> 
			</body>
			</html>
		<jsp:include page="footer.jsp" />
<%
}//close if
else		//if(tot)
{
out.println("<h1>The table is Empty!</h1>");
response.sendRedirect("home.jsp");
}
}
catch(SQLException e1)
{
out.println(e1);
}

} //ist if
%>			
