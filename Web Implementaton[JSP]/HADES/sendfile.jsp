<%@ page import="hadesED.*"%>
<%@ page import ="java.sql.*" %>

<%

if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) 
{ %>
			<jsp:include page="loginpage.jsp" />
<%} 
else if((session.getAttribute("Efname")==null) || (session.getAttribute("Efname") == ""))
{%>
<script>
alert("No Encrypted File Found! Encrypt a File first");
</script>
	<jsp:include page="encUpld.jsp" />
<%}
else 
{

String curUser= (String)session.getAttribute("userid");
String Encfile=(String)session.getAttribute("Efname");
String EDir=(String)session.getAttribute("Edirname");
String Txtfile=(String)session.getAttribute("Kfname");
String txtDir=(String)session.getAttribute("Kdirname");
database dobj=new database();
ResultSet rs;
if (!dobj.connect("localhost","HADES","root","toor"))
			out.println("Database Connection Refused!");
 
if ((request.getParameter("subject") == null) || (request.getParameter("subject") == "")) 
	{ %>
	<jsp:include page="header.jsp" />
	<html>
	<head>
	<title>Send File to User</title>
	<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
	</head>
	<body><br />
	<center>
	<p><h2>Send an Encrypted File and Cipher Key Details to User </h2></p><br />
	<form action="sendfile.jsp" method="post" style="width: 40%;">
	Select the Recipient: <select name="users" title ="Select The Recipient" >
	<option value="">Select the Reciever</option>
	<%	try
		{
	
		rs=dobj.select("select uname from members where uname NOT IN('"+ curUser +"');");
		while(rs.next())
			{
			String users=rs.getString("uname");
			%>
			<option value="<%=users%>"><%=users%></option>
			<%}
		}
		catch(SQLException e1)
		{
		out.println(e1);
		}
	%>
	</select><br /><br />
	Write a Subject Line: <input type="text" name="subject" placeholder="Enter Subject line" title="Something about the file" minlength="6" maxlength="180" required /><br /><br />
	<input type="submit" value="Send Files" title="Lets Go.."  />
	</form>
	</center><br />
	</body>
	</html>
	<jsp:include page="footer.jsp" />

	<%}	//close if
else
{
	String reciever= request.getParameter("users");
	String subject= request.getParameter("subject");

	boolean ifins = dobj.insert("insert into messages(reciever, sender, subject, file, tfile, edir, txtdir) values ('" + reciever + "','" + curUser + "','" + subject + "','" + Encfile + "','" + Txtfile + "','" + EDir + "','" + txtDir + "');");
%>
	<script>
	alert("Message Sent to <%=reciever%>!");
	</script> 

<%
	response.setHeader("Refresh", "0.1;url=home.jsp");
}

}
%>


