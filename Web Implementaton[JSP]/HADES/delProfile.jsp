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
if ((request.getParameter("pwd") == null) || (request.getParameter("pwd") == "")) 
	{ %>
	<jsp:include page="header.jsp" />
	<html>
	<head>
	<title>Delete Acount of <%=uname%></title>
	<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
	</head>
	<body><br />
	<center>
	<p><h2>Permanently Delete <%=uname%>'s Account </h2></p>
	<form action="delProfile.jsp" method="post" style="width: 30%;">
		<input type="password" name="pwd" placeholder="Enter Your Password to Confirm" title="We are sad to watch you leaving.." minlength="6" required /><br />
	<input type="submit" value="Confirm Delete" title="GoodBye!"  />
	</form>
	</center><br />
	</body>
	</html>
	<jsp:include page="footer.jsp" />
	<% } else {	
		database dobj=new database();
	
		String pwd= request.getParameter("pwd");
			ResultSet rs;		
				
				if (!dobj.connect("localhost","HADES","root","toor"))
					out.println("Database Connection Refused!");
				if(dobj.count("select * from members where pass='"+pwd+"';")>=1)
				{					
					dobj.insert("DELETE FROM members WHERE uname='"+uname+"';");
					%>
					<script language="javascript">
					alert("Acount deleted Successfully!");
					</script>
					<%  response.setHeader("Refresh", "0.1;url=logout.jsp");		
				} else { %>
				<script language="javascript">
				alert("Wrong Password!");
				</script>
				<%  response.setHeader("Refresh", "0.1;url=myprofile.jsp");	
				}					
		
}
}
%>

