
<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
<jsp:include page="loginpage.jsp" />
<%} 
else 
{%>
	<jsp:include page="header.jsp" />
	<div class="fullbody">
	<html>
	<head>
	 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Upload to Encrypt</title>
	<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
	</head>

	<% String flag; %>

	 <h1>ENCRYPTION</h1>
	&nbsp;	
	<form action="upload.jsp" method="post" enctype="multipart/form-data">
	Choose the File to be <b>Encrypted</b>: <input accept=" " name="file" type="file" size="50"/ required>
	<br /><br /><input type="submit" name= "submit" value="Upload to Encrypt" onclick='form.action='<%flag ="enc"; session.setAttribute("flg",flag);%>'' />
	</form>
	
	</body>
	</html>
	</div>
	<jsp:include page="footer.jsp" />
	
<% 	
	
}
%>


