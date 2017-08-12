<%@ page import ="java.sql.*" %>
<%@ page import="hadesED.*"%>

<script type="text/javascript">	//support for placeholder IE8 + safari,opera

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
String username=(String)session.getAttribute("userid");
database dobj=new database();
ResultSet rs;
String publickey="";
if (!dobj.connect("localhost","HADES","root","toor"))
			out.println("Database Connection Refused!");
try
{
	
rs=dobj.select("select e from members where uname='"+username+"';");
while(rs.next())
	{
	publickey=rs.getString("e");
	}
}
catch(SQLException e1)
{
out.println(e1);

}
session.setAttribute("pkey",publickey);
 %>


<html>
<head>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
<link rel='shortcut icon' type='text/css' href='images/favicon.ico'/>
</head>


<header>
<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>

<div id="righthead" style="width:300px; margin-right:50px; float:right; " >
<form method="post" action="login.jsp">
<p style="font-size: 70%; color: #ff3300;" ><b><br />You are not Logged in! </b></p>
<input type="text" name="uname" value="" placeholder="User Name" title="username" minlength="4" maxlength="30" required />
<input type="password" name="pass" value="" placeholder="Password" title="password" minlength="6" maxlength="40" required/>
<br /><input type="submit" value="Login" title="login" />
 </form>
</div>

<%} else {
%>

<div id="righthead-w" style="width:300px; margin-right:5px; float: right; " >
<p style="font-size: 70%; float: right;">Welcome <a style="color: #ff3300; font-size: xx-large;"><b><%=session.getAttribute("userid")%></b></a>
</p>
</div>

<%	
    }

%>


  <a href="home.jsp"><img src="images/head1.png" height="150" width="150" style="margin-left: 30px; margin-top: 30px; margin-right: 10px; margin-bottom: 10px; float: left;" /></a>  
	<a style="text-align: center; "><h1><a style="color: #000000;">------------------- </a>HADES </h1></a>
  <a style="color: #fff960; text-align: left;"><h3>Hybrid Algorithm Data Encryption Service</h3> </a> 

</div>

<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
<p  style="font-size: 80%; color: #fff960; text-align: left; margin-left: 200px;"><b><br /><br />No Public Key to Show. Please Login! <br /> <br /> 

<%} 
else 
{
	if(!publickey.equals("0"))
	{
%>

<p style="font-size:80%; color: #fff960; text-align: left; margin-left: 200px;"><br /> <a style="color: #ff3300;">&emsp;Public Key of  <b><%=username%></b> :</a> <input type="text" name="pkey" readonly value="<%=publickey%>"> </p>

<%
	}
	else
	{
%>
<marquee style="font-family:Book Antiqua; color: #000000" bgcolor="#e6ffff" scrolldelay="35"><p>Dear <b><%=username%></b> You have NOT Generated Your PUBLIC KEY yet! <a href="OTednGen.jsp"><b> --GENERATE NOW--</b></a></marquee>
<%
    	}
}

%>


</header> 
<div>
<ul>
 
<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
<li><a href="index.jsp">Home</a></li>
 <li><a href="contact.jsp">Contact</a></li>
  <li><a href="about.jsp">About</a></li>
  <li style="float: right;"><a href="loginpage.jsp">Login</a></li>
<li style="float: right;"><a href="reg.jsp">Register</a></li>

<%}
else
{%>
  <li><a target="_parent" href="index.jsp">Home</a></li>
<li><a target="_new" href="showPubKeys.jsp">Browse Public Keys</a></li>
  <li><a href="encUpld.jsp">Encrypt File</a></li>
  <li><a href="decUpld.jsp">Decrypt File</a></li>
 <li><a target="_new" href="contact.jsp">Contact</a></li>
  <li><a target="_new" href="about.jsp">About</a></li>
<li style="float: right;"><a target="_new" href="myprofile.jsp">My Profile</a></li>
<li style="float: right;"><a target="_new" href="inbox.jsp"><b>Inbox</b></a></li>
 <li style="float: right;"><a href="logout.jsp">Log Out</a></li>
<%}
%>
</ul>

</div>	
</html>

