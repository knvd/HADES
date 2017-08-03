<%@ page import="hadesED.*" %>

<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
<script language="javascript">
	alert("You are not Logged in!");
	</script>
<jsp:include page="loginpage.jsp" />
<%} 
else 
{
%>
<jsp:include page="header.jsp" />
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
<jsp:include page="footer.jsp" />
<% }
%>


