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
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Upload to Decrypt</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>

<% String flag; %>

 <h1>DECRYPTION</h1>
&nbsp;
<form action="upload.jsp" method="post" enctype="multipart/form-data">
Choose the File to be <b>Decrypted</b>: <input accept=" " name="file" type="file" size="50" title="browse the file" required/>
<br /><br /><input type="submit" name= "submit" value="Upload to Decrypt" onclick='form.action='<%flag ="dec"; session.setAttribute("flg",flag);%>'' />
</form>

</body>
</html>
</div>

<% 
}
%>
<jsp:include page="footer.jsp" />

