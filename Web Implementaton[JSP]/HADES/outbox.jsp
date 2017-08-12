<%@ page import="hadesED.*"%>
<%@ page import ="java.sql.*" %>


<%
String uname= (String)session.getAttribute("userid");
if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) 
{ %>
			<jsp:include page="loginpage.jsp" />
<%} 
else 
{
String curUser= (String)session.getAttribute("userid");
database dobj=new database();

	ResultSet rs;
		
	try
	{
	if (!dobj.connect("localhost","HADES","root","toor"))
		out.println("Database Connection Refused!");
	int total=dobj.count("select * from messages where sender='"+curUser+"';");

	String reciever="",subject="",file="",tfile="";

	if(total>0)
		{%>
			<jsp:include page="header.jsp" />
			<div class="fullbody">
			<html>
			<head>
			 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title><%=curUser%>'s Outbox</title>
			<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
			</head>
			<body>

			<center>
			<div style=" margin-left: 100px;"> <a style="text-align: left; color: #ff3300; "><h2> <%=curUser%>'s Outbox</h2></a></div>
			
			<table style="width: 85%;">
			<thead align="center"><tr><td><a style="color: #02c2f7; font-size: 150%;"><u>#</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>SENT TO:</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Subject</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Files Sent</u></a></td></tr></thead>

<tr><td colspan="4"><a target="_new" href="inbox.jsp" style="color: #ff3300; float: right;"><h2><u>INBOX</u></h2></a></td></tr>

		<%

			rs=dobj.select("select reciever,subject,file,tfile from messages where sender='"+curUser+"';");
			int sno=0;
			while(rs.next())
				{
				reciever=rs.getString("reciever");
				subject=rs.getString("subject");
				file=rs.getString("file");
				tfile=rs.getString("tfile");
				sno++;
				%>

			<tr align="center">
			<td style="font-size: 120%; color: #000000;"><%=sno%> </td><td style="font-size: 140%; color: #ff3300;;"><%=reciever%> </td> <td><%=subject%></td>
<td><%=file%><br /><%=tfile%></td>

<br /> 
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
{%>
<script>
alert("<%=curUser%>'s Outbox is Empty");
</script>
<jsp:include page="header.jsp" />
<div class="fullbody">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=curUser%>'s Outbox is Empty</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>
<body>
<center>
<a style="text-align: left; color: #ff3300; "><h2> <%=curUser%>'s Outbox</h2></a>			
<table style="width: 80%;">
<thead align="center"><tr><td><a style="color: #02c2f7; font-size: 150%;"><u>FROM:</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Subject</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Files</u></a></td></tr></thead>
<tr><td colspan="3"><a target="_new" href="inbox.jsp" style="color: #ff3300; text-align: right;"><h2><u>INBOX</u></h2></a></td></tr>
<tr ><td colspan="3" align="center"><h2>You have not sent any message Yet! <br /><a href="home.jsp"> Back To Home</a></h2></td> </tr>
</table>
</center> 
</body>
</html>
<jsp:include page="footer.jsp" />

<%}	//close else
}	//try block
catch(SQLException e1)
{
out.println(e1);
}


}
%>
