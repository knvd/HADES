<%@ page import="hadesED.*" %>
<jsp:include page="header.jsp" />
<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
<div class="fullbody">
<br /><h2>Nothing to Show! You are not Logged in to our Systems! <b><a href="index.jsp">Please Login</a></b> </h2><br /><br />
</div>
<%} 
else 
{
%>
<div class="fullbody">
<html>
<head>
<title>One Time Public Key Generation -HADES</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>

<% String username=(String)session.getAttribute("userid"); %>

<form name=frm action=home.jsp>
<br /> <br/>
Please Generate One Time-Public key for the User :<b> <%=username%> </b>(Hit this Button Only Once)   
<input type="submit" value="Generate" onclick="form.action='<%
RsaFunctionClass.e_dGen(username);%>',this.style.visibility='hidden';"><br/>
Done Generation!<input type="submit" value="Done Lets Go"> 
</form>


</html>
</div>
<% }
%>

<jsp:include page="footer.jsp" />
