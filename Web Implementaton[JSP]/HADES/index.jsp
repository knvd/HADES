<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

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


<jsp:include page="header.jsp" />
<div class="container">

<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HADES-homepage </title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>
<body>

<div class="left">
<a style="color: #ff3300; text-align: center; "> <h1> Introduction</h1></a> 
<p style="text-align: center;"><h2>Hybrid Algorithm Encryption System (HADES).</h2>[Name Background: Hades was the <a title="External Wiki Link" href="https://en.wikipedia.org/wiki/Hades" target="_blank">god of the UNDERWORLD in greek Mythology</a>.]</p>
<p style="text-align: justify;">RSA is the most Secure Encryption Algorithm in the world as of now but Using RSA algorithm for data encryption is a time consuming process as it is <b>10x slower than normal DES</b>. On the other hand DES or any Private key algorithm has the drawback of <b>sharing of secret/key.</b></p>
<p style="text-align: justify;">Our Hybrid Algorithm (HADES) uses RSA encryption to <b>encrypt the private key of user and Applies normal round encryption to the data with round specific keys generated from the user private key.</b> The result is that user do not need to worry about sharing of key, He/She can share the key over any unreliable medium or give it to anyone, Because No one in the world (as of now) can decrypt it except the user for whom it was encrypted. The RSA is not used for data encryption which gives an edge over the speed of process. <br /><br />  On Decryption side User needs to provide the RSA-Encrypted key which is Decrypted and data is decrypted like the encryption process.<br /> The user can choose mode of encryption [i.e ,<b>Faster(4-rounds),Fast(8-rounds),Slow(12-rounds),Slower(16-rounds)</b>] based on number of Rounds to be performed <b>at the cost of time</b>. The file must be decrypted using the same mode with which it was encrypted.</p> 
<p style="text-align: justify;"> In the Dyanamic Implementation of this Algorithm, Each user is assigned a public key, which is shown on his homepage. However only the user has its 'd' and 'n' pair which means any file encrypted with the users public key can only be decrypted by that user.</p> <br />
</div>


<div class="right">
<br /> <a style="color: #ff3300; text-align: center; "> <h2> Sign Up Here:</h2> 
<center>
<div id="reg" style="width:80%; " >

<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>

<form method="post" action="registration.jsp" name='registration'>
<br />
<input type="text" name="fname" value="" title="Your Name Please" placeholder="Full Name" minlength="6" maxlength="30" required/><br />
<input type="email" name="email" value="" title="Your Email id Please" placeholder="Email" minlength="8" maxlength="40" required /><br />
<input type="text" name="uname" value="" title="We Call you Uniquely!" placeholder="User Name" minlength="4" maxlength="30" required /><br />
<input type="password" name="pass" value="" title="Your Name Please" placeholder="Password" minlength="6" maxlength="40" required/><br /><br />
<input type="submit" value="Create an acount" /> 
</form>

<%} 
else 
{
out.println("<br /><h2>You are Already Logged in as <a href='myprofile.jsp'>'"+(session.getAttribute("userid"))+"'</a></h2><br />");
out.println("<center><h2><a href='logout.jsp'>Log Out</a></h2><br /><br /></center>");

}

%>

</div>
   </center>
</a>
</div>

</body>
</html>

</div>
<jsp:include page="footer.jsp" />

