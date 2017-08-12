<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="hadesED.*"%>

<% 
database dobj=new database();
	ResultSet rs;
		if (!dobj.connect("localhost","HADES","root","toor"))
				out.println("Database Connection Refused!");

if ((request.getParameter("name") == null) || (request.getParameter("name") == "")) 
{ 
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
<jsp:include page="header.jsp" />

<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Contact HADES</title>    
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>

</head>
<body>
<center>
<div id="contact" style="width:40%; " >
<br /> <a style="color: #000000; text-align: center; "> <h1> Hey Stranger Leave a Message for Us:</h1> 
<form method="post" action="contact.jsp" name='contact'>
<br />
<input type="text" name="name" value="" title="Your Name Please" placeholder="Full Name" minlength="6" maxlength="30" required/><br />
<input type="email" name="email" value="" title="How can we Reach back to You" placeholder="Email Id" minlength="8" maxlength="40" required /><br />
<input type="text" name="message" value="" title="Leave a Message!" placeholder="Leave a Message for Us in 300 characters" minlength="10" maxlength="300" required /><br />
<input type="submit" value="Contact Us" /> 
</form>
</a>
</div>
   </center>

</body>
</html>
<jsp:include page="footer.jsp" />

<%} 
else 
{
String user= (String)session.getAttribute("userid");
String mail="";
	
	rs=dobj.select("select email from members where uname='" + user + "';");
	while (rs.next()) 
	{
		mail=rs.getString("email");
	}
	
%>
<jsp:include page="header.jsp" />
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Contact HADES</title>    
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>

</head>
<body>
<center>
<div id="contact" style="width:40%; " >
<br /> <a style="color: #000000; text-align: center; "> <h1> Hey <b><%=user%></b>, Leave a Message for Us:</h1> 
<form method="post" action="contact.jsp" name='contact'>
<br />
<input type="text" name="name" value="<%=user%>" title="Your Name Please"  minlength="6" maxlength="30" readonly required/><br />
<input type="email" name="email" value="<%=mail%>" title="How can we Reach back to You"  minlength="8" maxlength="40" readonly required /><br />
<input type="text" name="message" value="" title="Leave a Message!" placeholder="Leave a Message for Us in 300 characters" minlength="10" maxlength="300" required /><br />
<input type="submit" value="SEND" /> 
</form>
</a>
</div>
   </center>

</body>
</html>
<jsp:include page="footer.jsp" />
<%
}
}//ist if
else
{
dobj.insert("CREATE TABLE IF NOT EXISTS contact (id int(10) unsigned NOT NULL PRIMARY KEY auto_increment, name varchar(45) NOT NULL, email varchar(45) NOT NULL, message varchar(300) NOT NULL);");

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

boolean ifins = dobj.insert("insert into contact(name, email, message) values ('" + name + "','" + email + "','" + message + "');");

    if (ifins) 
    {%>	
	<script>alert("Dear <%=name%>, We have Recieved your Message... We'll Get back to You very Soon");</script>
    <%
	response.setHeader("Refresh", "0.1;url=home.jsp");
	} else {
        
	out.println("\nError Inserting Data to Database...");
	response.setHeader("Refresh", "0.1;url=index.jsp");
    }

}
%>

