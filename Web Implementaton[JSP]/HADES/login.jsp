<%@ page import ="java.sql.*" %>
<%@ page import="hadesED.*"%>

<%
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
		response.sendRedirect("home.jsp");
	} else {%>
<jsp:include page="header.jsp" />        

<div class="fullbody">
<html>
<head>
<title>Login failed!</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>
<h2>No Such User Exists! Invalid username/password <a href='index.jsp'>Try Again</a></h2>

</html>

</div>
<jsp:include page="footer.jsp" />

<%    
}
%>

