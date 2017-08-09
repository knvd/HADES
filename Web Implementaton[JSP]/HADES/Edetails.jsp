
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

   
});


</script>


<%
    if ((session.getAttribute("fname") == null) || (session.getAttribute("fname") == "")) {
	%>
<script language="javascript">

alert("No file Selected!");

</script>
<% 	out.println("<p><b><h2>No file Selected! Page will auto refresh</h2></b><p>");
	response.setHeader("Refresh", "1.5;url=encUpld.jsp");
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

<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Encryption details</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>


<!--  loading circle-->
<script language="javascript">
function loading()
{   
  if(document.getElementById('pk').value.length >=16 && document.getElementById('pubk').value.length>=100)  
    document.getElementById('load').style.display = "block";
}

</script>
	
<div id="load" style="background-image : url('images/loading.gif'); display : none; position : fixed;  opacity : 0.9;  background-position : center; left : 0; bottom : 0; right : 0; top : 0; " >
<a style="color: #ff0505; display : block; position: fixed; height: X px; width: Y px; left:44%; top:45%; margin-top:- X/2 px; margin-left:- Y/2 px;"><b><center><h2> Encrypting File... <br /> Please Wait!</h2></center></b></a>
</div>
 
<!--  loading circle-->


<% String pubkey = (String) session.getAttribute("pkey");%>
<div class="fullbody">
<script language="javascript">
function insertText(txt)
{   
    
    document.getElementById('pubk').value = "<%=pubkey%>";
}

</script>


<div id="encdetail" style="width: 50%; padding-right: 20em; padding-left: 20em;">
<br /><br /> <img src = "images/JavaSparrow.jpg"
         alt = "File Upload Sucess" height = "150" width = "170" />

<p> <h2> File Uploaded Successfully! </h2><br /></p>

<form action="encprocess.jsp" method="post">
<input name="pkey" type="text" id="pk" title="Enter and Forget. You won't need it later!" placeholder="One Time Private Key" minlength="16" required /><br />
<center>Use your OWN PUBLIC KEY if You want to ENCRYPT it for YOURSELF</center> 
<input name="pubkey" type="text" id="pubk" title="Valid Public key consists of Numbers Only" minlength="100" placeholder="Enter Public key of Intended User(Only He/She can Decrypt the file)" required />
<br /><input type="button" value="Use My Own Public Key" title="Only You can Decrypt This file!" onclick="insertText()" /><br /><br />
<b>Mode of Encryption: </b>[Use SAME MODE Later to DECRYPT]<br /><br /> <select name="mode" title ="More the Rounds.. More the time it consumes... More the Secuirity!" >
  <option value="4">Faster(4-round)</option>
  <option value="8">Fast(8-round)</option>
  <option value="12">Slow(12-round)</option>
  <option value="16">Slower(16-round)</option>
</select>

<br /><br />
<input type="submit" value="Encrypt"  onclick="loading()"/>
</form>

</div>



</html>
</div>
<jsp:include page="footer.jsp" />
<%
}//close(else) --not logged in selected
%>

	
<%

}	//close(else) --file not selected
%>	


