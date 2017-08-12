<%@ page import="java.io.*,java.util.*,java.lang.*" %>
<%@ page import="hadesED.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.math.BigInteger"%>

<%
if ((request.getParameter("EnPkey") == null) || (request.getParameter("EnPkey") == "")) 
{
%>
	<script language="javascript">
	alert("Session Expired!");
	</script>
	<% 	out.println("<p><b><h2>Your Session has expired! Page will auto refresh</h2></b><p>");
		response.setHeader("Refresh", "1;url=decUpld.jsp");
	}
else{


	if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) 
	{
	%>
		<jsp:include page="loginpage.jsp" />
		<%} 
	else 
	{

		String username=(String) session.getAttribute("userid");		
		String filename=(String) session.getAttribute("fname");
		String dname=(String) session.getAttribute("dirname");

		String key = request.getParameter("EnPkey");
		String ext = request.getParameter("ext");
		ext=ext.substring(ext.lastIndexOf(".") + 1);
		int rounds= Integer.parseInt(request.getParameter("mode"));
		 	
		//get n and d from db
		database dobj=new database();
		String enn="";
		String dee="";
		ResultSet rs;
		try
		{
			 if (!dobj.connect("localhost","HADES","root","toor"))
				out.println("Database Connection Refused!");
		rs=dobj.select("select n,d from members where uname='"+username+"';");
		while(rs.next())
			{
				enn=rs.getString("n");
				dee=rs.getString("d");
			}
		}
		catch(SQLException e1)
		{
		out.println(e1);
		}

		BigInteger c=new BigInteger(key);	//convert to BI
		BigInteger d=new BigInteger(dee);
		BigInteger n=new BigInteger(enn);

		BigInteger Deckey=RsaFunctionClass.EncDec(c, d,n);	//UNHANDLED>> make regex seq for key in EncDec fxn 
	
		key=Deckey.toString();

		EncDec obj=new EncDec();
		obj.decrypt(filename,ext,dname,key,rounds);	
				
		File delorg =new File(dname+"/"+filename);		//delete uploaded
		delorg.delete();
	

			if (filename.contains("."))
				filename=filename.substring(0,filename.lastIndexOf("."));
				    
		%>
		<jsp:include page="header.jsp" />
		<div class="fullbody">
		<html>
		<head>
		 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>HADES Decryption Successful</title>
		<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
		</head>

			<%
			String DecFname = filename+"."+ext;
			session.setAttribute("fname",DecFname);
			session.setAttribute("dirname",dname);
			%>

		<br /><h2>File DECRYPTION Successful! Decrypted File: <b>"<%=DecFname%>"</b>. </h2> <br/><br/><br/>

		<form action="DownloadServlet.jsp" method="post">
		<br />Download Your Decrypted File:<br /><br />
		<input type="radio" name="Dbutton" value="Efile" checked >Decrypted File "<%=DecFname%>"
		<br/> <br />
		<input type="submit" value="Download">
		</form>
		<form action="home.jsp" method="post">
		<input type="submit" name="Dbutton" value="Back to Home">			
		</form>

		</html>
		</div>
		<jsp:include page="footer.jsp" />
	<%
	}	//close else of(if logged in)

}	//close(else) --session expiry
%>


