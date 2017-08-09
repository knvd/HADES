
<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
<jsp:include page="loginpage.jsp" />
<%} 
else 
{
%>
<jsp:include page="header.jsp" />
<html>
<head>
<title>[ENC/DEC] - HADES</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>

<div class="left">
 
 <a style="color: #ff3300;"><h1>ENCRYPTION in 5 Easy Steps:</h1></a>
<ol>
<li style="text-align: center;">
<h4 style="text-align: left;">&nbsp;Upload Your file to be ENCRYPTED.</h4>
</li>
<li style="text-align: left;">
<h4><span style="color: #000000; ">Enter Any Private key and Forget it. You will not need it later.</span></h4>
</li>
<li style="text-align: left;">
<h4><span style="color: #000000; ">Enter Public key of user for whom file is to be Encrypted (Only He/She CAN DECRYPT&nbsp;the file).</span></h4>
</li>
<li style="text-align: left;">
<h4><span style="color: #000000; ">Enter mode of Encryption (more the rounds you choose more the secure encryption it is , obviously at the cost of time.</span></h4>
</li>
<li style="text-align: center;">
<h4 style="text-align: left;"><span style="color: #000000;">Done! Download Your Encrypted File (with .hades extension) and a text file that contains Encryption details.</span></h4>
</li>
</ol>
<br /><br /><br /><br />
<form action="encUpld.jsp" method="get">
<input type="submit" value ="Encrypt a File Now" name="btn1" />
</form>
<br /><br />
</div>

<div class="right">
  <a style="color: #ff3300;"><h1>DECRYPTION in 5 Easy Steps:</h1></a>

<ol>
<li style="text-align: center;">
<h4 style="text-align: left;">&nbsp;Upload Your file to be DECRYPTED.</h4>
</li>
<li style="text-align: left;">
<h4><span style="color: #000000; ">Enter the Cipher text of Key (It is written on the details-file).</span></h4>
</li>
<li style="text-align: left;">
<h4><span style="color: #000000; ">Enter MODE of Decryption. It must be the same MODE with which the file was encrypted (if in doubt check details page)</span></h4>
</li>
<li style="text-align: left;">
<h4><span style="color: #000000;">Enter the Extension of Original file... (You can also find it in details text file)</span></h4>
</li>

<li style="text-align: center;">
<h4 style="text-align: left;"><span style="color: #000000; ">Done! Download Your DECRYPTED File with the original extension (You can also change the extension by renaming the file)  </span></h4>
</li>
</ol>
<br /><br /><br /><br />
<form action="decUpld.jsp" method="get">
<input type="submit" value ="Decrypt a File Now" name="btn2"  />
</form>

<br /><br />

</div>

</html>
<jsp:include page="footer.jsp" />

<% }
%>



