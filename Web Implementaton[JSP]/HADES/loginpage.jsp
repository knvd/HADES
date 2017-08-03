
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
</head>
<body>
<center>
<div id="login" style="width:30%; " >
<br />
<form method="post" action="login.jsp" style="display: inline; ">
<p style="font-size: 150%; color: #ff3300; text-align: center; " ><b>You are not Logged in! </b></p><br />
<input type="text" name="uname" value="" placeholder="User Name" title="username" minlength="4" maxlength="30" required /><br />
<input type="password" name="pass" value="" placeholder="Password" title="password" minlength="6" maxlength="40" required/><br />
<br /><input type="submit" value="Login" title="login" style="float: right;"/>
 </form>
<form method="post" action="forgotpsswd.jsp" style="display: inline-block; float: left;">
<input type="submit" value="Forgot Password?" title="Forgetting is Human..."   /> 
 </form><br /> <br /> <br />
</div>
</center>
</body>
</html>
<jsp:include page="footer.jsp" />
<%} 
else 
{
out.println("<br /><h2>You are Already Logged in as '"+(session.getAttribute("userid"))+"'</h2><br />");
out.println("<center><h2><a href='logout.jsp'>Log Out</a></h2><br /><br /></center>");

}

%>
