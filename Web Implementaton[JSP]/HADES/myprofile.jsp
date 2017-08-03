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
	String name="",email="",username="",joined="",pwd="";
	username=(String) session.getAttribute("userid");
	String PublicKey="";
	ResultSet rs;
		
		try
		{
		if (!dobj.connect("localhost","HADES","root","toor"))
			out.println("Database Connection Refused!");
		
		%>
			<jsp:include page="header.jsp" />
			<div class="fullbody">
			<html>
			<head>
			 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title><%=username%> Profile details</title>
			<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
			</head>
			<body>
			<center>
			 <a style="color: #ff3300;"><h1><%=username%>'s Profile </h1></a>
			
			<table style="width: 50%;">
			<%
			rs=dobj.select("select first_name,email,uname,regdate,pass,e from members where uname='"+username+"';");
			while(rs.next())
				{
				name=rs.getString("first_name");
				email=rs.getString("email");
				joined=rs.getString("regdate");
				pwd=rs.getString("pass");
				PublicKey=rs.getString("e");
				%>
			<tr><td>NAME:<a style="color: #02c2f7; font-size: 140%;  float: right;"><%=name%> </a></td> </tr>
			<tr><td>EMAIL:<a style="color: #02c2f7; font-size: 140%;  float: right;"><%=email%></td> </tr>
			<tr><td>DATE JOINED:<a style="color: #02c2f7; font-size: 140%;  float: right;"><%=joined%> </td> </tr>
			<tr><td>USER NAME:<a style="color: #02c2f7; font-size: 140%;  float: right;"><%=username%> </td> </tr>
			<tr><td>PUBLIC KEY:<a style="color: #02c2f7; font-size: 140%;  float: right; width:80%"><input type='text' value='<%=PublicKey%>' readonly /></td> </tr>
			<tr><td>PASSWORD:<a style="color: #02c2f7; font-size: 140%;  float: right; "><%=pwd%>&nbsp;&nbsp;&nbsp;<form action="chngpsswd.jsp" method="post" style="float: right;"><input style="height: 2.5em; font-weight: 700;  display: inline; width: 90%; " type='submit' value="Change Password"  /></form></td> </tr>
			<tr><td><form action="home.jsp" method="post" style="float: left;"><input type='submit' value="Home"  /></form> <form action="delProfile.jsp" method="post" style="float: right;"><input type='submit' value="Delete My Account"  /></form></td> </tr>
			
<%
				}//end of while				
%>
			</table>
			</center> 
			</body>
			</html>
		<jsp:include page="footer.jsp" />
<%

} //try block

catch(SQLException e1)
{
out.println(e1);
}


} //else of ist if
%>			
