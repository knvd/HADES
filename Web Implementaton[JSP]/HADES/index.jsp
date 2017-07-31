<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<a style="color: #ff3300; text-align: center; "> <h1> Introduction</h1></a><br /> 
<p style="text-align: justify;">A H-ybrid A-lgorithm E-ncryption S-ystem (HADES) implementing both DES (modified) and RSA.</p><br />
<p style="text-align: justify;">Name Background: Hades was the <a title="External Wiki Link" href="https://en.wikipedia.org/wiki/Hades" target="_blank">god of the UNDERWORLD in greek Mythology</a>.</p><br />
<p style="text-align: justify;">RSA is a Secure Encryption algorithm but Using RSA algorithm for data encryption is a time consuming process a it is 10x slower than normal DES.On the other hand DES or any Private key algorithm has the drawback of sharing of secret/key.</p><br />
<p style="text-align: justify;">This Hybrid Algorithm uses RSA enc. to encrypt the private key of user and Applies normal round encryption to the data with round specific keys generated from the user private key.<br /> On decryption User provides the RSA encrypted key which is decrypted and data is decrypted like the encryption process, which means we can simply shqre the encrypted key over unreliable channel.<br /> The user can choose no. of rounds to be performed at the cost of time.</p> <br /><br /><br />
</div>

<div class="right">
<a style="color: #ff3300; text-align: center; "> <h2> Sign Up Here:</h2><jsp:include page="reg.jsp" /></a>
</div>

</body>
</html>

</div>
<jsp:include page="footer.jsp" />

