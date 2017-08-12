<%@ page import="java.io.*,java.util.*,java.lang.*" %>
<%@ page import="hadesED.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.math.BigInteger"%>
			
<%
if ((request.getParameter("pkey") == null) || (request.getParameter("pkey") == "")) 
{ %>
	<script language="javascript">
	alert("Session Expired!");
	</script>
	<% 	out.println("<p><b><h2>Your Session Expired! Page will auto refresh</h2></b><p>");
		response.setHeader("Refresh", "1;url=encUpld.jsp");
	}
	else{
		if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) 
		{ %>
			<jsp:include page="loginpage.jsp" />
		<%} 
		else 
		{
		%>

		<%
		String filename=(String) session.getAttribute("fname");
		String orginalName=filename;
		//filename=filename.replaceAll(" ", "-");		//remove spaces if any
		String dname=(String) session.getAttribute("dirname");
		session.setAttribute("Edirname",dname);
		String key = request.getParameter("pkey");
		String pubkey = request.getParameter("pubkey");
		int rounds= Integer.parseInt(request.getParameter("mode"));
		 	
		//get n from db
		database dobj=new database();
		String enn="";
		ResultSet rs;
		
		try
		{
		   if (!dobj.connect("localhost","HADES","root","toor"))
			out.println("Database Connection Refused!");

			if(dobj.count("select * from members where e='"+pubkey+"';")>=1)	//check for valid pub key
			{
				rs=dobj.select("select n from members where e='"+pubkey+"';");
				while(rs.next())
				{
				enn=rs.getString("n");
				}
			
				key=FunctionSet.KeyGen(key);
				BigInteger m=new BigInteger(key);
				BigInteger e=new BigInteger(pubkey);
				BigInteger n=new BigInteger(enn);

				BigInteger Enkey=RsaFunctionClass.EncDec(m, e,n);	//RSA-Encrypt the key
				String keyloc=RsaFunctionClass.WriteEncKey(Enkey,e, dname, filename,rounds);	//write RSA cipher text to file for further use

				EncDec obj=new EncDec();				
				obj.encrypt(filename,dname,key,rounds);

				File delorg =new File(dname+"/"+orginalName);		//delete uploaded
				delorg.delete();
	

				if (filename.contains("."))
					filename=filename.substring(0,filename.lastIndexOf("."));
								    
			%>
			<jsp:include page="header.jsp" />
			<div class="fullbody">
			<html>
			<head>
			<title>HADES Encryption Successful</title>
			<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
			</head>

			<%
			String EncFname = filename+".hades";
			session.setAttribute("Efname",EncFname);

			String keyfile=keyloc.substring(keyloc.lastIndexOf("/")+1);
			keyloc=keyloc.substring(0,keyloc.lastIndexOf("/"));
			session.setAttribute("Kfname",keyfile);
			session.setAttribute("Kdirname",keyloc);

			%>
			<center>
			<br /><br />File ENCRYPTION Successful! Encrypted File: <b>"<%=EncFname%>"</b>. <br/><br/>
			Your Encrypted-Key (Cipher Text) <b>"<%=keyfile%>"</b> Generated Successfully!
			<br/><br/>

			<form action="FileKeyDwnld.jsp" method="post" style="display: inline;">
			<br />Download Your Encrypted Files:<br /><br />
			<input type="radio" name="Dbutton" value="Efile" checked>Encrypted File "<%=EncFname%>"
			<br />
			<input type="radio" name="Dbutton" value="Kfile">Encrypted-Key-File "<%=keyfile%>"
			<br/> <br />
			 <input type="submit" value="Download">
			</form>
			
			<form action="sendfile.jsp" method="post" style="display: inline;">
			<input type="submit" value="Send as Message to Another User">	<br/> <br />		
			</form>
			</center>


			</html>
			</div>
			<jsp:include page="footer.jsp" />
		<% }		//close if(pub key)

		else
		{
		%>
		<script language="javascript">
		alert("Not a Valid Public key!");
		</script>
		<% 	out.println("<p><b><h2>You have Provided an Invalid Public Key!</h2></b><p>");
			response.setHeader("Refresh", "1;url=encUpld.jsp");
		}

		} //try block
			catch(SQLException e)
			{
			out.println(e);
			}

	}	//close(else) user not logged in
	

}	//close(else) --session expiry
%>


