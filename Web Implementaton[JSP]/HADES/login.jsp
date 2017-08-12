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
	rs=dobj.select("select uname,pass from members where uname='" + userid + "' and pass='" + pwd + "';");
	String un="",pw="";
	while(rs.next())
	{
		un=rs.getString("uname");
		pw=rs.getString("pass");
	}
	if (un.equals(userid) && pw.equals(pwd)) {
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
	alert("Invalid UserId/Password. Try Again !");
	</script>
<jsp:include page="loginpage.jsp" />
</html>


<%    
}
}	//close else of ist if
%>

