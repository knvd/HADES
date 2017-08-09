<%@ page import="hadesED.*"%>
<%@ page import ="java.sql.*" %>

<%@ page import ="java.io.FileInputStream" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>

<%!
   public boolean download(HttpServletResponse response,String fname, String dirname)
   {
    
String filename = fname; 
String filepath = dirname;

try{
response.setContentType("text/html");
PrintWriter ot = response.getWriter();  
  response.setContentType("APPLICATION/OCTET-STREAM");
	 
  response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);  
            
  int i;   
  while ((i=fileInputStream.read()) != -1) {  
    ot.write(i);   
  }

  fileInputStream.close(); 
ot.close();  
}
catch(IOException e)
{

}  
 return true;
   }
%>


<%
String uname= (String)session.getAttribute("userid");
if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) 
{ %>
			<jsp:include page="loginpage.jsp" />
<%} 
else 
{
String curUser= (String)session.getAttribute("userid");
database dobj=new database();

	ResultSet rs;
		
	try
	{
	if (!dobj.connect("localhost","HADES","root","toor"))
		out.println("Database Connection Refused!");
	int total=dobj.count("select * from messages where reciever='"+curUser+"';");

	String sender="",subject="";
	String [] file=new String[total];
	String [] tfile=new String[total];
	String [] edir=new String[total];
	String [] txtdir=new String[total];


	if(total>0)
		{%>
			<jsp:include page="header.jsp" />
			<div class="fullbody">
			<html>
			<head>
			 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title><%=curUser%>'s Inbox</title>
			<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
			</head>
			<body>

			<center>
			<div style=" margin-left: 100px;"> <a style="text-align: left; color: #ff3300; "><h2> <%=curUser%>'s Inbox</h2></a></div>
			
			<table style="width: 85%;">
			
			<thead align="center"><tr><td><a style="color: #02c2f7; font-size: 150%;"><u>#</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>FROM:</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Subject</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Files</u></a></td></tr></thead>
			<tr><td></td><td></td><td></td><td><a target="_new" href="outbox.jsp" style="color: #ff3300; text-align: right;"><h2><u>MY OUTBOX</u></h2></a></td></tr>



		<%

			rs=dobj.select("select sender,subject,file,tfile,edir,txtdir from messages where reciever='"+curUser+"';");
			int sno=0;
			while(rs.next())
				{
				sender=rs.getString("sender");
				subject=rs.getString("subject");
				file[sno]=rs.getString("file");
				tfile[sno]=rs.getString("tfile");
				edir[sno]=rs.getString("edir");
				txtdir[sno]=rs.getString("txtdir");
				sno++;
				%>

<%!
   public boolean dwnld(HttpServletRequest request,HttpServletResponse response,int sno)
   {	String efile= request.getParameter("ftxt"+sno);
	String dir= request.getParameter("dtxt"+sno);   
	download(response,efile,dir);
return true;
}
%>

			<tr align="center">
			<td style="font-size: 120%; color: #000000;"><%=sno%> </td><td style="font-size: 140%; color: #ff3300;;"><%=sender%> </td> <td><%=subject%></td>
<td>


<%String folder=txtdir[sno-1].toString();
folder=folder.substring(folder.indexOf("users"), folder.length());
//String dr=edir[sno-1].toString();
//dr=dr.substring(dr.indexOf("users"), dr.length());
//String fn=file[sno-1].toString();
%>
<a target="_new" href="<%=folder+tfile[sno-1].toString()%>"> View Key Details</a><br /><br />
<a target="_new" href="<%//=download(response,fn,dr)%>"> Download File</a>	

<input type="text" id="filebox" name="ftxt<%=sno%>" display="none" value="<%=file[sno-1].toString()%>" readonly style="display: none;"/>
<input type="text" id="dirbox" name="dtxt<%=sno%>" display="none" value="<%=edir[sno-1].toString()%>" readonly  style="display: none;"/>

</td><br /> 
			</tr>
<%
				}//end of while				
%>
			</table>
			</center> 
			</body>
			</html>
		<jsp:include page="footer.jsp" />
<%
}//close if
else		//if(tot)
{%>
<script>
alert("<%=curUser%>'s Inbox is Empty");
</script>
<jsp:include page="header.jsp" />
<div class="fullbody">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=curUser%>'s Inbox is Empty</title>
<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
</head>
<body>
<center>
<a style="text-align: left; color: #ff3300; "><h2> <%=curUser%>'s Inbox</h2></a>			
<table style="width: 80%;">
<thead align="center"><tr><td><a style="color: #02c2f7; font-size: 150%;"><u>FROM:</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Subject</u></a></td><td><a style="color: #02c2f7; font-size: 150%;"><u>Files</u></a></td></tr></thead>
<tr><td></td><td></td><td></td><td><a target="_new" href="outbox.jsp" style="color: #ff3300; text-align: right;"><h2><u>MY OUTBOX</u></h2></a></td></tr>

<tr ><td align="center"><h2>No One has Messaged You Yet! <br /><a href="home.jsp"> Back To Home</a></h2></td> </tr>
</table>
</center> 
</body>
</html>
<jsp:include page="footer.jsp" />

<%}	//close else
}	//try block
catch(SQLException e1)
{
out.println(e1);
}


}
%>
