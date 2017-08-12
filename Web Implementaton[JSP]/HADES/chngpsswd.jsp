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
if ((request.getParameter("oldpwd") == null) || (request.getParameter("oldpwd") == "")) 
	{ %>
	<jsp:include page="header.jsp" />
	<html>
	<head>
	<title>Change Password of <%=uname%></title>
	<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
	</head>
	<body><br />
	<center>
	<p><h2>Password Reset Form:</h2></p>
	<form action="chngpsswd.jsp" method="post" style="width: 30%;">
	<input type="text" name="oldpwd" placeholder="Enter Your Old Password" title="The password you want to get rid of.." minlength="6" required /><br />
	<input type="password" name="newpwd" placeholder="Enter Your New Password" title="The password you are excited to set.." minlength="6"required /><br />
	<input type="password" name="nwpwd" placeholder="Enter the New Password Again" title="Just checking your memory.." minlength="6" required /><br />
	<input type="submit" value="Reset Password" title="Lets Change It.."  />
	</form>
	</center><br />
	</body>
	</html>
	<jsp:include page="footer.jsp" />
	<% } else {	
		database dobj=new database();
		String oldpwd= request.getParameter("oldpwd");
		String newpwd= request.getParameter("newpwd");
		String repnewpwd= request.getParameter("nwpwd");
		if(newpwd.equals(repnewpwd))
		{
			ResultSet rs;		
				
				if (!dobj.connect("localhost","HADES","root","toor"))
					out.println("Database Connection Refused!");
			rs=dobj.select("select pass from members where pass='" + oldpwd + "';");
			String pw="";
			while(rs.next())
			{
				pw=rs.getString("pass");
			}

			if(oldpwd.equals(newpwd)){%>
				<script language="javascript">
				alert("Whats the fun in Setting the Same Password Again! Old and New Passwords Cant be Same!");
				</script>
			<% response.setHeader("Refresh", "0.1;url=myprofile.jsp");}
			else if (pw.equals(oldpwd)) 
				{					
					dobj.insert("UPDATE members SET pass='"+newpwd+"' WHERE uname='"+uname+"';");
					%>
					<script language="javascript">
					alert("Password Changed Successfully!");
					</script>
					<%  response.setHeader("Refresh", "0.1;url=logout.jsp");		
				} 
			else { %>
				<script language="javascript">
				alert("Wrong Old Password!");
				</script>
				<%  response.setHeader("Refresh", "0.1;url=myprofile.jsp");	
				}
					
		}
		else { %>
			<script language="javascript">
			alert("New Passwords do not match. Poor memory Eh! ;)");
			</script>
			<% response.setHeader("Refresh", "0.1;url=myprofile.jsp");	
		}


}
}
%>

