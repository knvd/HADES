<%@ page import="hadesED.*"%>
<%@ page import ="java.sql.*" %>

<%

if ((request.getParameter("username") == null) || (request.getParameter("username") == "")) 
	{ %>
	<jsp:include page="header.jsp" />
	<html>
	<head>
	<title>Forgot Password!</title>
	<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
	</head>
	<body><br />
	<center>
	<p><h2>Password Reset Form:</h2></p>
	<form action="forgotpsswd.jsp" style="width: 30%;" method="post">
	<input type="text" name="username" placeholder="Enter Your User Name" title="Your User Name" minlength="4" required /><br />
	<input type="email" name="email" placeholder="Enter Your email registered with us " title="Your email" minlength="8" required /><br />
	<input type="password" name="nwpwd" placeholder="Enter the New Password" title="Your new Password" minlength="6" required /><br />
	<input type="submit" value="Reset Password" title="The password you want to get rid of.."  />
	</form>
	</center><br />
	</body>
	</html>
	<jsp:include page="footer.jsp" />
	<% } else {	
		database dobj=new database();
		String user= request.getParameter("username");
		String email= request.getParameter("email");
		String pswd= request.getParameter("nwpwd");
		
		ResultSet rs;		
				
		if (!dobj.connect("localhost","HADES","root","toor"))
			out.println("Database Connection Refused!");
		if(dobj.count("select * from members where uname='"+user+"';")>=1)
		{
			String orgEmail="";					
			rs=dobj.select("select email from members where uname='"+user+"';");
			while(rs.next())
			{
			orgEmail=rs.getString("email");
			}
			if(email.equals(orgEmail))
			{
				dobj.insert("UPDATE members SET pass='"+pswd+"' WHERE uname='"+user+"';");
				%>
				<script language="javascript">
				alert("Password Changed Successfully!");
				</script>
				<%  response.setHeader("Refresh", "0.1;url=loginpage.jsp");		
			} else { %>
				<script language="javascript">
				alert("<%=email%> does not Match!");
				</script>
				<%  response.setHeader("Refresh", "0.1;url=loginpage.jsp");	
				}
					
		}
		else 
		{ %>
			<script language="javascript">
			alert("UserName '<%=user%> ' does not Exist!");
			</script>
			<%  response.setHeader("Refresh", "0.1;url=loginpage.jsp");	
		}
		
		
}

%>

