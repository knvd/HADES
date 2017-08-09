
<script type="text/javascript">	//support for place holder IE8 + safari,opera

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
    if ((session.getAttribute("fname") == null) || (session.getAttribute("fname") == "")) {
	%>
<script language="javascript">

alert("No file Selected!");

</script>
<% 	out.println("<p><b><h2>No file Selected! Page will auto refresh</h2></b><p>");
	response.setHeader("Refresh", "1.5;url=decUpld.jsp");
}
else{
%>



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
<title>Decryption Details</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>

<!--  loading circle-->
<script language="javascript">
function loading()
{   
   if(document.getElementById('enpk').value.length >=50 && document.getElementById('xt').value.length>=2)    
    document.getElementById('load').style.display = "block";
}

</script>
	
<div id="load" style="background-image : url('images/loading.gif'); display : none; position : fixed;  opacity : 0.9;  background-position : center; left : 0; bottom : 0; right : 0; top : 0; " >
<a style="color: #ff0505; display : block; position: fixed; height: X px; width: Y px; left:44%; top:45%; margin-top:- X/2 px; margin-left:- Y/2 px;"><b><center><h2> Decrypting File... <br /> Please Wait!</h2></center></b></a>
</div>
 
<!--  loading circle-->


<div id="decdetail" style="width: 50%; padding-right: 20em; padding-left: 20em;">
<br /> <br /><img src = "images/JavaSparrow.jpg"
         alt = "File Upload Sucess" height = "150" width = "170" align="middle" />
<p> <h2> File Uploaded Successfully! </h2></p>

<form action="decprocess.jsp" method="post">
<input name="EnPkey" id="enpk" type="text" title="Cipher Text of Your Private Key" placeholder="Enter the Encrypted Private Key" minlength="50" required /><br /><br /> 

<input type="text" name="ext" id="xt" title="eg .txt,.jgp or pdf,mp4.. etc" placeholder="Enter the Extension to which file will be decrypted" monlength="2" required /> <br />
<center>MODE must be SAME as used while Encryption of this file</center><b>Mode of Decryption:</b>     <select name="mode" title ="More the Rounds.. More the time it consumes... More the Secuirity!" >
  <option value="4">Faster(4-round)</option>
  <option value="8">Fast(8-round)</option>
  <option value="12">Slow(12-round)</option>
  <option value="16">Slower(16-round)</option>
</select>
<br />
<input type="submit" value="Decrypt" onclick="loading()" />
</form>
</div>

</html>

</div>
<jsp:include page="footer.jsp" />
<%
}%>


<%

}	//close(else) --file not selected
%>	


