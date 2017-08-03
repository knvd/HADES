<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="hadesED.*"%>

<%

    if ((request.getParameter("uname") == null) || (request.getParameter("uname") == "") || request.getParameter("pass") == null) 
	{
		response.sendRedirect("index.jsp");
	}
	else 
	{
	String userid = request.getParameter("uname");    
	String pwd = request.getParameter("pass");

	database dobj=new database();
	ResultSet rs;
		if (!dobj.connect("localhost","HADES","root","toor"))
				out.println("Database Connection Refused!");
	rs=dobj.select("select * from members where uname='" + userid + "' and pass='" + pwd + "'");
	if (rs.next()) {
		session.setAttribute("userid", userid);
		//out.println("welcome " + userid);
//make user folder if not exists
	String strProjectDir = request.getRealPath("/users/");
	File ProjectDir = new File(strProjectDir); 
	if(!ProjectDir.exists()) 
		ProjectDir.mkdir(); 
	File usrdir = new File(strProjectDir+"/"+userid);
	if(!usrdir.exists()) 
		usrdir.mkdir(); 
	
	response.sendRedirect("home.jsp");
	}
	 else {%>
<html>
<head>
<title>Login failed!</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>
<script language="javascript">
	alert("No User named <%=userid%> Exists! Invalid username/password !");
	</script>
<jsp:include page="loginpage.jsp" />
</html>


<%    
}
}	//close else of ist if
%>

