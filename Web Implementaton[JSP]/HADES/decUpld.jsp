
<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
<jsp:include page="loginpage.jsp" />
<%} 
else 
{
%>
<jsp:include page="header.jsp" />
<div class="fullbody">
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Upload to Decrypt</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>

<% String flag; %>
&nbsp;
<marquee style="height: 20px; padding-top: 05px;" bgcolor="#02c2f7">CURRENT UPLOAD LIMIT = <b>150 MB</b></marquee>
 <h1>DECRYPTION</h1>
&nbsp;
<form action="upload.jsp" method="post" enctype="multipart/form-data">
Choose the File to be <b>Decrypted</b>: <input accept=" " name="file" type="file" size="50" title="browse the file" required/>
<br /><br /><input type="submit" name= "submit" value="Upload to Decrypt" onclick='form.action='<%flag ="dec"; session.setAttribute("flg",flag);%>'' />
</form>

</body>
</html>
</div>
<jsp:include page="footer.jsp" />
<% 
}
%>


