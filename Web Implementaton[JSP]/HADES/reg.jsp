<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<script type="text/javascript">		//support for placeholder IE8 + safari,opera

  function supports_input_placeholder()
  {
    var i = document.createElement('input');
    return 'placeholder' in i;
  }

  if(!supports_input_placeholder()) {
    var fields = document.getElementsByTagName('INPUT');
    for(var i=0; i < fields.length; i++) {
      if(fields[i].hasAttribute('placeholder')) {
        fields[i].defaultValue = fields[i].getAttribute('placeholder');
        fields[i].onfocus = function() { if(this.value == this.defaultValue) this.value = ''; }
        fields[i].onblur = function() { if(this.value == '') this.value = this.defaultValue; }
      }
    }
  }

</script>

<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>

<jsp:include page="header.jsp" />
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>New User Registration</title>    
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>

</head>
<body>
<center>
<div id="reg" style="width:40%; " >
<br /> <a style="color: #ff3300; text-align: center; "> <h1> Sign Up Here:</h1> 
<form method="post" action="registration.jsp" name='registration'>
<br />
<input type="text" name="fname" value="" title="Your Name Please" placeholder="Full Name" minlength="6" maxlength="30" required/><br />
<input type="email" name="email" value="" title="Your Email id Please" placeholder="Email" minlength="8" maxlength="40" required /><br />
<input type="text" name="uname" value="" title="We Call you Uniquely!" placeholder="User Name" minlength="4" maxlength="30" required /><br />
<input type="password" name="pass" value="" title="Your Name Please" placeholder="Password" minlength="6" maxlength="40" required/><br /><br />
<input type="submit" value="Create an acount" /> 
</form>
</div>
   </center>

</body>
</html>
<jsp:include page="footer.jsp" />
<% } 
else 
{%>
<script language="javascript">
	alert("You are Already Logged in!");
	</script>
<jsp:include page="header.jsp" />
<% 
out.println("<br /><h2>You are Already Logged in as <a href='myprofile.jsp'>'"+(session.getAttribute("userid"))+"'</a></h2> <br />");
out.println("<center><h2><a href='logout.jsp'>Log Out</a></h2><br /><br /></center>");
%>
<jsp:include page="footer.jsp" />
<%
}
%>

%>

